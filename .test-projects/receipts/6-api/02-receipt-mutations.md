# Task: Receipt Mutation Endpoints

## Description
Implement REST API endpoints for receipt data mutations, allowing the frontend to create, update, and delete receipt records. These endpoints will serve as the primary means for modifying receipt data in the database, following the hybrid approach where mutations go through the API layer.

## Context
According to the implementation plan, while the frontend directly accesses Supabase for read operations, all mutations should go through the API layer. These endpoints will support the receipt management features in the frontend, including the receipt upload, receipt details, and receipt list views.

The receipt processing workflow involves several stages:
1. Extract Details (review OCR data)
2. Match Supplier (associate with known supplier or create new)
3. Assign Line Items (categorize receipt items)
4. Set Payment Details (payment method, status)
5. Push to Xero (prepare for accounting system sync)
6. Complete (mark as fully processed)

This task focuses on implementing the core mutation endpoints to support this workflow.

## Dependencies
- [API-001] API Setup and Project Structure

## Acceptance Criteria
- [ ] All endpoints are properly authenticated using Supabase JWT
- [ ] Input validation is implemented for all endpoints
- [ ] Appropriate error handling is in place
- [ ] Database operations are performed securely
- [ ] Response formats are consistent and well-documented
- [ ] Endpoints for the following operations are implemented:
  - [ ] Create a new receipt record
  - [ ] Update receipt details
  - [ ] Update receipt status/stage
  - [ ] Delete a receipt
  - [ ] Add/update receipt line items
  - [ ] Remove receipt line items
- [ ] All endpoints return appropriate HTTP status codes
- [ ] All endpoints are documented in the API documentation

## Implementation Steps
1. **Define Request and Response Models**
   - [ ] Create schema definitions for receipt creation requests
   - [ ] Create schema definitions for receipt update requests
   - [ ] Create schema definitions for line item operations
   - [ ] Define response formats for all operations

2. **Implement Create Receipt Endpoint**
   - [ ] Create POST /receipts endpoint
   - [ ] Implement input validation
   - [ ] Set up database operation to create receipt
   - [ ] Handle file path references for uploaded files
   - [ ] Return newly created receipt ID and status

3. **Implement Receipt Update Endpoints**
   - [ ] Create PUT /receipts/:id endpoint for full updates
   - [ ] Create PATCH /receipts/:id endpoint for partial updates
   - [ ] Implement validation for update requests
   - [ ] Set up database operations for updates
   - [ ] Handle workflow stage transitions

4. **Implement Receipt Status/Stage Updates**
   - [ ] Create PATCH /receipts/:id/status endpoint
   - [ ] Create PATCH /receipts/:id/stage endpoint
   - [ ] Implement validation for status changes
   - [ ] Add logic to enforce valid workflow transitions
   - [ ] Update database with new status/stage

5. **Implement Receipt Deletion**
   - [ ] Create DELETE /receipts/:id endpoint
   - [ ] Add soft-delete capabilities (marking as deleted rather than removing)
   - [ ] Implement checks for deletion permissions
   - [ ] Handle related records (like line items)

6. **Implement Line Item Operations**
   - [ ] Create POST /receipts/:id/items endpoint for adding items
   - [ ] Create PUT /receipts/:id/items/:itemId endpoint for updating items
   - [ ] Create DELETE /receipts/:id/items/:itemId endpoint for removing items
   - [ ] Implement validation for line item operations
   - [ ] Set up proper database operations for line items

7. **Add Documentation**
   - [ ] Document all endpoints using OpenAPI/Swagger
   - [ ] Add example requests and responses
   - [ ] Document error responses and codes

8. **Verification**
   - [ ] Test all endpoints with valid and invalid inputs
   - [ ] Verify that database operations work as expected
   - [ ] Check authentication and authorization
   - [ ] Validate response formats and status codes

## Resources
- [REST API Best Practices](https://restfulapi.net/)
- [Express Route Handlers](https://expressjs.com/en/guide/routing.html)
- [Supabase JavaScript Client](https://supabase.io/docs/reference/javascript/insert)

## Notes
- Ensure proper validation of receipt data and line items to prevent data integrity issues
- Consider implementing transaction handling for operations that affect multiple records
- The API should handle the receipt workflow state transitions carefully, ensuring valid progressions
- For file uploads, coordinate with the frontend implementation which uses Supabase storage directly
- Pay special attention to security considerations, especially for authorization of mutations 