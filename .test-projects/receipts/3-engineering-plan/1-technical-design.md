# Technical Design

## Database Schema

The following schema outlines the database structure for the Receipt/Invoice Processing System prototype using Supabase.

### Core Tables

#### `tenants`
Represents client organizations using the system.

| Column | Type | Description |
|--------|------|-------------|
| id | uuid | Primary key |
| name | text | Tenant name |
| email | text | Primary contact email |
| created_at | timestamptz | Creation timestamp |
| active | boolean | Active status |
| settings | jsonb | Tenant-specific settings |

#### `users`
System users associated with tenants.

| Column | Type | Description |
|--------|------|-------------|
| id | uuid | Primary key |
| email | text | User email |
| tenant_id | uuid | Foreign key to tenants |
| role | text | User role (admin, bookkeeper, client) |
| created_at | timestamptz | Creation timestamp |
| last_login | timestamptz | Last login timestamp |

#### `rentals`
Individual rental properties.

| Column | Type | Description |
|--------|------|-------------|
| id | uuid | Primary key |
| name | text | Property name/identifier |
| address | text | Property address |
| tenant_id | uuid | Foreign key to tenants |
| host_id | uuid | Foreign key to hosts |
| created_at | timestamptz | Creation timestamp |
| active | boolean | Active status |
| settings | jsonb | Property-specific settings |

#### `hosts`
Property owners or managing entities.

| Column | Type | Description |
|--------|------|-------------|
| id | uuid | Primary key |
| name | text | Host name |
| email | text | Contact email |
| tenant_id | uuid | Foreign key to tenants |
| created_at | timestamptz | Creation timestamp |
| vat_registered | boolean | VAT registration status |
| default_account_codes | jsonb | Default account codes |

#### `suppliers`
Vendors supplying goods/services.

| Column | Type | Description |
|--------|------|-------------|
| id | uuid | Primary key |
| name | text | Supplier name |
| tenant_id | uuid | Foreign key to tenants |
| email | text | Contact email |
| created_at | timestamptz | Creation timestamp |
| vat_registered | boolean | VAT registration status |
| default_account_code | text | Default account code |

#### `receipts`
Main receipt/invoice records.

| Column | Type | Description |
|--------|------|-------------|
| id | uuid | Primary key |
| tenant_id | uuid | Foreign key to tenants |
| supplier_id | uuid | Foreign key to suppliers |
| file_path | text | Path to stored file |
| upload_date | timestamptz | Upload timestamp |
| issue_date | date | Receipt/invoice issue date |
| due_date | date | Payment due date |
| total_amount | numeric | Total amount |
| vat_amount | numeric | VAT amount |
| status | text | Processing status (new, in_progress, pending, completed) |
| processed_by | uuid | Foreign key to users |
| processed_date | timestamptz | Processing timestamp |
| payment_method | text | Method of payment |
| notes | text | Additional notes |
| xero_reference | text | Reference ID in Xero |

#### `receipt_line_items`
Individual line items from receipts/invoices.

| Column | Type | Description |
|--------|------|-------------|
| id | uuid | Primary key |
| receipt_id | uuid | Foreign key to receipts |
| description | text | Item description |
| amount | numeric | Line item amount |
| vat_rate | numeric | VAT rate applied |
| account_code | text | Accounting code |
| rental_id | uuid | Foreign key to rentals |
| tracking_category_id | uuid | Foreign key to tracking categories |

#### `account_codes`
Standard accounting codes.

| Column | Type | Description |
|--------|------|-------------|
| id | uuid | Primary key |
| tenant_id | uuid | Foreign key to tenants |
| code | text | Account code |
| description | text | Account description |
| category | text | Account category |

#### `tracking_categories`
Categories for tracking in Xero.

| Column | Type | Description |
|--------|------|-------------|
| id | uuid | Primary key |
| tenant_id | uuid | Foreign key to tenants |
| name | text | Category name |
| description | text | Category description |

### Table Relationships

- `tenants` 1→* `users`
- `tenants` 1→* `rentals`
- `tenants` 1→* `hosts`
- `tenants` 1→* `suppliers`
- `tenants` 1→* `receipts`
- `tenants` 1→* `account_codes`
- `tenants` 1→* `tracking_categories`
- `hosts` 1→* `rentals`
- `receipts` 1→* `receipt_line_items`
- `suppliers` 1→* `receipts`
- `rentals` 1→* `receipt_line_items`
- `users` 1→* `receipts` (for processed_by)

## API Endpoints

### Authentication

- POST `/auth/signup` - Register a new user
- POST `/auth/login` - User login
- POST `/auth/logout` - User logout
- GET `/auth/user` - Get current user

### Tenants

- GET `/tenants/:id` - Get tenant details
- PUT `/tenants/:id` - Update tenant

### Users

- GET `/users` - List users for current tenant
- POST `/users` - Create a new user
- GET `/users/:id` - Get user details
- PUT `/users/:id` - Update user
- DELETE `/users/:id` - Deactivate user

### Rentals

- GET `/rentals` - List rentals for current tenant
- POST `/rentals` - Create a new rental
- GET `/rentals/:id` - Get rental details
- PUT `/rentals/:id` - Update rental
- DELETE `/rentals/:id` - Deactivate rental

### Hosts

- GET `/hosts` - List hosts for current tenant
- POST `/hosts` - Create a new host
- GET `/hosts/:id` - Get host details
- PUT `/hosts/:id` - Update host
- DELETE `/hosts/:id` - Deactivate host

### Suppliers

- GET `/suppliers` - List suppliers for current tenant
- POST `/suppliers` - Create a new supplier
- GET `/suppliers/:id` - Get supplier details
- PUT `/suppliers/:id` - Update supplier
- DELETE `/suppliers/:id` - Deactivate supplier

### Receipts

- GET `/receipts` - List receipts with filtering options
- POST `/receipts` - Upload new receipt
- GET `/receipts/:id` - Get receipt details
- PUT `/receipts/:id` - Update receipt
- PUT `/receipts/:id/status` - Update receipt status
- POST `/receipts/:id/process` - Process receipt
- GET `/receipts/:id/file` - Download receipt file

### Line Items

- GET `/receipts/:id/line-items` - List line items for a receipt
- POST `/receipts/:id/line-items` - Add line item to receipt
- PUT `/receipts/:id/line-items/:itemId` - Update line item
- DELETE `/receipts/:id/line-items/:itemId` - Remove line item

### Account Codes

- GET `/account-codes` - List account codes for current tenant
- POST `/account-codes` - Create a new account code
- PUT `/account-codes/:id` - Update account code
- DELETE `/account-codes/:id` - Remove account code

### Tracking Categories

- GET `/tracking-categories` - List tracking categories
- POST `/tracking-categories` - Create a new tracking category
- PUT `/tracking-categories/:id` - Update tracking category
- DELETE `/tracking-categories/:id` - Remove tracking category

### Xero Integration

- POST `/xero/connect` - Connect to Xero
- GET `/xero/status` - Check Xero connection status
- POST `/receipts/:id/send-to-xero` - Send receipt to Xero

## Authentication and Authorization

The system will utilize Supabase Authentication with the following approach:

1. **Authentication** - Email/password login via Supabase Auth
2. **Row-Level Security (RLS)** - Implement RLS policies to ensure tenants can only access their own data
3. **Role-Based Access Control** - Use user roles to control permissions:
   - Admin: Full access to tenant data
   - Bookkeeper: Process receipts, manage suppliers
   - Client: View receipt status

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

- Tenant data is isolated in separate folders
- Files organized by year and month
- Original and processed versions stored
- Temporary storage for in-progress uploads 