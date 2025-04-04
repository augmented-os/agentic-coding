# Task: Supplier Mutation Endpoints

## Description
Implement REST API endpoints for supplier data mutations, allowing the frontend to create, update, and delete supplier records. These endpoints support the supplier management features and ensure data consistency when suppliers are modified.

## Context
According to the implementation plan, while read operations are handled directly through Supabase, all mutations should go through the API layer. These endpoints will support the supplier management functionality in the frontend, enabling bookkeepers to maintain accurate records of suppliers for proper expense categorization and accounting.

Suppliers are critical data entities in the receipt processing system as they:
- Are frequently referenced across multiple receipts
- Help with expense categorization and reporting
- Are essential for accounting system integration
- Need to be consistently managed across the application

## Dependencies
- [API-001] API Setup and Project Structure

## Acceptance Criteria
- [ ] All endpoints are properly authenticated using Supabase JWT
- [ ] Input validation is implemented for all endpoints
- [ ] Appropriate error handling is in place
- [ ] Database operations are performed securely
- [ ] Response formats are consistent and well-documented
- [ ] Endpoints for the following operations are implemented:
  - [ ] Create a new supplier
  - [ ] Update supplier details
  - [ ] Activate/deactivate a supplier
  - [ ] Delete a supplier (with proper safeguards for referenced suppliers)
  - [ ] Bulk operations for suppliers (optional)
- [ ] All endpoints return appropriate HTTP status codes
- [ ] All endpoints are documented in the API documentation

## Implementation Steps
1. **Define Request and Response Models**
   - [ ] Create schema definitions for supplier creation requests
   - [ ] Create schema definitions for supplier update requests
   - [ ] Define response formats for all operations
   - [ ] Define error response formats

2. **Implement Create Supplier Endpoint**
   - [ ] Create POST /suppliers endpoint
   - [ ] Implement input validation for all supplier fields
   - [ ] Set up database operation to create supplier
   - [ ] Handle duplicate supplier detection
   - [ ] Return newly created supplier ID and details

3. **Implement Supplier Update Endpoints**
   - [ ] Create PUT /suppliers/:id endpoint for full updates
   - [ ] Create PATCH /suppliers/:id endpoint for partial updates
   - [ ] Implement validation for update requests
   - [ ] Set up database operations for updates
   - [ ] Ensure proper handling of related records

4. **Implement Supplier Status Updates**
   - [ ] Create PATCH /suppliers/:id/status endpoint
   - [ ] Implement validation for status changes
   - [ ] Add logic to check for active receipts before deactivating
   - [ ] Update database with new status

5. **Implement Supplier Deletion**
   - [ ] Create DELETE /suppliers/:id endpoint
   - [ ] Add checks for referenced suppliers (prevent deletion if in use)
   - [ ] Implement soft-delete capabilities
   - [ ] Add option for force deletion with proper authorization

6. **Implement Bulk Operations (Optional)**
   - [ ] Create POST /suppliers/bulk endpoint for batch creation
   - [ ] Create PATCH /suppliers/bulk endpoint for batch updates
   - [ ] Create DELETE /suppliers/bulk endpoint for batch deletion
   - [ ] Implement validation for bulk operations
   - [ ] Ensure transactional integrity

7. **Add Documentation**
   - [ ] Document all endpoints using OpenAPI/Swagger
   - [ ] Add example requests and responses
   - [ ] Document error responses and codes
   - [ ] Include validation rules in documentation

8. **Verification**
   - [ ] Test all endpoints with valid and invalid inputs
   - [ ] Verify that database operations work as expected
   - [ ] Check authentication and authorization
   - [ ] Validate response formats and status codes
   - [ ] Test edge cases like duplicate suppliers and referenced supplier deletion

## Resources
- [REST API Best Practices](https://restfulapi.net/)
- [Express Route Handlers](https://expressjs.com/en/guide/routing.html)
- [Supabase JavaScript Client](https://supabase.io/docs/reference/javascript/insert)
- [Bulk Operations Best Practices](https://www.moesif.com/blog/technical/api-design/REST-API-Design-Best-Practices-for-Sub-and-Batch-Requests/)

## Notes
- Ensure proper validation of supplier data to prevent duplicates and maintain data integrity
- Consider implementing fuzzy matching for supplier names to detect potential duplicates
- The API should handle cases where a supplier is referenced by receipts, preventing accidental deletion
- For bulk operations, consider implementing proper error handling that allows partial success
- Coordinate with the frontend team to ensure the supplier form data aligns with the API expectations 