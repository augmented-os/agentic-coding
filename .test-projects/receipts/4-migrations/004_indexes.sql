-- Migration file 004: Indexes
-- Description: Creates indexes on commonly queried fields for performance

-- Tenant-level indexes
CREATE INDEX idx_users_tenant_id ON users(tenant_id);
CREATE INDEX idx_hosts_tenant_id ON hosts(tenant_id);
CREATE INDEX idx_rentals_tenant_id ON rentals(tenant_id);
CREATE INDEX idx_suppliers_tenant_id ON suppliers(tenant_id);
CREATE INDEX idx_receipts_tenant_id ON receipts(tenant_id);
CREATE INDEX idx_receipt_files_tenant_id ON receipt_files(tenant_id);
CREATE INDEX idx_receipt_line_items_tenant_id ON receipt_line_items(tenant_id);
CREATE INDEX idx_xero_account_codes_tenant_id ON xero_account_codes(tenant_id);
CREATE INDEX idx_xero_tracking_categories_tenant_id ON xero_tracking_categories(tenant_id);
CREATE INDEX idx_xero_tracking_options_tenant_id ON xero_tracking_options(tenant_id);

-- User indexes
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_user_role ON users(user_role);

-- Host and rental indexes
CREATE INDEX idx_rentals_host_id ON rentals(host_id);
CREATE INDEX idx_rentals_active ON rentals(active);

-- Receipt indexes
CREATE INDEX idx_receipts_supplier_id ON receipts(supplier_id);
CREATE INDEX idx_receipts_receipt_status ON receipts(receipt_status);
CREATE INDEX idx_receipts_issue_date ON receipts(issue_date);
CREATE INDEX idx_receipts_processed_by ON receipts(processed_by);
CREATE INDEX idx_receipts_upload_date ON receipts(upload_date);
CREATE INDEX idx_receipts_payment_date ON receipts(payment_date);

-- Receipt files indexes
CREATE INDEX idx_receipt_files_receipt_id ON receipt_files(receipt_id);
CREATE INDEX idx_receipt_files_file_hash ON receipt_files(file_hash);
CREATE INDEX idx_receipt_files_uploaded_by ON receipt_files(uploaded_by);
CREATE INDEX idx_receipt_files_upload_date ON receipt_files(upload_date);
CREATE INDEX idx_receipt_files_file_status ON receipt_files(file_status);
CREATE INDEX idx_receipt_files_is_primary ON receipt_files(is_primary);

-- Receipt line items indexes
CREATE INDEX idx_receipt_line_items_receipt_id ON receipt_line_items(receipt_id);
CREATE INDEX idx_receipt_line_items_rental_id ON receipt_line_items(rental_id);
CREATE INDEX idx_receipt_line_items_xero_account_code ON receipt_line_items(xero_account_code);

-- Xero-related indexes
CREATE INDEX idx_xero_account_codes_code ON xero_account_codes(code);
CREATE INDEX idx_xero_tracking_options_category_id ON xero_tracking_options(tracking_category_id);

-- Composite indexes for common query patterns
CREATE INDEX idx_receipts_tenant_status ON receipts(tenant_id, receipt_status);
CREATE INDEX idx_receipts_tenant_date ON receipts(tenant_id, issue_date);
CREATE INDEX idx_receipt_files_tenant_receipt ON receipt_files(tenant_id, receipt_id);
CREATE INDEX idx_receipt_line_items_tenant_receipt ON receipt_line_items(tenant_id, receipt_id);
CREATE INDEX idx_users_tenant_role ON users(tenant_id, user_role); 