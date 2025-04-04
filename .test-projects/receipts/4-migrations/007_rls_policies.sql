-- Migration file 007: Row-Level Security Policies
-- Description: Implements Row-Level Security policies for tenant isolation and role-based access

-- Enable RLS on all tables
ALTER TABLE tenants ENABLE ROW LEVEL SECURITY;
ALTER TABLE users ENABLE ROW LEVEL SECURITY;
ALTER TABLE hosts ENABLE ROW LEVEL SECURITY;
ALTER TABLE rentals ENABLE ROW LEVEL SECURITY;
ALTER TABLE suppliers ENABLE ROW LEVEL SECURITY;
ALTER TABLE xero_account_codes ENABLE ROW LEVEL SECURITY;
ALTER TABLE xero_tracking_categories ENABLE ROW LEVEL SECURITY;
ALTER TABLE xero_tracking_options ENABLE ROW LEVEL SECURITY;
ALTER TABLE receipts ENABLE ROW LEVEL SECURITY;
ALTER TABLE receipt_files ENABLE ROW LEVEL SECURITY;
ALTER TABLE receipt_line_items ENABLE ROW LEVEL SECURITY;

-- Create tenant isolation policies
-- Users can only see data from their own tenant

-- Tenants table policy
CREATE POLICY tenant_isolation_policy ON tenants
    USING (id = (SELECT tenant_id FROM users WHERE id = auth.uid()));

-- Users table policy
CREATE POLICY tenant_isolation_policy ON users
    USING (tenant_id = (SELECT tenant_id FROM users WHERE id = auth.uid()));

-- Hosts table policy
CREATE POLICY tenant_isolation_policy ON hosts
    USING (tenant_id = (SELECT tenant_id FROM users WHERE id = auth.uid()));

-- Rentals table policy
CREATE POLICY tenant_isolation_policy ON rentals
    USING (
        host_id IN (
            SELECT id FROM hosts 
            WHERE tenant_id = (SELECT tenant_id FROM users WHERE id = auth.uid())
        )
    );

-- Suppliers table policy
CREATE POLICY tenant_isolation_policy ON suppliers
    USING (tenant_id = (SELECT tenant_id FROM users WHERE id = auth.uid()));

-- Xero account codes table policy
CREATE POLICY tenant_isolation_policy ON xero_account_codes
    USING (tenant_id = (SELECT tenant_id FROM users WHERE id = auth.uid()));

-- Xero tracking categories table policy
CREATE POLICY tenant_isolation_policy ON xero_tracking_categories
    USING (tenant_id = (SELECT tenant_id FROM users WHERE id = auth.uid()));

-- Xero tracking options table policy
CREATE POLICY tenant_isolation_policy ON xero_tracking_options
    USING (
        tracking_category_id IN (
            SELECT id FROM xero_tracking_categories 
            WHERE tenant_id = (SELECT tenant_id FROM users WHERE id = auth.uid())
        )
    );

-- Receipts table policy
CREATE POLICY tenant_isolation_policy ON receipts
    USING (tenant_id = (SELECT tenant_id FROM users WHERE id = auth.uid()));

-- Receipt files table policy
CREATE POLICY tenant_isolation_policy ON receipt_files
    USING (tenant_id = (SELECT tenant_id FROM users WHERE id = auth.uid()));

-- Receipt line items table policy
CREATE POLICY tenant_isolation_policy ON receipt_line_items
    USING (tenant_id = (SELECT tenant_id FROM users WHERE id = auth.uid()));

-- Role-based access control policies

-- Admin can do everything within their tenant
CREATE POLICY admin_all_access ON users
    FOR ALL
    USING (
        tenant_id = (SELECT tenant_id FROM users WHERE id = auth.uid())
        AND (SELECT user_role FROM users WHERE id = auth.uid()) = 'admin'
    );

CREATE POLICY admin_all_access ON hosts
    FOR ALL
    USING (
        tenant_id = (SELECT tenant_id FROM users WHERE id = auth.uid())
        AND (SELECT user_role FROM users WHERE id = auth.uid()) = 'admin'
    );

CREATE POLICY admin_all_access ON rentals
    FOR ALL
    USING (
        host_id IN (
            SELECT id FROM hosts 
            WHERE tenant_id = (SELECT tenant_id FROM users WHERE id = auth.uid())
        )
        AND (SELECT user_role FROM users WHERE id = auth.uid()) = 'admin'
    );

CREATE POLICY admin_all_access ON suppliers
    FOR ALL
    USING (
        tenant_id = (SELECT tenant_id FROM users WHERE id = auth.uid())
        AND (SELECT user_role FROM users WHERE id = auth.uid()) = 'admin'
    );

CREATE POLICY admin_all_access ON xero_account_codes
    FOR ALL
    USING (
        tenant_id = (SELECT tenant_id FROM users WHERE id = auth.uid())
        AND (SELECT user_role FROM users WHERE id = auth.uid()) = 'admin'
    );

CREATE POLICY admin_all_access ON xero_tracking_categories
    FOR ALL
    USING (
        tenant_id = (SELECT tenant_id FROM users WHERE id = auth.uid())
        AND (SELECT user_role FROM users WHERE id = auth.uid()) = 'admin'
    );

CREATE POLICY admin_all_access ON xero_tracking_options
    FOR ALL
    USING (
        tracking_category_id IN (
            SELECT id FROM xero_tracking_categories 
            WHERE tenant_id = (SELECT tenant_id FROM users WHERE id = auth.uid())
        )
        AND (SELECT user_role FROM users WHERE id = auth.uid()) = 'admin'
    );

CREATE POLICY admin_all_access ON receipts
    FOR ALL
    USING (
        tenant_id = (SELECT tenant_id FROM users WHERE id = auth.uid())
        AND (SELECT user_role FROM users WHERE id = auth.uid()) = 'admin'
    );

CREATE POLICY admin_all_access ON receipt_files
    FOR ALL
    USING (
        tenant_id = (SELECT tenant_id FROM users WHERE id = auth.uid())
        AND (SELECT user_role FROM users WHERE id = auth.uid()) = 'admin'
    );

CREATE POLICY admin_all_access ON receipt_line_items
    FOR ALL
    USING (
        tenant_id = (SELECT tenant_id FROM users WHERE id = auth.uid())
        AND (SELECT user_role FROM users WHERE id = auth.uid()) = 'admin'
    );

-- Manager can view everything and edit most things except user management
CREATE POLICY manager_access ON users
    FOR SELECT
    USING (
        tenant_id = (SELECT tenant_id FROM users WHERE id = auth.uid())
        AND (SELECT user_role FROM users WHERE id = auth.uid()) = 'manager'
    );

CREATE POLICY manager_access ON hosts
    FOR ALL
    USING (
        tenant_id = (SELECT tenant_id FROM users WHERE id = auth.uid())
        AND (SELECT user_role FROM users WHERE id = auth.uid()) = 'manager'
    );

CREATE POLICY manager_access ON rentals
    FOR ALL
    USING (
        host_id IN (
            SELECT id FROM hosts 
            WHERE tenant_id = (SELECT tenant_id FROM users WHERE id = auth.uid())
        )
        AND (SELECT user_role FROM users WHERE id = auth.uid()) = 'manager'
    );

CREATE POLICY manager_access ON suppliers
    FOR ALL
    USING (
        tenant_id = (SELECT tenant_id FROM users WHERE id = auth.uid())
        AND (SELECT user_role FROM users WHERE id = auth.uid()) = 'manager'
    );

CREATE POLICY manager_access ON xero_account_codes
    FOR ALL
    USING (
        tenant_id = (SELECT tenant_id FROM users WHERE id = auth.uid())
        AND (SELECT user_role FROM users WHERE id = auth.uid()) = 'manager'
    );

CREATE POLICY manager_access ON xero_tracking_categories
    FOR ALL
    USING (
        tenant_id = (SELECT tenant_id FROM users WHERE id = auth.uid())
        AND (SELECT user_role FROM users WHERE id = auth.uid()) = 'manager'
    );

CREATE POLICY manager_access ON xero_tracking_options
    FOR ALL
    USING (
        tracking_category_id IN (
            SELECT id FROM xero_tracking_categories 
            WHERE tenant_id = (SELECT tenant_id FROM users WHERE id = auth.uid())
        )
        AND (SELECT user_role FROM users WHERE id = auth.uid()) = 'manager'
    );

CREATE POLICY manager_access ON receipts
    FOR ALL
    USING (
        tenant_id = (SELECT tenant_id FROM users WHERE id = auth.uid())
        AND (SELECT user_role FROM users WHERE id = auth.uid()) = 'manager'
    );

CREATE POLICY manager_access ON receipt_files
    FOR ALL
    USING (
        tenant_id = (SELECT tenant_id FROM users WHERE id = auth.uid())
        AND (SELECT user_role FROM users WHERE id = auth.uid()) = 'manager'
    );

CREATE POLICY manager_access ON receipt_line_items
    FOR ALL
    USING (
        tenant_id = (SELECT tenant_id FROM users WHERE id = auth.uid())
        AND (SELECT user_role FROM users WHERE id = auth.uid()) = 'manager'
    );

-- Staff can view everything but only edit receipts and related items
CREATE POLICY staff_view_access ON users
    FOR SELECT
    USING (
        tenant_id = (SELECT tenant_id FROM users WHERE id = auth.uid())
        AND (SELECT user_role FROM users WHERE id = auth.uid()) = 'staff'
    );

CREATE POLICY staff_view_access ON hosts
    FOR SELECT
    USING (
        tenant_id = (SELECT tenant_id FROM users WHERE id = auth.uid())
        AND (SELECT user_role FROM users WHERE id = auth.uid()) = 'staff'
    );

CREATE POLICY staff_view_access ON rentals
    FOR SELECT
    USING (
        host_id IN (
            SELECT id FROM hosts 
            WHERE tenant_id = (SELECT tenant_id FROM users WHERE id = auth.uid())
        )
        AND (SELECT user_role FROM users WHERE id = auth.uid()) = 'staff'
    );

CREATE POLICY staff_view_access ON suppliers
    FOR SELECT
    USING (
        tenant_id = (SELECT tenant_id FROM users WHERE id = auth.uid())
        AND (SELECT user_role FROM users WHERE id = auth.uid()) = 'staff'
    );

CREATE POLICY staff_view_access ON xero_account_codes
    FOR SELECT
    USING (
        tenant_id = (SELECT tenant_id FROM users WHERE id = auth.uid())
        AND (SELECT user_role FROM users WHERE id = auth.uid()) = 'staff'
    );

CREATE POLICY staff_view_access ON xero_tracking_categories
    FOR SELECT
    USING (
        tenant_id = (SELECT tenant_id FROM users WHERE id = auth.uid())
        AND (SELECT user_role FROM users WHERE id = auth.uid()) = 'staff'
    );

CREATE POLICY staff_view_access ON xero_tracking_options
    FOR SELECT
    USING (
        tracking_category_id IN (
            SELECT id FROM xero_tracking_categories 
            WHERE tenant_id = (SELECT tenant_id FROM users WHERE id = auth.uid())
        )
        AND (SELECT user_role FROM users WHERE id = auth.uid()) = 'staff'
    );

-- Staff can edit receipts
CREATE POLICY staff_edit_receipts ON receipts
    FOR ALL
    USING (
        tenant_id = (SELECT tenant_id FROM users WHERE id = auth.uid())
        AND (SELECT user_role FROM users WHERE id = auth.uid()) = 'staff'
    );

CREATE POLICY staff_edit_receipt_files ON receipt_files
    FOR ALL
    USING (
        tenant_id = (SELECT tenant_id FROM users WHERE id = auth.uid())
        AND (SELECT user_role FROM users WHERE id = auth.uid()) = 'staff'
    );

CREATE POLICY staff_edit_receipt_line_items ON receipt_line_items
    FOR ALL
    USING (
        tenant_id = (SELECT tenant_id FROM users WHERE id = auth.uid())
        AND (SELECT user_role FROM users WHERE id = auth.uid()) = 'staff'
    ); 