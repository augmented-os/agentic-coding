## API Design

The API will be built using Supabase's PostgREST integration, which automatically generates RESTful endpoints based on the database schema. We'll also create custom server functions for more complex operations.

### Authentication Flow



1. **User Registration**:
   * Create user in Supabase Auth
   * Associate user with tenant in `users` table
   * Set appropriate role
2. **User Login**:
   * Authenticate via Supabase Auth
   * Return JWT token for API access
   * Update last_login timestamp

### Key API Endpoints

#### Receipt Management

```
POST /api/receipts
- Purpose: Upload new receipt
- Body: {tenant_id, file}
- Response: {receipt_id, file_path, status: "new"}
```

```
PUT /api/receipts/:id
- Purpose: Update receipt information
- Body: {supplier_id, issue_date, due_date, total_amount, vat_amount, ...}
- Response: Updated receipt object
```

```
PUT /api/receipts/:id/status
- Purpose: Update receipt status
- Body: {status: "in_progress"|"pending"|"completed"}
- Response: {id, status, updated_at}
```

```
GET /api/receipts?status=X&supplier_id=Y
- Purpose: Filter receipts
- Response: Array of receipt objects matching criteria
```

#### Line Items Management

```
POST /api/receipts/:id/line-items
- Purpose: Add line item to receipt
- Body: {description, amount, vat_rate, account_code, rental_id}
- Response: Created line item object
```

```
PUT /api/line-items/:id
- Purpose: Update line item
- Body: {description, amount, vat_rate, account_code, rental_id}
- Response: Updated line item object
```

#### Xero Integration

```
POST /api/receipts/:id/send-to-xero
- Purpose: Process receipt and send to Xero
- Response: {xero_reference, status}
```

## Xero Integration

### Integration Approach



1. **Authentication**: OAuth 2.0 flow with Xero
2. **Data mapping**: Map our schema to Xero's API requirements
3. **Synchronization**: Push receipts to Xero, store reference IDs

### Data Transformation

When sending data to Xero, the following transformations will be applied:



1. Convert receipt line items to Xero line items format
2. Map account codes to Xero chart of accounts
3. Apply tracking categories as per Xero requirements

## Error Handling and Logging



1. **Error tracking**: Implement structured error logging
2. **Rate limiting**: Handle Xero API rate limits
3. **Retry logic**: Implement retry mechanism for failed operations

## Initial Data Setup

New tenant onboarding will require creating default data:



1. Default account codes
2. Standard tracking categories
3. Admin user setup
4. Storage bucket initialization

## Next Steps



1. Create initial Supabase project
2. Set up database tables with RLS policies
3. Configure storage buckets and policies
4. Implement core API endpoints
5. Develop UI components based on the UI/UX specifications


