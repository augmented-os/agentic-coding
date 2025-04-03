# Technical Design Document

## Database Schema

The following schema outlines the database structure for the Receipt/Invoice Processing System prototype using Supabase.

### Core Tables

#### `tenants`

Represents client organizations using the system.

| Column | Type | Description |
|----|----|----|
| id | uuid | Primary key |
| name | text | Tenant name |
| created_at | timestamptz | Creation timestamp |
| active | boolean | Active status |
| settings | jsonb | Tenant-specific settings |
| updated_at | timestamptz | Last updated timestamp |

#### `users`

System users associated with tenants.

| Column | Type | Description |
|----|----|----|
| id | uuid | Primary key |
| email | text | User email |
| tenant_id | uuid | Foreign key to tenants |
| role | enum user_role | User role (admin, bookkeeper, client) |
| created_at | timestamptz | Creation timestamp |
| last_login | timestamptz | Last login timestamp |
| updated_at | timestamptz | Last updated timestamp |

#### `rentals`

Individual rental properties.

| Column | Type | Description |
|----|----|----|
| id | uuid | Primary key |
| name | text | Property name |
| tenant_id | uuid | Foreign key to tenants |
| host_id | uuid | Foreign key to hosts |
| created_at | timestamptz | Creation timestamp |
| active | boolean | Active status |
| updated_at | timestamptz | Last updated timestamp |
| pms_id | text | External ID for PMS (format may vary) |

#### `hosts`

Property owners or managing entities.

| Column | Type | Description |
|----|----|----|
| id | uuid | Primary key |
| display_name | text | Host name |
| legal_name | text | Name of legal entity |
| tenant_id | uuid | Foreign key to tenants |
| created_at | timestamptz | Creation timestamp |
| vat_registered | boolean | VAT registration status |
| xero_account_code | uuid | Foreign key to xero_account_codes |
| updated_at | timestamptz | Last updated timestamp |

#### `suppliers`

Vendors supplying goods/services.

| Column | Type | Description |
|----|----|----|
| id | uuid | Primary key |
| name | text | Supplier name |
| tenant_id | uuid | Foreign key to tenants |
| created_at | timestamptz | Creation timestamp |
| vat_registered | boolean | VAT registration status |
| xero_account_code_default | uuid | Foreign key to xero_account_codes for default account code |
| xero_contact_id | uuid | ID of Xero contact |

#### `receipts`

Main receipt/invoice records.

| Column | Type | Description |
|----|----|----|
| id | uuid | Primary key |
| tenant_id | uuid | Foreign key to tenants |
| supplier_id | uuid | Foreign key to suppliers |
| reference | text | Receipt/invoice reference (E.g. INV-006) |
| file_path | text | Path to stored file |
| upload_date | timestamptz | Upload timestamp |
| issue_date | date | Receipt/invoice issue date |
| accrual_date | date | Date for accrual purposes |
| due_date | date | Payment due date |
| gross_amount | numeric | Total amount |
| vat_amount | numeric | VAT amount |
| net_amount | numeric | Net amount |
| receipt_status | enum receipt_status | Processing status (new, in_progress, pending, completed) |
| processed_by | uuid | Foreign key to users |
| processed_date | timestamptz | Processing timestamp |
| payment_date | date | Payment date |
| payment_account | uuid | Foreign key to xero_account_codes |
| notes | text | Additional notes |
| xero_invoice_no | text | Xero invoice number (e.g. INV-006) |
| xero_invoice_id | uuid | Invoice ID in Xero |
| xero_payment_id | uuid | Payment ID in Xero |
| xero_payload | json | Xero JSON payload |
| xero_account_id_payment | uuid | Foreign key to xero_account_id for payment |

#### `receipt_line_items`

Individual line items from receipts/invoices.

| Column | Type | Description |
|----|----|----|
| id | uuid | Primary key |
| receipt_id | uuid | Foreign key to receipts |
| receipt_type | enum receipt_type | Receipt type (Direct, Disbursement) |
| description | text | Item description |
| gross_amount | numeric | Gross line item amount |
| vat_rate | numeric | VAT rate applied |
| vat_amount | numeric | VAT total |
| net_amount | numeric | Net line item amount |
| xero_account_code | uuid | Foreign key to xero_account_codes |
| rental_id | uuid | Foreign key to rentals |
| xero_tracking_option_id_property | uuid | Foreign key to xero_tracking_option |
| xero_tracking_option_id_type | uuid | Foreign key to xero_tracking_option |
| tenant_id | uuid | Foreign key to tenants |

#### `xero_account_codes`

Standard accounting codes.

| Column | Type | Description |
|----|----|----|
| id | uuid | Primary key |
| tenant_id | uuid | Foreign key to tenants |
| code | text | Account code |
| name | text | Account name |
| xero_account_type | enum xero_account_type | Xero account type (BANK, CURRENT, CURRLIAB, DEPRECIATN, DIRECTCOSTS, EQUITY, EXPENSE, FIXED, INVENTORY, LIABILITY, NONCURRENT, OTHERINCOME, OVERHEADS, PREPAYMENT, REVENUE, SALES, TERMLIAB) |
| xero_account_class | enum xero_account_class | Xero account class (ASSET, EQUITY, EXPENSE, LIABILITY, REVENUE) |
| xero_status | enum xero_status | Status (ACTIVE, ARCHIVED) |
| payments_enabled | bool | Payments enabled (true/false) |

#### `xero_tracking_categories`

Options for tracking in Xero.

| Column | Type | Description |
|----|----|----|
| id | uuid | Primary key |
| tenant_id | uuid | Foreign key to tenants |
| name | text | Category name |
| xero_status | enum xero_status | Status (ACTIVE, ARCHIVED) |

### `xero_tracking_options`

Options for tracking in Xero.

| Column | Type | Description |
|----|----|----|
| id | uuid | Primary key |
| tenant_id | uuid | Foreign key to tenants |
| tracking_category_id | uuid | Foreign key to xero_tracking_categories |
| name | text | Option name |
| xero_status | enum xero_status | Status (ACTIVE, ARCHIVED) |

### Table Relationships

* `tenants` 1→\* `users`
* `tenants` 1→\* `rentals`
* `tenants` 1→\* `hosts`
* `tenants` 1→\* `suppliers`
* `tenants` 1→\* `receipts`
* `tenants` 1→\* `account_codes`
* `tenants` 1→\* `tracking_categories`
* `hosts` 1→\* `rentals`
* `receipts` 1→\* `receipt_line_items`
* `suppliers` 1→\* `receipts`
* `rentals` 1→\* `receipt_line_items`
* `users` 1→\* `receipts` (for processed_by)

## Row-Level Security

Supabase provides Row-Level Security (RLS) that will be used to enforce tenant data isolation. For each table, policies will be created to ensure users can only access data belonging to their tenant.

### Example RLS Policies

#### For `receipts` table:

```sql
-- Enable RLS
ALTER TABLE receipts ENABLE ROW LEVEL SECURITY;

-- Policy for users to see only their tenant's receipts
CREATE POLICY tenant_isolation_select ON receipts 
  FOR SELECT 
  USING (tenant_id = (SELECT tenant_id FROM users WHERE users.id = auth.uid()));

-- Policy for users to insert only their tenant's receipts
CREATE POLICY tenant_isolation_insert ON receipts 
  FOR INSERT 
  WITH CHECK (tenant_id = (SELECT tenant_id FROM users WHERE users.id = auth.uid()));

-- Policy for users to update only their tenant's receipts
CREATE POLICY tenant_isolation_update ON receipts 
  FOR UPDATE 
  USING (tenant_id = (SELECT tenant_id FROM users WHERE users.id = auth.uid()));
```

Similar policies will be applied to all tenant-specific tables to ensure proper data isolation.

## Storage Structure

Supabase Storage Buckets will be organized as follows:

```
receipts/
  ├── {tenant_id}/
  │   ├── {YYYY-MM}/
  │   │   ├── {receipt_id}_original.{ext}
  │   │   └── {receipt_id}_processed.{ext}
  ├── temp/
  │   └── {upload_id}.{ext}
```

### Storage Access Control

Storage bucket policies will ensure that users can only access files belonging to their tenant:

```sql
-- Example storage bucket policy in Supabase
CREATE POLICY "Tenant users can access only their files" ON storage.objects
  FOR SELECT
  USING (
    -- Extract tenant_id from object path
    (storage.foldername(1, name) = (
      SELECT tenant_id FROM users WHERE users.id = auth.uid()
    )::text)
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
   CREATE INDEX idx_receipts_status ON receipts(status);
   CREATE INDEX idx_receipts_supplier_id ON receipts(supplier_id);
   ```
2. **Pagination**: Implement cursor-based pagination for receipt listings

### Security Considerations



1. **Data encryption**: Encrypt sensitive data at rest
2. **File validation**: Validate uploaded files for type and size
3. **Input sanitization**: Clean and validate all user input



