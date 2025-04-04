# Task: Receipt Workflow Processing Endpoints

## Description
Implement specialized API endpoints to handle the multi-step receipt processing workflow, including OCR data extraction, supplier matching, line item categorization, payment detail management, Xero integration, and completion. These endpoints will manage the complex business logic required for each workflow stage.

## Context
The receipt processing workflow is a central feature of the system, guiding bookkeepers through a structured process to properly categorize and account for receipts. According to the implementation plan, complex multi-step workflows should be handled through the API layer rather than direct Supabase access.

The receipt processing workflow consists of six main stages:
1. Extract Details - Review and correct OCR-extracted data
2. Match Supplier - Associate receipt with an existing supplier or create a new one
3. Assign Line Items - Categorize receipt items for proper accounting
4. Set Payment Details - Record payment method and status
5. Push to Xero - Prepare and send data to the accounting system
6. Complete - Mark receipt as fully processed

Each stage has specific requirements for validation, data transformation, and business logic that are best implemented in the API layer.

## Dependencies
- [API-001] API Setup and Project Structure
- [API-002] Receipt Mutation Endpoints

## Acceptance Criteria
- [ ] All endpoints are properly authenticated using Supabase JWT
- [ ] Input validation is implemented for all endpoints
- [ ] Appropriate error handling is in place for each workflow stage
- [ ] Business logic for each workflow stage is properly implemented
- [ ] Response formats are consistent and well-documented
- [ ] Endpoints for the following workflow operations are implemented:
  - [ ] Process extracted receipt details (Stage 1)
  - [ ] Match or create supplier (Stage 2)
  - [ ] Manage line items and categories (Stage 3)
  - [ ] Set payment details (Stage 4)
  - [ ] Push receipt to Xero (Stage 5)
  - [ ] Complete receipt processing (Stage 6)
- [ ] Workflow stage transitions are properly validated and enforced
- [ ] All endpoints return appropriate HTTP status codes
- [ ] All endpoints are documented in the API documentation

## Implementation Steps
1. **Define Workflow Models and Logic**
   - [ ] Create schema definitions for each workflow stage request/response
   - [ ] Define state transitions and validation rules
   - [ ] Implement workflow state machine
   - [ ] Define error handling for each stage

2. **Implement Extract Details Endpoint (Stage 1)**
   - [ ] Create POST /receipts/:id/workflow/extract-details endpoint
   - [ ] Implement validation for extracted data
   - [ ] Set up OCR integration if applicable (or mock for prototype)
   - [ ] Store verified receipt details
   - [ ] Update receipt stage upon completion

3. **Implement Supplier Matching Endpoint (Stage 2)**
   - [ ] Create POST /receipts/:id/workflow/match-supplier endpoint
   - [ ] Implement supplier matching logic (exact and fuzzy)
   - [ ] Allow association with existing supplier or creation of new supplier
   - [ ] Update receipt with supplier information
   - [ ] Update receipt stage upon completion

4. **Implement Line Item Management Endpoint (Stage 3)**
   - [ ] Create POST /receipts/:id/workflow/assign-line-items endpoint
   - [ ] Implement line item validation and categorization
   - [ ] Allow bulk line item operations
   - [ ] Calculate and validate totals
   - [ ] Update receipt stage upon completion

5. **Implement Payment Details Endpoint (Stage 4)**
   - [ ] Create POST /receipts/:id/workflow/set-payment-details endpoint
   - [ ] Implement payment information validation
   - [ ] Store payment method, status, and related details
   - [ ] Update receipt stage upon completion

6. **Implement Xero Integration Endpoint (Stage 5)**
   - [ ] Create POST /receipts/:id/workflow/push-to-xero endpoint
   - [ ] Implement Xero API integration (or mock for prototype)
   - [ ] Transform receipt data to Xero format
   - [ ] Handle Xero API responses and errors
   - [ ] Store Xero reference information
   - [ ] Update receipt stage upon completion

7. **Implement Completion Endpoint (Stage 6)**
   - [ ] Create POST /receipts/:id/workflow/complete endpoint
   - [ ] Implement final validation checks
   - [ ] Update receipt status to completed
   - [ ] Handle any final processing steps

8. **Implement General Workflow Endpoints**
   - [ ] Create GET /receipts/:id/workflow/status endpoint
   - [ ] Create POST /receipts/:id/workflow/transition endpoint for manual stage changes
   - [ ] Implement validation for workflow transitions

9. **Add Documentation**
   - [ ] Document all workflow endpoints using OpenAPI/Swagger
   - [ ] Create workflow diagrams to illustrate the process
   - [ ] Add example requests and responses
   - [ ] Document error responses and recovery procedures

10. **Verification**
    - [ ] Test complete workflow process end-to-end
    - [ ] Verify that each stage functions as expected
    - [ ] Test invalid transitions and error handling
    - [ ] Verify integration with external systems
    - [ ] Validate response formats and status codes

## Resources
- [State Machine Concepts](https://statecharts.github.io/)
- [Express Route Handlers](https://expressjs.com/en/guide/routing.html)
- [Xero API Documentation](https://developer.xero.com/documentation/)
- [Workflow Design Patterns](https://www.workflow-management-coalition.org/)

## Notes
- The workflow endpoints should be designed to be resilient, allowing recovery from failures
- Consider implementing transaction support for operations that must succeed or fail as a unit
- Implement proper logging for workflow transitions to support auditing
- Design the API to support both automated and manual workflow progression
- For the prototype, Xero integration might be mocked while maintaining the correct interface
- Consider implementing hooks or webhooks for notifying the frontend of workflow state changes
- Ensure the workflow API aligns with the frontend implementation of the receipt processing UI 