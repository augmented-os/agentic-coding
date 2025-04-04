# API Design Specification

## API Philosophy

This API is designed around the core user workflows rather than pure CRUD operations on database entities. It focuses on supporting the UI functions needed for efficient receipt processing and management.

## Authentication Endpoints

```
POST /auth/login
- Purpose: Authenticate user and establish session
- Body: { email, password }
- Response: { user, token, tenant_info }
```

```
POST /auth/logout
- Purpose: End current session
- Response: { success }
```

```
GET /auth/session
- Purpose: Validate current session and get user info
- Response: { user, tenant_info }
```

```
POST /auth/password/reset
- Purpose: Request password reset email
- Body: { email }
- Response: { success }
```

## Dashboard Endpoints

```
GET /dashboard/statistics
- Purpose: Get summary data for dashboard
- Response: {
    total_receipts: number,
    new_receipts: number,
    in_progress_receipts: number,
    pending_receipts: number,
    completed_receipts: number,
    recent_activity: Array<{action, timestamp, user, receipt_id}>
  }
```

```
GET /dashboard/recent-receipts
- Purpose: Get recently processed receipts
- Query: ?limit=10
- Response: Array of receipt objects with key info
```

## Receipt Management Endpoints

### Receipt Listing & Search

```
GET /receipts
- Purpose: Get filtered list of receipts
- Query: ?status=X&state=Y&supplier_id=Z&date_from=W&date_to=V&rental_id=U&search=Q&page=1&limit=25
- Response: {
    items: Array of receipt objects,
    total_count: number,
    page_count: number
  }
```

### Receipt Upload & Processing Workflow

```
POST /receipts/upload
- Purpose: Upload receipt file(s)
- Body: FormData with files
- Response: {
    upload_id: string,
    files: Array<{id, name, size, preview_url}>
  }
```

```
POST /receipts/process
- Purpose: Create new receipt record from uploaded file
- Body: {
    upload_id: string,
    file_ids: Array<string>
  }
- Response: {
    receipt_id: string,
    status: "new"
  }
```

```
GET /receipts/:id
- Purpose: Get full receipt details
- Response: Receipt object with all fields, file info, and line items
```

```
GET /receipts/:id/file/:file_id
- Purpose: Get receipt file (download or preview)
- Query: ?preview=true
- Response: File stream or preview URL
```

```
PUT /receipts/:id/details
- Purpose: Update basic receipt information (step 1 of workflow)
- Body: {
    supplier_id,
    issue_date,
    due_date,
    reference,
    gross_amount,
    vat_amount,
    net_amount,
    notes
  }
- Response: Updated receipt object
```

```
POST /receipts/:id/line-items
- Purpose: Add line item to receipt (step 2 of workflow)
- Body: {
    description,
    gross_amount,
    vat_rate,
    vat_amount,
    net_amount,
    receipt_type,
    xero_account_code,
    rental_id
  }
- Response: Created line item object
```

```
PUT /receipts/:id/line-items/:item_id
- Purpose: Update line item
- Body: {
    description,
    gross_amount,
    vat_rate,
    vat_amount,
    net_amount,
    receipt_type,
    xero_account_code,
    rental_id
  }
- Response: Updated line item object
```

```
DELETE /receipts/:id/line-items/:item_id
- Purpose: Remove line item from receipt
- Response: { success }
```

```
PUT /receipts/:id/status
- Purpose: Update receipt processing status
- Body: { status: "in_progress"|"pending"|"completed" }
- Response: Updated receipt with new status
```

```
PUT /receipts/:id/state
- Purpose: Update receipt workflow state
- Body: { state: "extract_details"|"match_supplier"|"assign_line_items"|"set_payment_details"|"push_to_xero"|"complete" }
- Response: {
    id: string,
    state: string,
    updated_at: timestamp
  }
```

```
POST /receipts/:id/submit-to-xero
- Purpose: Process receipt and send to Xero
- Body: {
    payment_date,
    payment_account
  }
- Response: {
    xero_invoice_id,
    xero_status,
    receipt_status: "completed",
    receipt_state: "complete"
  }
```

```
POST /receipts/batch-action
- Purpose: Perform action on multiple receipts
- Body: {
    receipt_ids: Array<string>,
    action: "change_status"|"download"|"archive"|"delete",
    action_params: {}
  }
- Response: { success, results: {} }
```

```
POST /receipts/extract
- Purpose: Use OCR to extract data from receipt (would be mocked in prototype)
- Body: { receipt_id }
- Response: {
    extracted_data: {
      supplier_name,
      issue_date,
      due_date,
      reference,
      gross_amount,
      vat_amount,
      net_amount,
      line_items: []
    },
    confidence_score
  }
```

## Supplier Management Endpoints

```
GET /suppliers
- Purpose: Get filtered list of suppliers
- Query: ?search=X&vat_registered=Y&page=1&limit=25
- Response: {
    items: Array of supplier objects,
    total_count: number
  }
```

```
POST /suppliers
- Purpose: Create new supplier
- Body: {
    name,
    vat_registered,
    xero_account_code_default,
    xero_contact_id
  }
- Response: Created supplier object
```

```
GET /suppliers/:id
- Purpose: Get supplier details
- Response: Supplier object with all fields
```

```
PUT /suppliers/:id
- Purpose: Update supplier
- Body: {
    name,
    vat_registered,
    xero_account_code_default,
    xero_contact_id
  }
- Response: Updated supplier object
```

```
GET /suppliers/:id/receipts
- Purpose: Get receipts for specific supplier
- Query: ?status=X&date_from=Y&date_to=Z&page=1&limit=25
- Response: {
    items: Array of receipt objects,
    total_count: number
  }
```

```
GET /suppliers/search
- Purpose: Search suppliers by name for autocomplete
- Query: ?query=X&limit=10
- Response: Array of { id, name } objects
```

## Rental & Host Management Endpoints

```
GET /rentals
- Purpose: Get list of rental properties
- Query: ?host_id=X&active=true&search=Y&page=1&limit=25
- Response: {
    items: Array of rental objects,
    total_count: number
  }
```

```
POST /rentals
- Purpose: Create new rental property
- Body: {
    name,
    host_id,
    active,
    pms_id
  }
- Response: Created rental object
```

```
GET /rentals/:id
- Purpose: Get rental details
- Response: Rental object with all fields
```

```
PUT /rentals/:id
- Purpose: Update rental property
- Body: {
    name,
    host_id,
    active,
    pms_id
  }
- Response: Updated rental object
```

```
GET /rentals/search
- Purpose: Search rentals by name for autocomplete
- Query: ?query=X&limit=10
- Response: Array of { id, name } objects
```

```
GET /hosts
- Purpose: Get list of hosts
- Query: ?vat_registered=X&search=Y&page=1&limit=25
- Response: {
    items: Array of host objects,
    total_count: number
  }
```

```
POST /hosts
- Purpose: Create new host
- Body: {
    display_name,
    legal_name,
    vat_registered,
    xero_account_code
  }
- Response: Created host object
```

```
GET /hosts/:id
- Purpose: Get host details
- Response: Host object with all fields and associated rentals
```

```
PUT /hosts/:id
- Purpose: Update host
- Body: {
    display_name,
    legal_name,
    vat_registered,
    xero_account_code
  }
- Response: Updated host object
```

```
GET /hosts/search
- Purpose: Search hosts by name for autocomplete
- Query: ?query=X&limit=10
- Response: Array of { id, display_name } objects
```

## Xero Integration Endpoints

```
GET /xero/status
- Purpose: Check Xero connection status
- Response: {
    connected: boolean,
    organization_name,
    last_sync,
    accounts_count,
    tracking_categories_count
  }
```

```
POST /xero/connect
- Purpose: Initiate Xero OAuth flow
- Response: { auth_url } (URL to redirect user to)
```

```
GET /xero/callback
- Purpose: Handle OAuth callback from Xero
- Query: ?code=X&state=Y (from Xero)
- Response: { success, redirect_url }
```

```
POST /xero/sync
- Purpose: Sync account codes and tracking categories
- Response: {
    accounts_added: number,
    tracking_categories_added: number
  }
```

## Reference Data Endpoints

```
GET /account-codes
- Purpose: Get list of account codes for current tenant
- Query: ?xero_account_type=X&payments_enabled=Y
- Response: Array of account code objects
```

```
GET /tracking-categories
- Purpose: Get list of tracking categories and options
- Response: Array of category objects with nested options
```

## Implementation Approach


1. **Service-Based Architecture:**
   * Implement service layer between API endpoints and database
   * Group business logic in domain-specific services (ReceiptService, SupplierService, etc.)
2. **Error Handling:**
   * Consistent error response format: `{ error: { code, message, details } }`
   * HTTP status codes mapped to error types
3. **Validation:**
   * Request validation middleware for all endpoints
   * Response validation to ensure data integrity
4. **Authentication & Authorization:**
   * JWT-based authentication
   * Role-based access (admin, bookkeeper, client)
   * Tenant isolation via Row-Level Security
5. **Performance Considerations:**
   * Pagination for all list endpoints
   * Efficient queries using appropriate indexes
   * Caching for reference data
6. **Event-Driven Processing:**
   * Use events for asynchronous processes (OCR extraction, Xero sync)
   * WebSocket notifications for real-time status updates


