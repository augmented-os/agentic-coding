# AI Frontend Development: Supplier Management

## Task Overview
Create a comprehensive supplier management interface that enables bookkeepers to view, add, edit, and manage supplier information. The supplier management functionality is essential for organizing receipts by vendor and ensuring consistent data for accounting purposes.

## Business Context
Bookkeepers need to maintain accurate records of suppliers for proper expense categorization and accounting. Suppliers are frequently reused across receipts, and maintaining a clean supplier database helps with reporting, tax calculations, and financial analysis. 

The supplier management view addresses these critical business needs:
* Maintaining a central repository of all suppliers
* Ensuring consistent supplier information across receipts
* Facilitating quick association of receipts with existing suppliers
* Supporting the creation of new suppliers when processing receipts from new vendors
* Enabling bulk operations and data corrections

## Design Specifications

### Visual Design
* Create a clean, organized table/list view of suppliers with clear row delineation
* Implement a simple form for adding/editing supplier details
* Use the application's color scheme consistently
* Include visual indicators for active/inactive suppliers
* Design appropriate empty, loading, and error states
* Provide clear visual separation between the supplier list and detail views
* Create subtle hover states for interactive elements

### User Experience
* Enable quick filtering and searching of suppliers
* Implement intuitive sorting capabilities
* Provide a clean, logical form flow for adding/editing suppliers
* Make bulk operations accessible and clear
* Ensure efficient keyboard navigation
* Create a responsive design that works on various screen sizes
* Prioritize efficient workflows for common operations

### Functionality
* Display a filterable, sortable list of all suppliers
* Implement search functionality by supplier name
* Enable adding new suppliers with all required fields
* Allow editing existing supplier information
* Implement soft-delete functionality (marking suppliers as inactive)
* Create validation for all supplier fields
* Enable bulk operations (e.g., delete, mark as inactive)
* Show associated receipt count for each supplier
* Allow viewing all receipts from a specific supplier

## Content Requirements
* Page title: "Supplier Management"
* Table column headers: Name, Contact, Category, Receipts, Status, Actions
* Form field labels should be concise and clear
* Empty state message: "No suppliers found. Add your first supplier to get started."
* Validation error messages should be helpful and specific
* Action buttons should use clear verbs: "Add", "Edit", "Save", "Cancel"
* Confirmation messages for actions: "Supplier added successfully", "Supplier updated"
* Category options should match business terminology

## Accessibility Requirements
* All form fields must have proper labels and ARIA attributes
* Table must have appropriate ARIA roles and attributes
* Keyboard navigation must work logically
* Interactive elements must have sufficient contrast
* Focus states must be clearly visible
* Error messages must be associated with their fields
* Modal dialogs must trap focus appropriately

## Component Structure
* SupplierManagementPage as the main container
* SupplierTable component for the list view
* SupplierFilterBar for search and filtering
* SupplierForm component for adding/editing
* ConfirmationDialog for delete operations
* StatusBadge component for supplier status
* Pagination component
* ValidationMessage component for form validation
* SupplierDetailPanel for viewing complete supplier information

## Data Model
* Supplier item:
  * id: string
  * name: string
  * contact_name: string (optional)
  * email: string (optional)
  * phone: string (optional)
  * address: {
    * street: string
    * city: string
    * state: string
    * postal_code: string
    * country: string
  }
  * category: string (e.g., 'Utilities', 'Cleaning', 'Maintenance')
  * tax_id: string (optional)
  * notes: string (optional)
  * is_active: boolean
  * created_at: timestamp
  * updated_at: timestamp

## Supabase Integration
* Connect directly to Supabase for supplier data operations:
  * Fetch suppliers: `supabase.from('suppliers').select('*')`
  * Add new supplier: `supabase.from('suppliers').insert(supplierData)`
  * Update supplier: `supabase.from('suppliers').update(supplierData).eq('id', supplierId)`
  * Delete supplier: `supabase.from('suppliers').delete().eq('id', supplierId)`
  * Get supplier with receipt count: `supabase.from('suppliers').select('*, receipts:receipts(count)')`
* Implement proper error handling for all Supabase operations
* Use Supabase's real-time capabilities for live updates to the supplier list
* Handle authentication and authorization using Supabase's mechanisms
* For complex operations that might affect related data, use the API layer

## Behavioral Specifications
* Supplier list should load with a loading indicator
* Adding/editing a supplier should validate all required fields
* Deleting a supplier should prompt for confirmation
* Changes should be reflected immediately in the UI
* Pagination should maintain position when possible
* Sorting and filtering should be responsive
* Search should highlight matching text if possible
* Form submission should be possible via keyboard (Enter)
* Adding a new supplier should focus the first field of the form

## Success Criteria
* Users can efficiently find suppliers using search and filters
* Adding and editing suppliers works correctly with proper validation
* The interface remains responsive and usable with large supplier datasets
* All error cases are handled gracefully
* Changes to suppliers are correctly persisted to the database
* The experience feels professional and efficient

## Resources
* Data table design patterns for business applications
* Form design best practices
* Bulk operations UX patterns

## Implementation Notes
* Consider implementing debounced search for performance
* Use optimistic UI updates where appropriate
* Implement proper form state management
* Consider caching supplier data for better performance
* Test with large datasets to ensure performance
* Implement proper loading states for asynchronous operations
* Consider adding supplier import/export functionality in future iterations 