# AI Frontend Development: Rental Property Management

## Task Overview

Create a comprehensive rental property management interface that enables bookkeepers to view, add, edit, and manage rental property information. This functionality is essential for organizing receipts by property and ensuring proper expense allocation in accounting systems.

## Business Context

Bookkeepers need to maintain accurate records of rental properties for proper expense allocation and financial reporting. In the short-term rental business, understanding which expenses belong to which properties is critical for profitability analysis, tax reporting, and owner communications.

The rental property management view addresses these critical business needs:

* Maintaining a central repository of all rental properties
* Ensuring consistent property information across the system
* Facilitating quick association of receipts with specific properties
* Supporting financial reporting by property
* Enabling property-specific expense tracking and analysis

## Design Specifications

### Visual Design

* Create a clean, modern interface with a card-based view for properties
* Include a list/table view alternative for dense information display
* Use property images or placeholders for visual recognition
* Implement a simple, organized form for adding/editing property details
* Use the application's color scheme consistently
* Design appropriate empty, loading, and error states
* Include visual indicators for active/inactive properties
* Create subtle hover states for interactive elements

### User Experience

* Enable quick filtering and searching of properties
* Implement intuitive sorting capabilities
* Provide a clean, logical form flow for adding/editing properties
* Ensure efficient keyboard navigation
* Create a responsive design that works on various screen sizes
* Allow toggling between card and list views
* Provide quick access to property details and associated receipts

### Functionality

* Display properties in both card and list formats
* Implement search functionality by property name and address
* Enable filtering by property status and type
* Allow adding new properties with all required fields
* Provide editing capabilities for existing property information
* Implement soft-delete functionality (marking properties as inactive)
* Create validation for all property fields
* Show associated receipt count for each property
* Enable viewing all receipts for a specific property
* Support property categorization (e.g., apartment, house, vacation rental)

## Content Requirements

* Page title: "Rental Properties"
* Card/List view labels: Name, Address, Type, Receipts, Status
* Empty state message: "No rental properties found. Add your first property to get started."
* Form field labels should be concise and clear
* Validation error messages should be helpful and specific
* Action buttons should use clear verbs: "Add Property", "Edit", "Save", "Cancel"
* Confirmation messages for actions: "Property added successfully", "Property updated"
* Property type options should match business terminology

## Accessibility Requirements

* All form fields must have proper labels and ARIA attributes
* Card/list items must have appropriate ARIA roles
* Keyboard navigation must work logically
* Interactive elements must have sufficient contrast
* Focus states must be clearly visible
* Error messages must be associated with their fields
* Modal dialogs must trap focus appropriately
* Images must have descriptive alt text

## Component Structure

* RentalPropertyPage as the main container
* PropertyCardGrid component for card display
* PropertyTable component for list display
* ViewToggle component to switch between display modes
* PropertyFilterBar for search and filtering
* PropertyForm component for adding/editing
* ConfirmationDialog for delete operations
* PropertyDetailPanel for viewing complete property information
* StatusBadge component for property status
* PropertyMetrics component for showing associated data counts

## Data Model

* Rental Property item:
  * id: string
  * name: string
  * address: {
    * street: string
    * city: string
    * state: string
    * postal_code: string
    * country: string
      }
  * property_type: string (e.g., 'Apartment', 'House', 'Condo', 'Vacation Rental')
  * owner_name: string
  * owner_email: string (optional)
  * owner_phone: string (optional)
  * bedrooms: number
  * bathrooms: number
  * max_occupancy: number
  * notes: string (optional)
  * image_url: string (optional)
  * is_active: boolean
  * created_at: timestamp
  * updated_at: timestamp

## Supabase Integration

* Connect directly to Supabase for rental property data operations:
  * Fetch properties: `supabase.from('rental_properties').select('*')`
  * Add new property: `supabase.from('rental_properties').insert(propertyData)`
  * Update property: `supabase.from('rental_properties').update(propertyData).eq('id', propertyId)`
  * Delete/deactivate property: `supabase.from('rental_properties').update({is_active: false}).eq('id', propertyId)`
  * Get property with receipt count: `supabase.from('rental_properties').select('*, receipts:receipts(count)')`
  * Upload property images: `supabase.storage.from('property_images').upload()`
* Use Supabase Storage for property images
* Implement proper error handling for all Supabase operations
* Use Supabase's real-time capabilities for live updates to the property list
* Handle authentication and authorization using Supabase's mechanisms
* For complex operations that might affect related data, use the API layer

## Behavioral Specifications

* Property list should load with a loading indicator
* Adding/editing a property should validate all required fields
* Deactivating a property should prompt for confirmation
* Changes should be reflected immediately in the UI
* Switching between card and list views should maintain selected filters
* Image uploads should show progress indicators
* Form submission should be possible via keyboard (Enter)
* Adding a new property should focus the first field of the form
* Property cards should show a visual indicator when hovered

## Success Criteria

* Users can efficiently find properties using search and filters
* Adding and editing properties works correctly with proper validation
* The interface remains responsive and usable with large property datasets
* Property images load efficiently and are displayed correctly
* All error cases are handled gracefully
* Changes to properties are correctly persisted to the database
* The experience feels professional and efficient
* Users can easily associate receipts with properties

## Resources

* Card layout design patterns
* Property management system interfaces for inspiration
* Form design best practices
* Image upload UX patterns

## Implementation Notes

* Implement lazy loading for property images
* Consider using image optimization for property photos
* Use optimistic UI updates where appropriate
* Implement proper form state management
* Consider caching property data for better performance
* Test with various screen sizes to ensure responsive behavior
* Implement proper loading states for asynchronous operations
* Consider adding property import/export functionality in future iterations


