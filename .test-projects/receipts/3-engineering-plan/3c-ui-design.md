# UI/UX Design Specifications

This document provides detailed UI/UX specifications for the Receipt/Invoice Processing System prototype, formatted to be easily usable as prompts for AI builder tools.

## Overall Design Philosophy

```
Create a clean, modern interface for a receipt processing application for bookkeepers. The design should use a professional color scheme with blues and whites as primary colors. The interface should be desktop-focused, responsive, and emphasize efficiency for users who need to process many receipts quickly. Use a card-based design for receipts and a clear workflow indicator.
```

## Navigation Structure

```
Create a sidebar navigation for a bookkeeping application with the following sections:
1. Dashboard (home icon)
2. Receipts (receipt/document icon)
3. Suppliers (building/store icon)
4. Rentals (house icon)
5. Hosts (person icon)
6. Settings (gear icon)

The sidebar should be collapsible, with icons and text labels. The active section should be clearly highlighted.
```

## Authentication Screens

### Login Screen

```
Design a clean login screen for a bookkeeping application with the following elements:
1. Company logo at the top
2. "Welcome Back" heading
3. Email input field with validation
4. Password input field with show/hide toggle
5. "Remember me" checkbox
6. Sign In button (primary color)
7. Forgot password link
8. Simple footer with copyright information

Use a white card on a subtle background pattern. Ensure the form has proper validation feedback.
```

## Dashboard

```
Create a bookkeeper dashboard with the following components:
1. Welcome message with user name and current date
2. Statistics cards in a row showing:
   - Total receipts (with document icon)
   - New/unprocessed receipts (with notification icon)
   - In progress receipts (with clock icon)
   - Completed receipts (with checkmark icon)
3. A filterable table with recent receipts (last 10) showing:
   - Receipt ID
   - Supplier name
   - Date
   - Amount
   - Status (with appropriate color indicator)
4. A card showing receipt processing statistics for the current month

Use a clean white background with card-based components and subtle shadows.
```

## Receipt Management

### Receipt List View

```
Design a receipt management interface with:
1. A prominent filter bar at the top with:
   - Status dropdown (All, New, In Progress, Pending, Completed)
   - Date range picker
   - Supplier dropdown
   - Rental property dropdown
   - Search box for keywords/amounts
2. A "Upload New Receipt" button (primary color)
3. A tabular list of receipts with:
   - Selection checkbox
   - Receipt thumbnail/icon
   - Receipt ID/reference
   - Upload date
   - Supplier
   - Amount
   - Status (with color coding)
   - Action buttons (View, Edit, Process)
4. Pagination controls
5. Bulk action dropdown for selected items

Make the table rows hoverable with subtle highlight. Include the ability to sort by clicking column headers.
```

### Receipt Upload

```
Create a receipt upload interface with:
1. A drag-and-drop zone for files with icon and text "Drag receipts here or click to browse"
2. File type information (Accepts PDF, JPG, PNG)
3. File size limit information (Max 10MB)
4. Upload progress indicator
5. Recently uploaded files list with:
   - Filename
   - Size
   - Upload status
   - Remove button
6. "Process Uploads" button (primary color)
7. Cancel button

Use a clean card-based design with clear visual feedback for the upload state.
```

### Receipt Processing Workflow

```
Design a multi-step receipt processing interface with:
1. A horizontal stepper showing the workflow stages:
   - Extract Details
   - Match Supplier
   - Assign Line Items
   - Set Payment Details
   - Push to Xero
   - Complete
2. The current active step should be highlighted with a dark circular background and white text/number
3. Completed steps should be visually distinct from upcoming steps
4. A thin connecting line should run between each step
5. Navigation buttons at the bottom:
   - Back button
   - Next/Continue button (primary color)
   - Save as Draft button (secondary color)
6. A sidebar showing the receipt image/preview
7. A form area that changes based on the current step
8. A clear visual indication of the current step with a title and description (e.g., "Process receipt and send to Xero")

The interface should make it clear where the user is in the process with the ability to save progress.
```

#### Step 1: Extract Details

```
Create a receipt details extraction form with:
1. Receipt preview on the left side
2. Form on the right side with fields:
   - Receipt/Invoice date picker
   - Due date picker
   - Receipt/Invoice number
   - Total amount
   - VAT amount/rate selector (20% or exempt)
   - Notes/comments textarea
3. "Auto-Extract" button to simulate future OCR capability
4. Manual entry fields clearly labeled
5. Validation feedback for all fields

Ensure the form has proper spacing and grouping of related fields. Use field hints to guide users.
```

#### Step 2: Match Supplier

```
Design a supplier matching interface with:
1. Receipt preview on the left side
2. Supplier selection area on the right with:
   - Search field for finding existing suppliers
   - Results list showing matching suppliers with name and VAT status
   - "Create New Supplier" button for adding suppliers not found
   - Recently used suppliers section for quick selection
3. Selected supplier card showing:
   - Supplier name
   - VAT registration status
   - Default account code
   - Edit button to modify supplier details
4. Validation to ensure a supplier is selected before proceeding

Use clear visual hierarchy to emphasize the search and selection process. Include clear feedback when a supplier is successfully matched.
```

#### Step 3: Assign Line Items

```
Design a line item entry interface with:
1. A table for line items with:
   - Description
   - Amount
   - VAT (dropdown for 20% or exempt)
   - Account code (dropdown)
   - Rental property (dropdown)
   - Actions (delete button)
2. "Add Line Item" button below the table
3. Running totals section showing:
   - Subtotal
   - VAT
   - Total
4. Validation to ensure line items match the receipt total

Use an inline editing approach for efficiency. Include the ability to add multiple line items quickly.
```

#### Step 4: Set Payment Details

```
Create a payment details form with:
1. Receipt preview maintained on the left side
2. Payment information form on the right with:
   - Payment date picker
   - Payment method dropdown (Bank Transfer, Credit Card, Cash, etc.)
   - Payment account dropdown (linked to Xero accounts)
   - Payment reference field
   - Payment status dropdown (Paid, Pending, Due)
3. If status is "Paid", show additional fields:
   - Payment confirmation number/reference
   - Receipt attachment option
4. Visual confirmation of payment details
5. Clear validation messages

Organize the form logically and include helpful hints about how payment information will integrate with Xero.
```

#### Step 5: Push to Xero

```
Design a pre-submission review screen with:
1. Xero integration status indicator (connected/disconnected)
2. Summary of all receipt information:
   - Supplier details
   - Receipt details (date, amount, reference)
   - Line items table (condensed view)
   - Payment information
3. Xero-specific options:
   - Xero account mapping confirmation
   - Tracking categories assignment
   - Tax treatment confirmation
4. "Send to Xero" button (prominent, primary color)
5. Warning/confirmation messages for any potential issues
6. Option to go back and edit any section

Include clear feedback about the Xero submission process and what will happen after submission.
```

#### Step 6: Complete

```
Create a completion confirmation screen with:
1. Large success indicator (checkmark icon)
2. "Receipt Successfully Processed" headline
3. Summary card with key details:
   - Receipt reference
   - Supplier
   - Total amount
   - Xero invoice ID (with link to Xero)
4. Quick action buttons:
   - "Process Another Receipt" button
   - "View Receipt Details" button
   - "Back to Dashboard" button
5. Notification about where to find the receipt in the system

Design this screen to provide clear closure to the workflow and guide the user to their next likely action.
```

## Supplier Management

```
Design a supplier management interface with:
1. A search and filter bar
2. "Add Supplier" button
3. A table/grid of suppliers showing:
   - Supplier name
   - Contact information
   - VAT status
   - Default account code
   - Number of associated receipts
   - Action buttons (Edit, View Receipts)
4. A supplier details modal/page with:
   - Contact information form
   - VAT settings
   - Default account codes
   - Recent receipts from this supplier

Use a clean, consistent design matching the rest of the application.
```

## Rental Property Management

```
Create a rental property management interface with:
1. A search/filter bar
2. "Add Property" button
3. A card-based grid of rental properties showing:
   - Property name/reference
   - Address
   - Host name
   - Status indicator (Active/Inactive)
   - Action buttons
4. Property details form/page with:
   - Property information
   - Host assignment dropdown
   - Default account code settings
   - Associated receipts list

Use property cards with a subtle visual indicator of property status.
```

## Host Management

```
Design a host management interface with:
1. Search/filter functionality
2. "Add Host" button
3. Table or card view of hosts showing:
   - Host name
   - Contact details
   - Number of properties
   - VAT registration status
   - Action buttons
4. Host details page with:
   - Contact information
   - Property list
   - Default settings
   - VAT information

Follow consistent design patterns from other management screens.
```

## Mobile Responsiveness

```
Ensure the application is responsive with these mobile-specific considerations:
1. Collapsible sidebar becomes a bottom navigation
2. Tables reformat to card views on small screens
3. Form inputs are properly sized for touch
4. Receipt processing workflow adapts to vertical orientation
5. Filter controls collapse into a filter button that opens a drawer

Prioritize essential functions for mobile views while maintaining all functionality.
```

## Component Details

### Status Indicators

```
Create a consistent status indicator system with:
1. New/Unprocessed: Blue dot with "New" label
2. In Progress: Yellow/orange with "In Progress" label
3. Pending: Purple with "Pending" label
4. Completed: Green with "Completed" label

Use both color and text to indicate status for accessibility. Status should be visible on all receipt listings.
```

### Filter Controls

```
Design an advanced filter system with:
1. Quick filter buttons for common statuses
2. Dropdown selectors for:
   - Date ranges (with presets like Today, Last Week, This Month)
   - Suppliers (searchable)
   - Rental properties (searchable)
   - Amounts (ranges)
3. A "Save Filter" option for bookkeepers to save common queries
4. Clear/Reset filters button
5. Visual indication when filters are active

Make filters prominent and easy to access, as they are critical to bookkeeper workflow.
```

### Data Tables

```
Create consistent data table components with:
1. Sortable columns (click header to sort)
2. Pagination controls (10/25/50 items per page)
3. Column visibility toggles
4. Row hover effects
5. Selection checkboxes for bulk actions
6. Empty state designs
7. Loading state indicators

Ensure tables maintain usability with large datasets and provide proper feedback during loading states.
```

## Key User Flows

### Receipt Processing Flow

```
Implement this user flow for processing receipts:
1. User uploads receipt file(s)
2. System displays the Extract Details screen (Step 1)
3. User enters or confirms extracted receipt details
4. User moves to Match Supplier (Step 2) and selects the appropriate supplier
5. User proceeds to Assign Line Items (Step 3) and adds line items with account codes and rental assignments
6. User sets Payment Details (Step 4) including payment date and method
7. User reviews all details and sends to Xero (Step 5)
8. System confirms completion and provides next steps (Step 6)

The flow should be linear but allow for saving progress and returning later. Users should be able to navigate back to previous steps to make corrections as needed.
```

### Supplier Creation Flow

```
Create this flow for adding new suppliers:
1. User clicks "Add Supplier" or selects "Add New" when processing a receipt
2. Quick-add form appears with essential fields:
   - Supplier name
   - VAT registration status
   - Default account code
3. "Create and Continue" saves the supplier
4. Optional full details form allows adding additional information
5. Newly created supplier is automatically selected in the receipt form

This flow should be efficient and minimize disruption to receipt processing.
```


