# Technical Design Document

## Database Schema

The following schema outlines the database structure for the Receipt/Invoice Processing System prototype using Supabase.

### Enum Types

The following enum types will be defined in the database:

```sql
-- User roles
CREATE TYPE user_role AS ENUM ('admin', 'bookkeeper', 'client');

-- Receipt processing status
CREATE TYPE receipt_status AS ENUM ('new', 'in_progress', 'pending', 'completed');

-- File status
CREATE TYPE file_status AS ENUM ('active', 'archived', 'deleted');

-- Receipt type
CREATE TYPE receipt_type AS ENUM ('direct', 'disbursement');

-- Receipt workflow state (tracks which step in the 6-step workflow)
CREATE TYPE receipt_state AS ENUM (
  'extract_details',      -- Step 1: Extract Details
  'match_supplier',       -- Step 2: Match Supplier
  'assign_line_items',    -- Step 3: Assign Line Items
  'set_payment_details',  -- Step 4: Set Payment Details
  'push_to_xero',         -- Step 5: Push to Xero
  'complete'              -- Step 6: Complete
);

-- Xero account types
CREATE TYPE xero_account_type AS ENUM (
  'BANK', 'CURRENT', 'CURRLIAB', 'DEPRECIATN', 'DIRECTCOSTS', 
  'EQUITY', 'EXPENSE', 'FIXED', 'INVENTORY', 'LIABILITY', 
  'NONCURRENT', 'OTHERINCOME', 'OVERHEADS', 'PREPAYMENT', 
  'REVENUE', 'SALES', 'TERMLIAB'
);

-- Xero account classes
CREATE TYPE xero_account_class AS ENUM (
  'ASSET', 'EQUITY', 'EXPENSE', 'LIABILITY', 'REVENUE'
);

-- Xero status
CREATE TYPE xero_status AS ENUM ('ACTIVE', 'ARCHIVED');

-- Upload source types
CREATE TYPE upload_source AS ENUM ('email', 'webapp');
```

### Core Tables

#### `tenants`

Represents client organizations using the system.

| Column | Type | Constraints | Description |
|----|----|----|----|
| id | uuid | PK, NOT NULL | Primary key |
| name | text | NOT NULL | Tenant name |
| created_at | timestamptz | NOT NULL | Creation timestamp |
| active | boolean | NOT NULL | Active status |
| updated_at | timestamptz | NOT NULL | Last updated timestamp |

#### `users`

System users associated with tenants.

| Column | Type | Constraints | Description |
|----|----|----|----|
| id | uuid | PK, NOT NULL | Primary key |
| email | text | NOT NULL | User email |
| tenant_id | uuid | FK, NOT NULL | Foreign key to tenants |
| user_role | enum user_role | NOT NULL | User role (admin, bookkeeper, client) |
| created_at | timestamptz | NOT NULL | Creation timestamp |
| last_login | timestamptz |    | Last login timestamp |
| updated_at | timestamptz | NOT NULL | Last updated timestamp |

#### `rentals`

Individual rental properties.

| Column | Type | Constraints | Description |
|----|----|----|----|
| id | uuid | PK, NOT NULL | Primary key |
| name | text | NOT NULL | Property name |
| tenant_id | uuid | FK, NOT NULL | Foreign key to tenants |
| host_id | uuid | FK | Foreign key to hosts |
| created_at | timestamptz | NOT NULL | Creation timestamp |
| active | boolean | NOT NULL | Active status |
| updated_at | timestamptz | NOT NULL | Last updated timestamp |
| pms_id | text |    | External ID for PMS (format may vary) |

#### `hosts`

Property owners or managing entities.

| Column | Type | Constraints | Description |
|----|----|----|----|
| id | uuid | PK, NOT NULL | Primary key |
| display_name | text | NOT NULL | Host name |
| legal_name | text |    | Name of legal entity |
| tenant_id | uuid | FK, NOT NULL | Foreign key to tenants |
| created_at | timestamptz | NOT NULL | Creation timestamp |
| vat_registered | boolean | NOT NULL | VAT registration status |
| xero_account_code | uuid | FK | Foreign key to xero_account_codes |
| updated_at | timestamptz | NOT NULL | Last updated timestamp |

#### `suppliers`

Vendors supplying goods/services.

| Column | Type | Constraints | Description |
|----|----|----|----|
| id | uuid | PK, NOT NULL | Primary key |
| name | text | NOT NULL | Supplier name |
| tenant_id | uuid | FK, NOT NULL | Foreign key to tenants |
| created_at | timestamptz | NOT NULL | Creation timestamp |
| vat_registered | boolean | NOT NULL | VAT registration status |
| xero_account_code_default | uuid | FK | Foreign key to xero_account_codes for default account code |
| xero_contact_id | uuid |    | ID of Xero contact |
| updated_at | timestamptz | NOT NULL | Last updated timestamp |

#### `receipts`

Main receipt/invoice records.

| Column | Type | Constraints | Description |
|----|----|----|----|
| id | uuid | PK, NOT NULL | Primary key |
| tenant_id | uuid | FK, NOT NULL | Foreign key to tenants |
| supplier_id | uuid | FK | Foreign key to suppliers |
| reference | text |    | Receipt/invoice reference (E.g. INV-006) |
| file_path | text |    | Path to stored file |
| upload_date | timestamptz | NOT NULL | Upload timestamp |
| issue_date | date | NOT NULL | Receipt/invoice issue date |
| accrual_date | date |    | Date for accrual purposes |
| due_date | date |    | Payment due date |
| gross_amount | numeric |    | Total amount |
| vat_amount | numeric |    | VAT amount |
| net_amount | numeric |    | Net amount |
| receipt_status | enum receipt_status | NOT NULL | Processing status (new, in_progress, pending, completed) |
| receipt_state | enum receipt_state | NOT NULL | Current workflow step (extract_details, match_supplier, assign_line_items, set_payment_details, push_to_xero, complete) |
| processed_by | uuid | FK | Foreign key to users |
| processed_date | timestamptz |    | Processing timestamp |
| payment_date | date |    | Payment date |
| payment_account | uuid | FK | Foreign key to xero_account_codes |
| notes | text |    | Additional notes |
| xero_invoice_no | text |    | Xero invoice number (e.g. INV-123) |
| xero_invoice_id | uuid |    | Invoice ID in Xero |
| xero_payment_id | uuid |    | Payment ID in Xero |
| xero_payload | json |    | Xero JSON payload |
| xero_account_id_payment | uuid | FK | Foreign key to xero_account_id for payment |
| created_at | timestamptz | NOT NULL | Creation timestamp |
| updated_at | timestamptz | NOT NULL | Last updated timestamp |

#### `receipt_files`

Stores multiple files associated with a single receipt.

| Column | Type | Constraints | Description |
|----|----|----|----|
| id | uuid | PK, NOT NULL | Primary key |
| tenant_id | uuid | FK, NOT NULL | Foreign key to tenants |
| receipt_id | uuid | FK | Foreign key to receipts |
| file_path | text | NOT NULL | Path to stored file |
| file_name | text | NOT NULL | Original filename |
| file_type | text | NOT NULL | File MIME type (e.g., application/pdf) |
| file_size | integer | NOT NULL | File size in bytes |
| file_hash | text | NOT NULL | Hash of file contents for deduplication |
| upload_date | timestamptz | NOT NULL | Upload timestamp |
| upload_source | enum | NOT NULL | Upload source (email, webapp) |
| uploaded_by | uuid | FK | Foreign key to users |
| is_primary | boolean | NOT NULL | Whether this is the main file for the receipt |
| file_status | enum file_status | NOT NULL | Status (active, archived, deleted) |
| created_at | timestamptz | NOT NULL | Creation timestamp |
| updated_at | timestamptz | NOT NULL | Last updated timestamp |

#### `receipt_line_items`

Individual line items from receipts/invoices.

| Column | Type | Constraints | Description |
|----|----|----|----|
| id | uuid | PK, NOT NULL | Primary key |
| receipt_id | uuid | FK, NOT NULL | Foreign key to receipts |
| receipt_type | enum receipt_type |    | Receipt type (Direct, Disbursement) |
| description | text |    | Item description |
| gross_amount | numeric |    | Gross line item amount |
| vat_rate | numeric |    | VAT rate applied |
| vat_amount | numeric |    | VAT total |
| net_amount | numeric |    | Net line item amount |
| xero_account_code | uuid | FK | Foreign key to xero_account_codes |
| rental_id | uuid | FK | Foreign key to rentals |
| xero_tracking_option_id_property | uuid | FK | Foreign key to xero_tracking_option |
| xero_tracking_option_id_type | uuid | FK | Foreign key to xero_tracking_option |
| tenant_id | uuid | FK, NOT NULL | Foreign key to tenants |
| created_at | timestamptz | NOT NULL | Creation timestamp |
| updated_at | timestamptz | NOT NULL | Last updated timestamp |

#### `xero_account_codes`

Standard accounting codes.

| Column | Type | Constraints | Description |
|----|----|----|----|
| id | uuid | PK, NOT NULL | Primary key |
| tenant_id | uuid | FK, NOT NULL | Foreign key to tenants |
| code | text | NOT NULL | Account code |
| name | text | NOT NULL | Account name |
| xero_account_type | enum xero_account_type | NOT NULL | Xero account type (BANK, CURRENT, CURRLIAB, DEPRECIATN, DIRECTCOSTS, EQUITY, EXPENSE, FIXED, INVENTORY, LIABILITY, NONCURRENT, OTHERINCOME, OVERHEADS, PREPAYMENT, REVENUE, SALES, TERMLIAB) |
| xero_account_class | enum xero_account_class | NOT NULL | Xero account class (ASSET, EQUITY, EXPENSE, LIABILITY, REVENUE) |
| xero_status | enum xero_status | NOT NULL | Status (ACTIVE, ARCHIVED) |
| payments_enabled | bool | NOT NULL | Payments enabled (true/false) |
| created_at | timestamptz | NOT NULL | Creation timestamp |
| updated_at | timestamptz | NOT NULL | Last updated timestamp |

#### `xero_tracking_categories`

Options for tracking in Xero.

| Column | Type | Constraints | Description |
|----|----|----|----|
| id | uuid | PK, NOT NULL | Primary key |
| tenant_id | uuid | FK, NOT NULL | Foreign key to tenants |
| name | text | NOT NULL | Category name |
| xero_status | enum xero_status | NOT NULL | Status (ACTIVE, ARCHIVED) |
| created_at | timestamptz | NOT NULL | Creation timestamp |
| updated_at | timestamptz | NOT NULL | Last updated timestamp |

#### `xero_tracking_options`

Options for tracking in Xero.

| Column | Type | Constraints | Description |
|----|----|----|----|
| id | uuid | PK, NOT NULL | Primary key |
| tenant_id | uuid | FK, NOT NULL | Foreign key to tenants |
| tracking_category_id | uuid | FK, NOT NULL | Foreign key to xero_tracking_categories |
| name | text | NOT NULL | Option name |
| xero_status | enum xero_status | NOT NULL | Status (ACTIVE, ARCHIVED) |
| created_at | timestamptz | NOT NULL | Creation timestamp |
| updated_at | timestamptz | NOT NULL | Last updated timestamp |

### Automatic Timestamp Updates

All tables include `created_at` and `updated_at` columns that will be automatically maintained:

* `created_at`: Set to the current timestamp when a record is created
* `updated_at`: Updated to the current timestamp whenever a record is modified

These timestamps will be maintained using PostgreSQL triggers to ensure consistent behavior across the application.

### Additional Requirements for Migration Scripts

When converting this schema into migration scripts, the following additional details should be implemented:

#### 1. NOT NULL Constraints

All critical columns should have NOT NULL constraints, particularly:

* All primary keys
* All tenant_id foreign keys
* All created_at/updated_at timestamps
* All enum type columns
* Business-critical fields (e.g., supplier name, rental name, etc.)

#### 2. Foreign Key Constraints

Define the behavior for all foreign key relationships:

```sql
-- Example pattern
FOREIGN KEY (tenant_id) REFERENCES tenants(id) ON DELETE RESTRICT ON UPDATE CASCADE
```

Typical behaviors:

* ON DELETE RESTRICT for critical references (prevent deletion if referenced)
* ON DELETE CASCADE for dependent objects (e.g., deleting a receipt should cascade to its line items)
* ON UPDATE CASCADE for most relationships to propagate ID changes

#### 3. Default Values

Set appropriate default values:

* `created_at` and `updated_at`: CURRENT_TIMESTAMP
* Boolean fields: false
* Status enums: Initial state (e.g., 'new' for receipt_status)
* is_primary: false for receipt_files

#### 4. Check Constraints

Add check constraints to enforce data integrity:

```sql
-- Example: Ensure monetary values aren't negative
ALTER TABLE receipts ADD CONSTRAINT chk_positive_amounts 
  CHECK (gross_amount >= 0 AND net_amount >= 0 AND vat_amount >= 0);

-- Example: Ensure VAT calculation is correct
ALTER TABLE receipts ADD CONSTRAINT chk_vat_calculation
  CHECK (ABS(gross_amount - net_amount - vat_amount) < 0.01);
```

#### 5. Unique Constraints

Add unique constraints as needed:

* User email within a tenant
* References or identifiers that must be unique

```sql
-- Example
ALTER TABLE users ADD CONSTRAINT uq_user_email_tenant
  UNIQUE (email, tenant_id);
```

#### 6. Indexes

In addition to the indexes mentioned in the Implementation Considerations section:

* Add composite indexes for common query patterns
* Add indexes on all foreign keys
* Consider partial indexes for filtered queries (e.g., only active receipts)

```sql
-- Example composite index
CREATE INDEX idx_receipts_tenant_status ON receipts(tenant_id, receipt_status);
```

#### 7. Row-Level Security Policies

Implement all RLS policies as defined in the RLS section.

## Row-Level Security

Supabase provides Row-Level Security (RLS) that will be used to enforce tenant data isolation and role-based access control. The following policies will be implemented for each table.

### Helper Functions

First, let's create helper functions to check user roles:

```sql
-- Helper function to check if current user is admin or bookkeeper
CREATE OR REPLACE FUNCTION public.is_admin_or_bookkeeper()
RETURNS boolean AS $$
BEGIN
  RETURN (
    SELECT user_role IN ('admin', 'bookkeeper')
    FROM users
    WHERE id = auth.uid()
  );
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Helper function to check if current user is admin
CREATE OR REPLACE FUNCTION public.is_admin()
RETURNS boolean AS $$
BEGIN
  RETURN (
    SELECT user_role = 'admin'
    FROM users
    WHERE id = auth.uid()
  );
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Helper function to get current user's tenant_id
CREATE OR REPLACE FUNCTION public.get_user_tenant_id()
RETURNS uuid AS $$
BEGIN
  RETURN (
    SELECT tenant_id
    FROM users
    WHERE id = auth.uid()
  );
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
```

### RLS for `tenants` table

```sql
-- Enable RLS
ALTER TABLE tenants ENABLE ROW LEVEL SECURITY;

-- Admins can read/write their own tenant
CREATE POLICY tenant_admin_access ON tenants
  FOR ALL
  USING (
    id = get_user_tenant_id() AND is_admin()
  );

-- Bookkeepers can read their own tenant
CREATE POLICY tenant_bookkeeper_read ON tenants
  FOR SELECT
  USING (
    id = get_user_tenant_id() AND 
    (SELECT user_role FROM users WHERE id = auth.uid()) = 'bookkeeper'
  );

-- Clients have no access to tenants table
```

### RLS for `users` table

```sql
-- Enable RLS
ALTER TABLE users ENABLE ROW LEVEL SECURITY;

-- Admins can manage users in their tenant
CREATE POLICY users_admin_access ON users
  FOR ALL
  USING (
    tenant_id = get_user_tenant_id() AND is_admin()
  );

-- Bookkeepers can read users in their tenant
CREATE POLICY users_bookkeeper_read ON users
  FOR SELECT
  USING (
    tenant_id = get_user_tenant_id() AND 
    (SELECT user_role FROM users WHERE id = auth.uid()) = 'bookkeeper'
  );

-- Users can read/update their own record
CREATE POLICY users_self_access ON users
  FOR SELECT
  USING (id = auth.uid());

CREATE POLICY users_self_update ON users
  FOR UPDATE
  USING (id = auth.uid())
  WITH CHECK (
    id = auth.uid() AND 
    tenant_id = get_user_tenant_id() AND
    user_role = (SELECT user_role FROM users WHERE id = auth.uid())
  );
```

### RLS for `rentals` table

```sql
-- Enable RLS
ALTER TABLE rentals ENABLE ROW LEVEL SECURITY;

-- Admin/Bookkeepers have full access to rentals in their tenant
CREATE POLICY rentals_admin_bookkeeper_access ON rentals
  FOR ALL
  USING (
    tenant_id = get_user_tenant_id() AND is_admin_or_bookkeeper()
  );

-- Clients can read rentals in their tenant
CREATE POLICY rentals_client_read ON rentals
  FOR SELECT
  USING (
    tenant_id = get_user_tenant_id() AND 
    (SELECT user_role FROM users WHERE id = auth.uid()) = 'client'
  );
```

### RLS for `hosts` table

```sql
-- Enable RLS
ALTER TABLE hosts ENABLE ROW LEVEL SECURITY;

-- Admin/Bookkeepers have full access to hosts in their tenant
CREATE POLICY hosts_admin_bookkeeper_access ON hosts
  FOR ALL
  USING (
    tenant_id = get_user_tenant_id() AND is_admin_or_bookkeeper()
  );

-- Clients can read hosts in their tenant
CREATE POLICY hosts_client_read ON hosts
  FOR SELECT
  USING (
    tenant_id = get_user_tenant_id() AND 
    (SELECT user_role FROM users WHERE id = auth.uid()) = 'client'
  );
```

### RLS for `suppliers` table

```sql
-- Enable RLS
ALTER TABLE suppliers ENABLE ROW LEVEL SECURITY;

-- Admin/Bookkeepers have full access to suppliers in their tenant
CREATE POLICY suppliers_admin_bookkeeper_access ON suppliers
  FOR ALL
  USING (
    tenant_id = get_user_tenant_id() AND is_admin_or_bookkeeper()
  );

-- Clients can read suppliers in their tenant
CREATE POLICY suppliers_client_read ON suppliers
  FOR SELECT
  USING (
    tenant_id = get_user_tenant_id() AND 
    (SELECT user_role FROM users WHERE id = auth.uid()) = 'client'
  );
```

### RLS for `receipts` table

```sql
-- Enable RLS
ALTER TABLE receipts ENABLE ROW LEVEL SECURITY;

-- Admin/Bookkeepers have full access to receipts in their tenant
CREATE POLICY receipts_admin_bookkeeper_access ON receipts
  FOR ALL
  USING (
    tenant_id = get_user_tenant_id() AND is_admin_or_bookkeeper()
  );

-- Clients can read all receipts in their tenant
CREATE POLICY receipts_client_read ON receipts
  FOR SELECT
  USING (
    tenant_id = get_user_tenant_id() AND 
    (SELECT user_role FROM users WHERE id = auth.uid()) = 'client'
  );

-- Clients can create new receipts
CREATE POLICY receipts_client_insert ON receipts
  FOR INSERT
  WITH CHECK (
    tenant_id = get_user_tenant_id() AND 
    (SELECT user_role FROM users WHERE id = auth.uid()) = 'client'
  );
```

### RLS for `receipt_files` table

```sql
-- Enable RLS
ALTER TABLE receipt_files ENABLE ROW LEVEL SECURITY;

-- Admin/Bookkeepers have full access to receipt files in their tenant
CREATE POLICY receipt_files_admin_bookkeeper_access ON receipt_files
  FOR ALL
  USING (
    tenant_id = get_user_tenant_id() AND is_admin_or_bookkeeper()
  );

-- Clients can read all receipt files in their tenant
CREATE POLICY receipt_files_client_read ON receipt_files
  FOR SELECT
  USING (
    tenant_id = get_user_tenant_id() AND 
    (SELECT user_role FROM users WHERE id = auth.uid()) = 'client'
  );

-- Clients can upload new files
CREATE POLICY receipt_files_client_insert ON receipt_files
  FOR INSERT
  WITH CHECK (
    tenant_id = get_user_tenant_id() AND 
    (SELECT user_role FROM users WHERE id = auth.uid()) = 'client'
  );

-- Clients can update/delete files they uploaded
CREATE POLICY receipt_files_client_update ON receipt_files
  FOR UPDATE
  USING (
    tenant_id = get_user_tenant_id() AND 
    uploaded_by = auth.uid() AND
    (SELECT user_role FROM users WHERE id = auth.uid()) = 'client'
  );

CREATE POLICY receipt_files_client_delete ON receipt_files
  FOR DELETE
  USING (
    tenant_id = get_user_tenant_id() AND 
    uploaded_by = auth.uid() AND
    (SELECT user_role FROM users WHERE id = auth.uid()) = 'client'
  );
```

### RLS for `receipt_line_items` table

```sql
-- Enable RLS
ALTER TABLE receipt_line_items ENABLE ROW LEVEL SECURITY;

-- Admin/Bookkeepers have full access to line items in their tenant
CREATE POLICY line_items_admin_bookkeeper_access ON receipt_line_items
  FOR ALL
  USING (
    tenant_id = get_user_tenant_id() AND is_admin_or_bookkeeper()
  );

-- Clients can read line items in their tenant
CREATE POLICY line_items_client_read ON receipt_line_items
  FOR SELECT
  USING (
    tenant_id = get_user_tenant_id() AND 
    (SELECT user_role FROM users WHERE id = auth.uid()) = 'client'
  );
```

### RLS for `xero_account_codes` table

```sql
-- Enable RLS
ALTER TABLE xero_account_codes ENABLE ROW LEVEL SECURITY;

-- Admin/Bookkeepers have full access to account codes in their tenant
CREATE POLICY account_codes_admin_bookkeeper_access ON xero_account_codes
  FOR ALL
  USING (
    tenant_id = get_user_tenant_id() AND is_admin_or_bookkeeper()
  );

-- Clients can read account codes in their tenant
CREATE POLICY account_codes_client_read ON xero_account_codes
  FOR SELECT
  USING (
    tenant_id = get_user_tenant_id() AND 
    (SELECT user_role FROM users WHERE id = auth.uid()) = 'client'
  );
```

### RLS for `xero_tracking_categories` table

```sql
-- Enable RLS
ALTER TABLE xero_tracking_categories ENABLE ROW LEVEL SECURITY;

-- Admin/Bookkeepers have full access to tracking categories in their tenant
CREATE POLICY tracking_categories_admin_bookkeeper_access ON xero_tracking_categories
  FOR ALL
  USING (
    tenant_id = get_user_tenant_id() AND is_admin_or_bookkeeper()
  );

-- Clients can read tracking categories in their tenant
CREATE POLICY tracking_categories_client_read ON xero_tracking_categories
  FOR SELECT
  USING (
    tenant_id = get_user_tenant_id() AND 
    (SELECT user_role FROM users WHERE id = auth.uid()) = 'client'
  );
```

### RLS for `xero_tracking_options` table

```sql
-- Enable RLS
ALTER TABLE xero_tracking_options ENABLE ROW LEVEL SECURITY;

-- Admin/Bookkeepers have full access to tracking options in their tenant
CREATE POLICY tracking_options_admin_bookkeeper_access ON xero_tracking_options
  FOR ALL
  USING (
    tenant_id = get_user_tenant_id() AND is_admin_or_bookkeeper()
  );

-- Clients can read tracking options in their tenant
CREATE POLICY tracking_options_client_read ON xero_tracking_options
  FOR SELECT
  USING (
    tenant_id = get_user_tenant_id() AND 
    (SELECT user_role FROM users WHERE id = auth.uid()) = 'client'
  );
```

## Storage Structure

Supabase Storage Buckets will be organized as follows:

```
receipts/
  ├── {tenant_id}/
  │   ├── {YYYY-MM}/
  │   │   ├── {receipt_id}/{file_id}.{ext}
  ├── temp/
  │   └── {upload_id}.{ext}
```

### Storage Access Control

Storage bucket policies will ensure that users can only access files belonging to their tenant:

```sql
-- Admin/Bookkeeper storage access policy
CREATE POLICY "admin_bookkeeper_storage_access" ON storage.objects
  FOR ALL
  USING (
    -- Extract tenant_id from object path
    (storage.foldername(1, name) = get_user_tenant_id()::text) AND
    is_admin_or_bookkeeper()
  );

-- Client read access to their tenant's files
CREATE POLICY "client_storage_read_access" ON storage.objects
  FOR SELECT
  USING (
    -- Extract tenant_id from object path
    (storage.foldername(1, name) = get_user_tenant_id()::text) AND
    (SELECT user_role FROM users WHERE id = auth.uid()) = 'client'
  );

-- Client upload access
CREATE POLICY "client_storage_insert_access" ON storage.objects
  FOR INSERT
  WITH CHECK (
    -- Extract tenant_id from object path
    (storage.foldername(1, name) = get_user_tenant_id()::text) AND
    (SELECT user_role FROM users WHERE id = auth.uid()) = 'client'
  );
```

## Implementation Considerations

### Multi-tenancy Strategy



1. **Database-level isolation**: Each tenant's data isolated via RLS
2. **Storage isolation**: Tenant-specific folders in storage
3. **Authentication**: Tenant ID associated with user at registration

### Performance Considerations



1. **Indexes**: Create indexes on commonly queried fields:

   ```sql
   CREATE INDEX idx_receipts_tenant_id ON receipts(tenant_id);
   CREATE INDEX idx_receipts_receipt_status ON receipts(receipt_status);
   CREATE INDEX idx_receipts_supplier_id ON receipts(supplier_id);
   CREATE INDEX idx_receipt_files_receipt_id ON receipt_files(receipt_id);
   CREATE INDEX idx_receipt_files_tenant_id ON receipt_files(tenant_id);
   CREATE INDEX idx_receipt_files_file_hash ON receipt_files(file_hash);
   ```
2. **Pagination**: Implement cursor-based pagination for receipt listings

### Security Considerations



1. **Data encryption**: Encrypt sensitive data at rest
2. **File validation**: Validate uploaded files for type and size
3. **Input sanitization**: Clean and validate all user input



