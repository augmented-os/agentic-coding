# AI Frontend Development: Receipt List View

## Task Overview
Create a comprehensive receipt list view that allows bookkeepers to efficiently browse, filter, search, and take action on receipts. This view serves as the main interface for receipt management and should prioritize information density while maintaining clarity and usability.

## Business Context
Bookkeepers need to manage approximately 1,000 receipts monthly for short-term rental businesses. The receipt list view is a critical interface where they spend significant time sorting, filtering, and selecting receipts to process. Efficiency is paramount - users need to quickly find specific receipts, understand their status, and take appropriate actions.

The receipt list view needs to handle scenarios such as:
* Finding all receipts from a specific supplier
* Viewing only receipts with a particular status
* Sorting receipts by date, amount, or other attributes
* Selecting receipts for batch operations
* Quickly accessing individual receipts for processing

## Design Specifications

### Visual Design
* Create a clean, structured table/list layout with clear row delineation
* Include visual status indicators that follow the color scheme:
  * Blue for new/unprocessed
  * Yellow/orange for in-progress
  * Purple for pending
  * Green for completed
* Use subtle hover states for interactive rows
* The filter area should be visually distinct but not overwhelming
* Selection states should be clear and visible
* Maintain consistent typography and spacing
* Empty states should be designed thoughtfully

### User Experience
* Filters should be prominently positioned for easy access
* Table columns should be resizable and sortable
* Pagination controls should be intuitive
* Row selection should be obvious with clear visual feedback
* Bulk actions should be contextually available when items are selected
* Loading states should be elegant and informative
* Filter combinations should be intuitive to create and modify
* Enable keyboard navigation through the list

### Functionality
* Implement comprehensive filtering by:
  * Status (All, New, In Progress, Pending, Completed)
  * Date range
  * Supplier
  * Rental property
  * Amount range
  * Search (for references or descriptions)
* Enable sorting by column (date, amount, supplier, status)
* Implement pagination with configurable page size
* Enable row selection for bulk actions
* Include quick action buttons for each receipt
* Create a batch actions menu for operations on selected receipts
* Implement search functionality

## Content Requirements
* Page title: "Receipts"
* Clear column headers: Reference, Date, Supplier, Amount, Status, Actions
* Filter labels should be concise and clear
* Empty state message: "No receipts match your current filters"
* Status labels should be consistent throughout the application
* Action buttons should use clear verbs: "Process", "View", "Edit"
* Include count of total matching receipts: "Showing [X] of [Y] receipts"
* Filter reset option should be labeled "Clear Filters"

## Accessibility Requirements
* Table must have proper ARIA attributes for screen readers
* All interactive elements must be keyboard accessible
* Sort direction must be announced to screen readers
* Status indicators must not rely solely on color
* Batch actions must be accessible via keyboard
* Filter controls must have proper labels and associations
* Focus management must be logical and predictable

## Component Structure
* ReceiptListPage as the main container
* FilterBar component for all filtering controls
* ReceiptTable component for the main data display
* Pagination component
* StatusBadge component for consistent status display
* ActionButton components for row-level actions
* BatchActionMenu for operations on selected items
* SearchInput component

## Data Model
* Receipt item:
  * id: string
  * reference: string
  * supplier: { id: string, name: string }
  * upload_date: Date
  * issue_date: Date
  * amount: number
  * status: 'new' | 'in_progress' | 'pending' | 'completed'
  * receipt_state: 'extract_details' | 'match_supplier' | 'assign_line_items' | 'set_payment_details' | 'push_to_xero' | 'complete'
* Filter criteria:
  * status: string
  * date_from: Date
  * date_to: Date
  * supplier_id: string
  * rental_id: string
  * search: string
  * min_amount: number
  * max_amount: number
* Pagination:
  * page: number
  * page_size: number
  * total_count: number
  * total_pages: number

## API Integration
* Connect directly to Supabase tables for data retrieval
* Implement direct Supabase queries to fetch receipt data:
  * Use `supabase.from('receipts').select('*')` with appropriate filters, pagination and sorting
  * Create helper functions for common operations:
    * `getReceipts(filters, pagination, sort)`
    * `getReceiptSuppliers()` - to populate supplier filter dropdown
    * `getReceiptRentals()` - to populate rental property filter dropdown
* Use Supabase's real-time capabilities for live updates when receipt statuses change
* Handle authentication and authorization using Supabase's built-in mechanisms
* Follow the project's hybrid approach: use direct Supabase access for reads, API for mutations

## Behavioral Specifications
* Table should initially show a loading state
* Changing filters should update the URL parameters
* Sorting a column should show a visual indicator of sort direction
* Selecting rows should update a selection count and enable batch actions
* Action buttons should have hover/active states
* Filter panel should be collapsible on smaller screens
* Table rows should be clickable to view receipt details
* Status changes should be reflected immediately with visual feedback

## Success Criteria
* Users can efficiently find receipts using the filter system
* Table loads and updates quickly, even with large datasets
* Sorting and filtering work correctly and predictably
* Batch operations function correctly on selected items
* The interface remains usable at various screen sizes
* All success and error states are handled appropriately
* The interface feels responsive and polished

## Resources
* DataTables or similar libraries for reference (although custom implementation is preferred)
* Financial application table interfaces for inspiration
* Consider batch action patterns from email clients and document management systems

## Implementation Notes
* The list needs to handle potentially large datasets efficiently
* Consider implementing virtual scrolling for performance with large lists
* Filter combinations can create complexity - test edge cases thoroughly
* This view will be frequently used, so performance optimizations are important
* Consider saving user filter preferences for future visits
* The component should gracefully handle network errors and retry scenarios 