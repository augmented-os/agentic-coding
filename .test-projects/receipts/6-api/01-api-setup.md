# Task: API Setup and Project Structure

## Description
Set up the API project structure for the Receipt Processing System, including the technology stack, folder organization, base configuration, and essential dependencies. This task establishes the foundation for all subsequent API development tasks.

## Context
The Receipt Processing System uses a hybrid approach where the frontend directly accesses Supabase for read operations and authentication, while an API layer handles all mutations and complex operations. This task creates the foundational structure for that API layer.

According to the implementation plan, the API will handle:
- All data mutations
- Multi-step workflows
- Third-party integrations (particularly with Xero)

## Dependencies
- None (this is the first API task)

## Acceptance Criteria
- [ ] API project is initialized with appropriate technology stack (Node.js, Express)
- [ ] Project structure follows best practices for a maintainable API
- [ ] Essential dependencies are installed and configured
- [ ] Connection to Supabase is established and tested
- [ ] Basic error handling middleware is implemented
- [ ] Authentication middleware is set up to validate Supabase JWT tokens
- [ ] Environment configuration is properly set up
- [ ] API documentation setup is in place
- [ ] A basic health check endpoint is implemented and tested

## Implementation Steps
1. **Initialize the API Project**
   - [ ] Create a new Node.js project using npm
   - [ ] Initialize Git repository (if not already part of the main repo)
   - [ ] Set up .gitignore for Node.js project
   - [ ] Create a basic package.json with essential metadata

2. **Set Up Project Structure**
   - [ ] Create src/ directory for source code
   - [ ] Set up directories for routes, controllers, middleware, services, and utilities
   - [ ] Create configuration directory for environment-specific settings
   - [ ] Set up a testing structure

3. **Install and Configure Essential Dependencies**
   - [ ] Install Express as the web framework
   - [ ] Set up Supabase JS client for database operations
   - [ ] Install and configure CORS middleware
   - [ ] Set up body-parser or equivalent for request parsing
   - [ ] Install validation libraries (e.g., Joi, Zod)
   - [ ] Configure logging library
   - [ ] Set up error handling middleware

4. **Implement Authentication**
   - [ ] Create middleware to validate Supabase JWT tokens
   - [ ] Implement role-based access control
   - [ ] Test authentication flow with sample Supabase tokens

5. **Create Basic Server Configuration**
   - [ ] Set up environment variable handling with dotenv
   - [ ] Create configuration files for different environments (dev, test, prod)
   - [ ] Implement server startup with proper error handling

6. **Implement Health Check Endpoint**
   - [ ] Create a simple GET /health endpoint
   - [ ] Return API version, status, and basic system information
   - [ ] Test the endpoint to ensure proper functionality

7. **Set Up API Documentation**
   - [ ] Install and configure Swagger/OpenAPI
   - [ ] Create basic API documentation structure
   - [ ] Document the health check endpoint as an example

8. **Verification**
   - [ ] Run the API locally and ensure it starts without errors
   - [ ] Test the health check endpoint
   - [ ] Verify authentication middleware with test tokens
   - [ ] Ensure all configurations are loading correctly

## Resources
- [Express.js Documentation](https://expressjs.com/)
- [Supabase JavaScript Client](https://supabase.io/docs/reference/javascript/installing)
- [OpenAPI Specification](https://swagger.io/specification/)
- [JWT Authentication Best Practices](https://auth0.com/blog/a-look-at-the-latest-draft-for-jwt-bcp/)

## Notes
- The API should follow RESTful principles while accommodating the specific needs of the receipt processing workflow
- Consider using TypeScript for better type safety and developer experience
- Ensure the API design aligns with the frontend requirements documented in the web tasks
- Performance and security considerations should be addressed from the beginning
- The authentication system must align with the Supabase authentication used by the frontend


