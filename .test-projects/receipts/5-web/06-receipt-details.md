# AI Frontend Development: Receipt Details View

## Task Overview

Create a comprehensive receipt details view that allows bookkeepers to examine individual receipts, view extracted information, and progress the receipt through various processing stages. This interface serves as the main workspace for detailed receipt processing and should provide all necessary tools and information in a coherent, accessible manner.

## Business Context

Bookkeepers need to process receipts by reviewing extracted information, making corrections, adding metadata, and moving each receipt through a defined workflow. The receipt details view is where the majority of actual data processing happens - bookkeepers will spend significant time in this interface ensuring receipt information is accurate before it's used for accounting purposes.

The receipt details view handles critical business functions such as:

* Reviewing extracted receipt data for accuracy
* Correcting any mistakes in OCR data extraction
* Categorizing receipts by supplier and rental property
* Assigning receipt line items to specific accounting categories
* Confirming payment details
* Completing receipt processing for accounting sync

## Design Specifications

### Visual Design

* Create a two-panel layout:
  * Left panel: Receipt image/PDF viewer with zoom and navigation controls
  * Right panel: Receipt data form with editable fields and workflow controls
* Use a clean, organized form layout with logical grouping of related fields
* Implement a prominent workflow progress indicator showing the current step
* Use consistent color scheme for status indication:
  * Blue for active/current step
  * Gray for incomplete steps
  * Green for completed steps
* Provide clear visual separation between different data sections
* Use appropriate form controls for different data types (dates, currency, selects)
* Design appropriate loading, saving, and error states

### User Experience

* Enable side-by-side comparison of receipt image and extracted data
* Implement smooth transitions between workflow steps
* Provide keyboard shortcuts for common actions
* Ensure all form fields have proper validation with helpful error messages
* Allow easy navigation back to the receipt list
* Implement auto-save functionality for form fields
* Create a responsive layout that works on different screen sizes
* Provide clear action buttons for workflow progression

### Functionality

* Display the receipt image/PDF with zoom and pan capabilities
* Show all extracted and editable receipt data
* Implement the multi-step processing workflow:

  
  1. Extract Details (review OCR data)
  2. Match Supplier (associate with known supplier or create new)
  3. Assign Line Items (categorize receipt items)
  4. Set Payment Details (payment method, status)
  5. Push to Xero (prepare for accounting system sync)
  6. Complete (mark as fully processed)
* Enable editing of all receipt metadata
* Implement form validation for all editable fields
* Provide save, cancel, and navigate actions
* Allow moving forward and backward in the workflow
* Implement data persistence between workflow steps

## Content Requirements

* Page title: "Receipt Details"
* Clear section headers for each data group
* Field labels should be concise and clear
* Workflow step labels should clearly indicate the action required
* Validation error messages should be helpful and specific
* Action button text should use clear verbs: "Save", "Next Step", "Previous"
* Include helpful guidance text for each workflow step
* Success messages for completed actions

## Accessibility Requirements

* All form fields must have proper labels and ARIA attributes
* Keyboard navigation must work logically through the form
* Focus management must be predictable and helpful
* Error messages must be associated with their fields
* Image viewer must have appropriate alt text and controls
* Color should not be the only indicator of status
* Workflow steps should be navigable by keyboard

## Component Structure

* ReceiptDetailsPage as the main container
* ImageViewer component for receipt display
* WorkflowStepper component to show and navigate workflow steps
* Multiple form components for different workflow steps:
  * DetailsForm
  * SupplierForm
  * LineItemsForm
  * PaymentDetailsForm
  * XeroPushForm
  * CompletionForm
* ActionButtonBar component for workflow navigation
* ValidationMessage component for field validation
* StatusIndicator component for workflow progress

## Data Model

* Receipt item (from Supabase):
  * id: string
  * file_path: string
  * file_name: string
  * upload_date: timestamp
  * status: string
  * receipt_date: Date
  * total_amount: number
  * tax_amount: number
  * supplier_id: string (nullable)
  * supplier_name: string (extracted or entered)
  * reference_number: string
  * notes: string
  * rental_property_id: string (nullable)
  * payment_method: string
  * payment_status: string
  * line_items: Array of {
    * id: string
    * description: string
    * amount: number
    * category: string
    * tax_included: boolean
      }
  * xero_status: 'not_pushed' | 'ready' | 'pushed' | 'error'
  * xero_reference: string
  * processing_step: 'extract_details' | 'match_supplier' | 'assign_line_items' | 'set_payment_details' | 'push_to_xero' | 'complete'

## Supabase Integration

* Connect directly to Supabase for data retrieval and updates:
  * Fetch receipt details: `supabase.from('receipts').select('*').eq('id', receiptId).single()`
  * Fetch receipt image/PDF: `supabase.storage.from('receipts').download(filePath)`
  * Update receipt details: `supabase.from('receipts').update(receiptData).eq('id', receiptId)`
  * Fetch supplier options: `supabase.from('suppliers').select('*')`
  * Fetch rental property options: `supabase.from('rental_properties').select('*')`
* Use Supabase's real-time capabilities for live updates
* Implement proper error handling for all Supabase operations
* Follow the project's hybrid approach: use direct Supabase access for reads, API for complex mutations
* For workflow transitions that require complex processing, use the API layer instead of direct Supabase access

## Behavioral Specifications

* Loading the receipt details should show a loading state
* Form fields should validate on blur and form submission
* Changes should be auto-saved when possible
* Workflow step transitions should be smooth with appropriate feedback
* The receipt image should be zoomable and pannable
* Receipt data should be editable with immediate validation
* Navigation away from unsaved changes should prompt for confirmation
* Errors should be clearly displayed with recovery options
* Success messages should be shown for completed actions

## Success Criteria

* Users can efficiently review and edit receipt details
* The workflow steps are clear and intuitive to navigate
* Form validation prevents errors and provides helpful feedback
* The receipt image viewer is functional and helpful for verification
* All data is correctly saved to Supabase
* The interface remains responsive and usable
* Users can successfully complete all steps of receipt processing
* The experience feels polished and professional

## Resources

* Form design patterns for financial applications
* PDF.js for PDF rendering
* Image viewer libraries for zoomable interfaces
* Multi-step form design patterns

## Implementation Notes

* Consider performance optimizations for PDF rendering
* Implement error boundary components for graceful failure handling
* Consider using a form library like Formik or React Hook Form
* Test with various receipt types and sizes
* Ensure responsive behavior for different screen sizes
* Implement proper loading states for asynchronous operations
* Consider implementing keyboard shortcuts for power users


