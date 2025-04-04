# Task: Rental Property Mutation Endpoints

## Description
Implement REST API endpoints for rental property data mutations, allowing the frontend to create, update, and delete rental property records. These endpoints support the property management features and ensure data consistency when properties are modified.

## Context
According to the implementation plan, while read operations are handled directly through Supabase, all mutations should go through the API layer. These endpoints will support the rental property management functionality in the frontend, enabling bookkeepers to maintain accurate records of rental properties for proper expense allocation and financial reporting.

Rental properties are key data entities in the receipt processing system as they:
- Are used to categorize and allocate expenses
- Are essential for financial reporting and profitability analysis
- Provide context for expense approvals and accounting
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
  - [ ] Create a new rental property
  - [ ] Update rental property details
  - [ ] Activate/deactivate a rental property
  - [ ] Delete a rental property (with proper safeguards for referenced properties)
  - [ ] Upload and manage property images
- [ ] All endpoints return appropriate HTTP status codes
- [ ] All endpoints are documented in the API documentation

## Implementation Steps
1. **Define Request and Response Models**
   - [ ] Create schema definitions for rental property creation requests
   - [ ] Create schema definitions for property update requests
   - [ ] Define schemas for image upload operations
   - [ ] Define response formats for all operations
   - [ ] Define error response formats

2. **Implement Create Rental Property Endpoint**
   - [ ] Create POST /rental-properties endpoint
   - [ ] Implement input validation for all property fields
   - [ ] Set up database operation to create property
   - [ ] Handle property image references
   - [ ] Return newly created property ID and details

3. **Implement Property Update Endpoints**
   - [ ] Create PUT /rental-properties/:id endpoint for full updates
   - [ ] Create PATCH /rental-properties/:id endpoint for partial updates
   - [ ] Implement validation for update requests
   - [ ] Set up database operations for updates
   - [ ] Ensure proper handling of related records

4. **Implement Property Status Updates**
   - [ ] Create PATCH /rental-properties/:id/status endpoint
   - [ ] Implement validation for status changes
   - [ ] Add logic to check for active receipts before deactivating
   - [ ] Update database with new status

5. **Implement Property Deletion**
   - [ ] Create DELETE /rental-properties/:id endpoint
   - [ ] Add checks for referenced properties (prevent deletion if in use)
   - [ ] Implement soft-delete capabilities
   - [ ] Add option for force deletion with proper authorization
   - [ ] Handle cleanup of associated images

6. **Implement Property Image Operations**
   - [ ] Create POST /rental-properties/:id/images endpoint for image upload
   - [ ] Create DELETE /rental-properties/:id/images/:imageId endpoint for image deletion
   - [ ] Create PATCH /rental-properties/:id/images/:imageId/primary endpoint to set primary image
   - [ ] Implement validation for image operations
   - [ ] Set up proper storage operations for images

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
   - [ ] Test edge cases like referenced property deletion
   - [ ] Verify image upload and management functionality

## Resources
- [REST API Best Practices](https://restfulapi.net/)
- [Express Route Handlers](https://expressjs.com/en/guide/routing.html)
- [Supabase JavaScript Client](https://supabase.io/docs/reference/javascript/insert)
- [Supabase Storage](https://supabase.io/docs/guides/storage)
- [Multer for File Uploads](https://github.com/expressjs/multer)

## Notes
- Ensure proper validation of property data to maintain data integrity
- The API should handle cases where a property is referenced by receipts, preventing accidental deletion
- For image uploads, coordinate with the frontend implementation which might use Supabase storage directly
- Consider implementing image optimization for uploaded property images
- Set proper file size and type restrictions for image uploads
- Implement secure URL generation for property images
- Coordinate with the frontend team to ensure the property form data aligns with the API expectations 