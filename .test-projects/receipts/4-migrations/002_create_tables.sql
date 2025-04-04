-- Migration file 002: Create tables
-- Description: Creates all core tables with basic structure and NOT NULL constraints

-- Tenants table
CREATE TABLE tenants (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name TEXT NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    active BOOLEAN NOT NULL DEFAULT TRUE,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Users table
CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    email TEXT NOT NULL,
    tenant_id UUID NOT NULL,
    user_role user_role NOT NULL DEFAULT 'client',
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    last_login TIMESTAMPTZ,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Hosts table
CREATE TABLE hosts (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    display_name TEXT NOT NULL,
    legal_name TEXT,
    tenant_id UUID NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    vat_registered BOOLEAN NOT NULL DEFAULT FALSE,
    xero_account_code UUID,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Rentals table
CREATE TABLE rentals (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name TEXT NOT NULL,
    tenant_id UUID NOT NULL,
    host_id UUID,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    active BOOLEAN NOT NULL DEFAULT TRUE,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    pms_id TEXT
);

-- Suppliers table
CREATE TABLE suppliers (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name TEXT NOT NULL,
    tenant_id UUID NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    vat_registered BOOLEAN NOT NULL DEFAULT FALSE,
    xero_account_code_default UUID,
    xero_contact_id UUID,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Xero account codes table
CREATE TABLE xero_account_codes (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    tenant_id UUID NOT NULL,
    code TEXT NOT NULL,
    name TEXT NOT NULL,
    xero_account_type xero_account_type NOT NULL,
    xero_account_class xero_account_class NOT NULL,
    xero_status xero_status NOT NULL DEFAULT 'ACTIVE',
    payments_enabled BOOLEAN NOT NULL DEFAULT FALSE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Xero tracking categories table
CREATE TABLE xero_tracking_categories (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    tenant_id UUID NOT NULL,
    name TEXT NOT NULL,
    xero_status xero_status NOT NULL DEFAULT 'ACTIVE',
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Xero tracking options table
CREATE TABLE xero_tracking_options (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    tenant_id UUID NOT NULL,
    tracking_category_id UUID NOT NULL,
    name TEXT NOT NULL,
    xero_status xero_status NOT NULL DEFAULT 'ACTIVE',
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Receipts table
CREATE TABLE receipts (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    tenant_id UUID NOT NULL,
    supplier_id UUID,
    reference TEXT,
    file_path TEXT,
    upload_date TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    issue_date DATE NOT NULL DEFAULT CURRENT_DATE,
    accrual_date DATE,
    due_date DATE,
    gross_amount NUMERIC,
    vat_amount NUMERIC,
    net_amount NUMERIC,
    receipt_status receipt_status NOT NULL DEFAULT 'new',
    receipt_state receipt_state NOT NULL DEFAULT 'extract_details',
    processed_by UUID,
    processed_date TIMESTAMPTZ,
    payment_date DATE,
    payment_account UUID,
    notes TEXT,
    xero_invoice_no TEXT,
    xero_invoice_id UUID,
    xero_payment_id UUID,
    xero_payload JSON,
    xero_account_id_payment UUID,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Receipt files table
CREATE TABLE receipt_files (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    tenant_id UUID NOT NULL,
    receipt_id UUID,
    file_path TEXT NOT NULL,
    file_name TEXT NOT NULL,
    file_type TEXT NOT NULL,
    file_size INTEGER NOT NULL,
    file_hash TEXT NOT NULL,
    upload_date TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    upload_source upload_source NOT NULL DEFAULT 'webapp',
    uploaded_by UUID,
    is_primary BOOLEAN NOT NULL DEFAULT FALSE,
    file_status file_status NOT NULL DEFAULT 'active',
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Receipt line items table
CREATE TABLE receipt_line_items (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    receipt_id UUID NOT NULL,
    receipt_type receipt_type,
    description TEXT,
    gross_amount NUMERIC,
    vat_rate NUMERIC,
    vat_amount NUMERIC,
    net_amount NUMERIC,
    xero_account_code UUID,
    rental_id UUID,
    xero_tracking_option_id_property UUID,
    xero_tracking_option_id_type UUID,
    tenant_id UUID NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
); 