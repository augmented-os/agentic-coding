-- Migration file 009: Storage Policies
-- Description: Configures Row-Level Security policies for Storage buckets

-- Create a storage bucket for receipt files
INSERT INTO storage.buckets (id, name, public)
VALUES ('receipt_files', 'Receipt Files', false);

-- Enable RLS on the storage bucket
ALTER TABLE storage.objects ENABLE ROW LEVEL SECURITY;

-- Create policy for tenants to access only their own files
-- This policy uses the file path pattern /tenant_id/receipt_id/file_name
CREATE POLICY tenant_isolation_policy ON storage.objects
    FOR ALL
    USING (
        -- Extract tenant_id from path (first segment of path)
        REGEXP_SPLIT_TO_ARRAY(storage.foldername(name), '/')[1]::UUID = 
        (SELECT tenant_id FROM auth.users WHERE id = auth.uid()) OR
        -- Allow access to public files (if needed)
        bucket_id = 'public'
    );

-- Function to validate and set file path based on tenant
CREATE OR REPLACE FUNCTION storage.set_tenant_file_path()
RETURNS TRIGGER AS $$
DECLARE
    user_tenant_id UUID;
    path_tenant_id UUID;
    path_segments TEXT[];
BEGIN
    -- Get the tenant_id of the current user
    SELECT tenant_id INTO user_tenant_id FROM auth.users WHERE id = auth.uid();
    
    -- Extract tenant_id from the path
    path_segments := REGEXP_SPLIT_TO_ARRAY(storage.foldername(NEW.name), '/');
    
    -- Validate tenant_id in path
    IF array_length(path_segments, 1) >= 1 THEN
        -- Try to convert first segment to UUID
        BEGIN
            path_tenant_id := path_segments[1]::UUID;
            
            -- Ensure the tenant_id in the path matches the user's tenant_id
            IF path_tenant_id != user_tenant_id THEN
                RAISE EXCEPTION 'Cannot store files in another tenant''s directory';
            END IF;
        EXCEPTION WHEN OTHERS THEN
            -- If the conversion fails or validation fails, set a proper path
            NEW.name := user_tenant_id || '/' || NEW.name;
        END;
    ELSE
        -- If no tenant_id in path, prepend it
        NEW.name := user_tenant_id || '/' || NEW.name;
    END IF;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create trigger for file upload path validation
CREATE TRIGGER set_tenant_file_path
BEFORE INSERT ON storage.objects
FOR EACH ROW
EXECUTE FUNCTION storage.set_tenant_file_path();

-- Function to update receipt_files table when a file is uploaded
CREATE OR REPLACE FUNCTION storage.handle_receipt_file_upload()
RETURNS TRIGGER AS $$
DECLARE
    user_id UUID;
    tenant_id UUID;
    receipt_id UUID;
    file_name TEXT;
    path_segments TEXT[];
    receipt_file_id UUID;
BEGIN
    -- Extract information from path
    path_segments := REGEXP_SPLIT_TO_ARRAY(storage.foldername(NEW.name), '/');
    
    -- Path format should be: tenant_id/receipt_id/file_name
    IF array_length(path_segments, 1) >= 2 THEN
        tenant_id := path_segments[1]::UUID;
        
        -- Check if second segment is a valid UUID (receipt_id)
        BEGIN
            receipt_id := path_segments[2]::UUID;
        EXCEPTION WHEN OTHERS THEN
            receipt_id := NULL;
        END;
        
        -- Get file name from path
        file_name := storage.filename(NEW.name);
        
        -- Get current user ID
        user_id := auth.uid();
        
        -- Create a new entry in receipt_files
        INSERT INTO receipt_files (
            tenant_id,
            receipt_id,
            file_name,
            file_size,
            file_type,
            file_hash,
            storage_path,
            uploaded_by,
            upload_date,
            upload_source,
            file_status
        ) VALUES (
            tenant_id,
            receipt_id,
            file_name,
            NEW.metadata->>'size',
            NEW.metadata->>'mimetype',
            NEW.metadata->>'hash',
            NEW.name,
            user_id,
            CURRENT_TIMESTAMP,
            'webapp',  -- Default to webapp, could be updated later
            'active'
        )
        RETURNING id INTO receipt_file_id;
        
        -- Store receipt_file_id in object metadata for reference
        UPDATE storage.objects
        SET metadata = jsonb_set(
            COALESCE(NEW.metadata, '{}'::jsonb),
            '{receipt_file_id}',
            to_jsonb(receipt_file_id)
        )
        WHERE id = NEW.id;
    END IF;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create trigger for file upload handling
CREATE TRIGGER handle_receipt_file_upload
AFTER INSERT ON storage.objects
FOR EACH ROW
WHEN (NEW.bucket_id = 'receipt_files')
EXECUTE FUNCTION storage.handle_receipt_file_upload();

-- Function to handle file deletion
CREATE OR REPLACE FUNCTION storage.handle_receipt_file_deletion()
RETURNS TRIGGER AS $$
BEGIN
    -- Update file status in receipt_files to 'deleted'
    UPDATE receipt_files
    SET file_status = 'deleted', updated_at = CURRENT_TIMESTAMP
    WHERE storage_path = OLD.name;
    
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

-- Create trigger for file deletion handling
CREATE TRIGGER handle_receipt_file_deletion
BEFORE DELETE ON storage.objects
FOR EACH ROW
WHEN (OLD.bucket_id = 'receipt_files')
EXECUTE FUNCTION storage.handle_receipt_file_deletion(); 