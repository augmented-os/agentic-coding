-- Migration file 008: Trigger Functions
-- Description: Creates trigger functions for automatic timestamp updates and validation

-- Function to update the updated_at timestamp automatically
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create triggers for all tables to update timestamps automatically
CREATE TRIGGER update_tenants_updated_at
BEFORE UPDATE ON tenants
FOR EACH ROW
EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_users_updated_at
BEFORE UPDATE ON users
FOR EACH ROW
EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_hosts_updated_at
BEFORE UPDATE ON hosts
FOR EACH ROW
EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_rentals_updated_at
BEFORE UPDATE ON rentals
FOR EACH ROW
EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_suppliers_updated_at
BEFORE UPDATE ON suppliers
FOR EACH ROW
EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_xero_account_codes_updated_at
BEFORE UPDATE ON xero_account_codes
FOR EACH ROW
EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_xero_tracking_categories_updated_at
BEFORE UPDATE ON xero_tracking_categories
FOR EACH ROW
EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_xero_tracking_options_updated_at
BEFORE UPDATE ON xero_tracking_options
FOR EACH ROW
EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_receipts_updated_at
BEFORE UPDATE ON receipts
FOR EACH ROW
EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_receipt_files_updated_at
BEFORE UPDATE ON receipt_files
FOR EACH ROW
EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_receipt_line_items_updated_at
BEFORE UPDATE ON receipt_line_items
FOR EACH ROW
EXECUTE FUNCTION update_updated_at_column();

-- Function to ensure tenant consistency across related records
CREATE OR REPLACE FUNCTION ensure_tenant_consistency()
RETURNS TRIGGER AS $$
DECLARE
    parent_tenant_id UUID;
BEGIN
    -- For receipt_files, ensure tenant_id matches the tenant_id of the related receipt
    IF TG_TABLE_NAME = 'receipt_files' AND NEW.receipt_id IS NOT NULL THEN
        SELECT tenant_id INTO parent_tenant_id FROM receipts WHERE id = NEW.receipt_id;
        IF NEW.tenant_id != parent_tenant_id THEN
            RAISE EXCEPTION 'Tenant ID must match the tenant ID of the related receipt';
        END IF;
    
    -- For receipt_line_items, ensure tenant_id matches the tenant_id of the related receipt
    ELSIF TG_TABLE_NAME = 'receipt_line_items' AND NEW.receipt_id IS NOT NULL THEN
        SELECT tenant_id INTO parent_tenant_id FROM receipts WHERE id = NEW.receipt_id;
        IF NEW.tenant_id != parent_tenant_id THEN
            RAISE EXCEPTION 'Tenant ID must match the tenant ID of the related receipt';
        END IF;
    
    -- For rentals, ensure host's tenant matches
    ELSIF TG_TABLE_NAME = 'rentals' AND NEW.host_id IS NOT NULL THEN
        SELECT tenant_id INTO parent_tenant_id FROM hosts WHERE id = NEW.host_id;
        IF NEW.tenant_id != parent_tenant_id THEN
            RAISE EXCEPTION 'Tenant ID must match the tenant ID of the related host';
        END IF;
        
    -- For xero_tracking_options, ensure category's tenant matches
    ELSIF TG_TABLE_NAME = 'xero_tracking_options' AND NEW.tracking_category_id IS NOT NULL THEN
        SELECT tenant_id INTO parent_tenant_id FROM xero_tracking_categories WHERE id = NEW.tracking_category_id;
        IF NEW.tenant_id != parent_tenant_id THEN
            RAISE EXCEPTION 'Tenant ID must match the tenant ID of the related tracking category';
        END IF;
    END IF;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create tenant consistency triggers
CREATE TRIGGER ensure_receipt_files_tenant_consistency
BEFORE INSERT OR UPDATE ON receipt_files
FOR EACH ROW
WHEN (NEW.receipt_id IS NOT NULL)
EXECUTE FUNCTION ensure_tenant_consistency();

CREATE TRIGGER ensure_receipt_line_items_tenant_consistency
BEFORE INSERT OR UPDATE ON receipt_line_items
FOR EACH ROW
WHEN (NEW.receipt_id IS NOT NULL)
EXECUTE FUNCTION ensure_tenant_consistency();

CREATE TRIGGER ensure_rentals_tenant_consistency
BEFORE INSERT OR UPDATE ON rentals
FOR EACH ROW
EXECUTE FUNCTION ensure_tenant_consistency();

CREATE TRIGGER ensure_xero_tracking_options_tenant_consistency
BEFORE INSERT OR UPDATE ON xero_tracking_options
FOR EACH ROW
EXECUTE FUNCTION ensure_tenant_consistency();

-- Function to validate and set tenant ID from authenticated user
CREATE OR REPLACE FUNCTION set_tenant_id_from_auth()
RETURNS TRIGGER AS $$
DECLARE
    user_tenant_id UUID;
BEGIN
    -- Get the tenant_id of the current user
    SELECT tenant_id INTO user_tenant_id FROM users WHERE id = auth.uid();
    
    -- Set the tenant_id if not already set
    IF NEW.tenant_id IS NULL THEN
        NEW.tenant_id := user_tenant_id;
    -- Verify that the provided tenant_id matches the user's tenant_id
    ELSIF NEW.tenant_id != user_tenant_id THEN
        RAISE EXCEPTION 'Cannot assign records to a different tenant';
    END IF;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create triggers for automatic tenant assignment
CREATE TRIGGER set_tenant_id_on_hosts
BEFORE INSERT ON hosts
FOR EACH ROW
EXECUTE FUNCTION set_tenant_id_from_auth();

CREATE TRIGGER set_tenant_id_on_suppliers
BEFORE INSERT ON suppliers
FOR EACH ROW
EXECUTE FUNCTION set_tenant_id_from_auth();

CREATE TRIGGER set_tenant_id_on_receipts
BEFORE INSERT ON receipts
FOR EACH ROW
EXECUTE FUNCTION set_tenant_id_from_auth();

CREATE TRIGGER set_tenant_id_on_receipt_files
BEFORE INSERT ON receipt_files
FOR EACH ROW
EXECUTE FUNCTION set_tenant_id_from_auth();

CREATE TRIGGER set_tenant_id_on_receipt_line_items
BEFORE INSERT ON receipt_line_items
FOR EACH ROW
EXECUTE FUNCTION set_tenant_id_from_auth();

CREATE TRIGGER set_tenant_id_on_xero_account_codes
BEFORE INSERT ON xero_account_codes
FOR EACH ROW
EXECUTE FUNCTION set_tenant_id_from_auth();

CREATE TRIGGER set_tenant_id_on_xero_tracking_categories
BEFORE INSERT ON xero_tracking_categories
FOR EACH ROW
EXECUTE FUNCTION set_tenant_id_from_auth(); 