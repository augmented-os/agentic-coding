-- Migration file 006: Constraints
-- Description: Adds additional constraints for data integrity

-- Ensure email addresses are unique within a tenant
ALTER TABLE users 
ADD CONSTRAINT unique_email_per_tenant UNIQUE (tenant_id, email);

-- Ensure host names are unique within a tenant
ALTER TABLE hosts 
ADD CONSTRAINT unique_host_name_per_tenant UNIQUE (tenant_id, name);

-- Ensure rental names are unique within a host
ALTER TABLE rentals 
ADD CONSTRAINT unique_rental_name_per_host UNIQUE (host_id, name);

-- Ensure supplier names are unique within a tenant
ALTER TABLE suppliers 
ADD CONSTRAINT unique_supplier_name_per_tenant UNIQUE (tenant_id, name);

-- Ensure account codes are unique per tenant
ALTER TABLE xero_account_codes 
ADD CONSTRAINT unique_account_code_per_tenant UNIQUE (tenant_id, code);

-- Ensure tracking category names are unique per tenant
ALTER TABLE xero_tracking_categories 
ADD CONSTRAINT unique_tracking_category_per_tenant UNIQUE (tenant_id, name);

-- Make sure the name column exists
DO $$
BEGIN
    IF NOT EXISTS (
        SELECT FROM information_schema.columns 
        WHERE table_name = 'xero_tracking_options' AND column_name = 'name'
    ) THEN
        ALTER TABLE xero_tracking_options ADD COLUMN name TEXT;
    END IF;
END $$;

-- Then add the constraint
ALTER TABLE xero_tracking_options 
ADD CONSTRAINT unique_tracking_option_per_category UNIQUE (tracking_category_id, name);

-- Ensure a receipt file hash is unique within a tenant
ALTER TABLE receipt_files 
ADD CONSTRAINT unique_file_hash_per_tenant UNIQUE (tenant_id, file_hash);

-- Ensure only one primary file per receipt
ALTER TABLE receipt_files 
ADD CONSTRAINT one_primary_file_per_receipt 
CHECK (NOT is_primary OR (
    SELECT COUNT(*) FROM receipt_files rf2 
    WHERE rf2.receipt_id = receipt_id 
    AND rf2.is_primary = true AND rf2.id != id
) = 0);

-- Check for valid positive amounts on receipts
ALTER TABLE receipts 
ADD CONSTRAINT check_positive_receipt_amounts 
CHECK (
    (gross_amount IS NULL OR gross_amount >= 0) AND
    (net_amount IS NULL OR net_amount >= 0) AND
    (tax_amount IS NULL OR tax_amount >= 0)
);

-- Check for valid positive amounts on line items
ALTER TABLE receipt_line_items 
ADD CONSTRAINT check_positive_line_item_amounts 
CHECK (
    (gross_amount IS NULL OR gross_amount >= 0) AND
    (net_amount IS NULL OR net_amount >= 0) AND
    (tax_amount IS NULL OR tax_amount >= 0)
);

-- Ensure payment date is not before issue date
ALTER TABLE receipts 
ADD CONSTRAINT payment_after_issue_date 
CHECK (payment_date IS NULL OR issue_date IS NULL OR payment_date >= issue_date);

-- Ensure email addresses are properly formatted
ALTER TABLE users 
ADD CONSTRAINT check_email_format 
CHECK (email ~* '^[A-Za-z0-9._%-]+@[A-Za-z0-9.-]+[.][A-Za-z]+$');

-- Ensure amounts are consistent (if all values are provided)
ALTER TABLE receipts 
ADD CONSTRAINT check_consistent_amounts 
CHECK (
    gross_amount IS NULL OR 
    net_amount IS NULL OR 
    tax_amount IS NULL OR 
    ABS(gross_amount - (net_amount + tax_amount)) < 0.01
);

-- Ensure line item amounts are consistent (if all values are provided)
ALTER TABLE receipt_line_items 
ADD CONSTRAINT check_consistent_line_item_amounts 
CHECK (
    gross_amount IS NULL OR 
    net_amount IS NULL OR 
    tax_amount IS NULL OR 
    ABS(gross_amount - (net_amount + tax_amount)) < 0.01
); 