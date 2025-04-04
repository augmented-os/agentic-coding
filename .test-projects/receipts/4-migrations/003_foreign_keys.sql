-- Migration file 003: Foreign keys
-- Description: Adds foreign key constraints to all tables

-- Users table
ALTER TABLE users
    ADD CONSTRAINT fk_users_tenant
    FOREIGN KEY (tenant_id) REFERENCES tenants(id)
    ON DELETE RESTRICT ON UPDATE CASCADE;

-- Hosts table
ALTER TABLE hosts
    ADD CONSTRAINT fk_hosts_tenant
    FOREIGN KEY (tenant_id) REFERENCES tenants(id)
    ON DELETE RESTRICT ON UPDATE CASCADE,
    ADD CONSTRAINT fk_hosts_xero_account_code
    FOREIGN KEY (xero_account_code) REFERENCES xero_account_codes(id)
    ON DELETE SET NULL ON UPDATE CASCADE;

-- Rentals table
ALTER TABLE rentals
    ADD CONSTRAINT fk_rentals_tenant
    FOREIGN KEY (tenant_id) REFERENCES tenants(id)
    ON DELETE RESTRICT ON UPDATE CASCADE,
    ADD CONSTRAINT fk_rentals_host
    FOREIGN KEY (host_id) REFERENCES hosts(id)
    ON DELETE RESTRICT ON UPDATE CASCADE;

-- Suppliers table
ALTER TABLE suppliers
    ADD CONSTRAINT fk_suppliers_tenant
    FOREIGN KEY (tenant_id) REFERENCES tenants(id)
    ON DELETE RESTRICT ON UPDATE CASCADE,
    ADD CONSTRAINT fk_suppliers_xero_account_code
    FOREIGN KEY (xero_account_code_default) REFERENCES xero_account_codes(id)
    ON DELETE SET NULL ON UPDATE CASCADE;

-- Xero account codes table
ALTER TABLE xero_account_codes
    ADD CONSTRAINT fk_xero_account_codes_tenant
    FOREIGN KEY (tenant_id) REFERENCES tenants(id)
    ON DELETE RESTRICT ON UPDATE CASCADE;

-- Xero tracking categories table
ALTER TABLE xero_tracking_categories
    ADD CONSTRAINT fk_xero_tracking_categories_tenant
    FOREIGN KEY (tenant_id) REFERENCES tenants(id)
    ON DELETE RESTRICT ON UPDATE CASCADE;

-- Xero tracking options table
ALTER TABLE xero_tracking_options
    ADD CONSTRAINT fk_xero_tracking_options_tenant
    FOREIGN KEY (tenant_id) REFERENCES tenants(id)
    ON DELETE RESTRICT ON UPDATE CASCADE,
    ADD CONSTRAINT fk_xero_tracking_options_category
    FOREIGN KEY (tracking_category_id) REFERENCES xero_tracking_categories(id)
    ON DELETE CASCADE ON UPDATE CASCADE;

-- Receipts table
ALTER TABLE receipts
    ADD CONSTRAINT fk_receipts_tenant
    FOREIGN KEY (tenant_id) REFERENCES tenants(id)
    ON DELETE RESTRICT ON UPDATE CASCADE,
    ADD CONSTRAINT fk_receipts_supplier
    FOREIGN KEY (supplier_id) REFERENCES suppliers(id)
    ON DELETE RESTRICT ON UPDATE CASCADE,
    ADD CONSTRAINT fk_receipts_processor
    FOREIGN KEY (processed_by) REFERENCES users(id)
    ON DELETE SET NULL ON UPDATE CASCADE,
    ADD CONSTRAINT fk_receipts_payment_account
    FOREIGN KEY (payment_account) REFERENCES xero_account_codes(id)
    ON DELETE SET NULL ON UPDATE CASCADE,
    ADD CONSTRAINT fk_receipts_account_id_payment
    FOREIGN KEY (xero_account_id_payment) REFERENCES xero_account_codes(id)
    ON DELETE SET NULL ON UPDATE CASCADE;

-- Receipt files table
ALTER TABLE receipt_files
    ADD CONSTRAINT fk_receipt_files_tenant
    FOREIGN KEY (tenant_id) REFERENCES tenants(id)
    ON DELETE RESTRICT ON UPDATE CASCADE,
    ADD CONSTRAINT fk_receipt_files_receipt
    FOREIGN KEY (receipt_id) REFERENCES receipts(id)
    ON DELETE SET NULL ON UPDATE CASCADE,
    ADD CONSTRAINT fk_receipt_files_uploader
    FOREIGN KEY (uploaded_by) REFERENCES users(id)
    ON DELETE SET NULL ON UPDATE CASCADE;

-- Receipt line items table
ALTER TABLE receipt_line_items
    ADD CONSTRAINT fk_receipt_line_items_tenant
    FOREIGN KEY (tenant_id) REFERENCES tenants(id)
    ON DELETE RESTRICT ON UPDATE CASCADE,
    ADD CONSTRAINT fk_receipt_line_items_receipt
    FOREIGN KEY (receipt_id) REFERENCES receipts(id)
    ON DELETE CASCADE ON UPDATE CASCADE,
    ADD CONSTRAINT fk_receipt_line_items_account_code
    FOREIGN KEY (xero_account_code) REFERENCES xero_account_codes(id)
    ON DELETE RESTRICT ON UPDATE CASCADE,
    ADD CONSTRAINT fk_receipt_line_items_rental
    FOREIGN KEY (rental_id) REFERENCES rentals(id)
    ON DELETE RESTRICT ON UPDATE CASCADE,
    ADD CONSTRAINT fk_receipt_line_items_tracking_property
    FOREIGN KEY (xero_tracking_option_id_property) REFERENCES xero_tracking_options(id)
    ON DELETE SET NULL ON UPDATE CASCADE,
    ADD CONSTRAINT fk_receipt_line_items_tracking_type
    FOREIGN KEY (xero_tracking_option_id_type) REFERENCES xero_tracking_options(id)
    ON DELETE SET NULL ON UPDATE CASCADE; 