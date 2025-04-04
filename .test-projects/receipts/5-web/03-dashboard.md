# AI Frontend Development: Dashboard for Receipt Processing System

## Task Overview

Create a functional, information-rich dashboard as the main landing page after login. This dashboard should provide bookkeepers with an immediate overview of receipt processing status, recent activity, and key metrics. The dashboard should emphasize clarity and help users quickly identify areas that need attention.

## Business Context

The dashboard is the command center for bookkeepers managing receipt processing for short-term rental businesses. It needs to provide at-a-glance insights into the current state of receipt processing, highlighting items that need attention and showing overall processing health.

Bookkeepers may be managing multiple rental properties and need to quickly understand:

* How many receipts need processing
* Recent activity in the system
* Status distribution of receipts (new, in progress, pending, completed)
* Any urgent items requiring attention

The dashboard serves as both an information display and a navigation hub to other parts of the application.

## Design Specifications

### Visual Design

* Create a clean, organized dashboard with card-based components
* Use consistent spacing and alignment for all elements
* Implement the blue color scheme consistently throughout
* Use color strategically to indicate different statuses:
  * Blue for new/unprocessed items
  * Yellow/orange for in-progress items
  * Purple for pending items
  * Green for completed items
* Incorporate subtle animations for loading states and data updates
* Use appropriate data visualization for statistics (charts, progress indicators)

### User Experience

* Dashboard should load quickly and show immediate value
* All cards should have clear titles and purpose
* Information hierarchy should guide the eye to the most important metrics first
* Click/tap areas should be generous and obvious
* Filtering and customization options should be available but not overwhelming
* Empty states should provide guidance instead of blank spaces
* Enable quick navigation to full receipt listings or specific filtered views

### Functionality

* Display key statistics in card format:
  * Total receipts
  * New/unprocessed receipts
  * In progress receipts
  * Pending receipts
  * Completed receipts
* Show a filterable table of recent receipts (last 10)
* Provide a summary of recent activity
* Include quick action buttons for common tasks
* Implement basic filtering capability (by date range, status)

## Content Requirements

* Dashboard title: "Dashboard"
* Welcome message including user's name: "Welcome back, \[Name\]"
* Current date display: \[Day of week\], \[Month\] \[Date\], \[Year\]
* Card titles should be clear and direct: "Receipt Statistics," "Recent Receipts," "Activity"
* Use consistent terminology for receipt statuses
* If no recent activity exists, show helpful empty state: "No recent activity. Start processing receipts to see activity here."
* Use clear, concise language for all labels and descriptions

## Accessibility Requirements

* Ensure proper heading structure for screen readers
* All interactive elements must be keyboard accessible
* Data visualizations should include alternative text descriptions
* Status colors should have sufficient contrast and include text labels
* Charts and graphs must include appropriate ARIA attributes
* Dynamic content updates should be announced to screen readers

## Component Structure

* DashboardLayout component as the container
* StatisticsCards component for metrics display
* RecentReceiptsTable component for listing recent items
* ActivityFeed component for showing recent actions
* QuickActions component for common tasks
* DateRangePicker component for filtering

## Data Model

* Dashboard statistics:
  * total_receipts: number
  * new_receipts: number
  * in_progress_receipts: number
  * pending_receipts: number
  * completed_receipts: number
* Receipt item:
  * id: string
  * reference: string
  * supplier: string
  * date: Date
  * amount: number
  * status: 'new' | 'in_progress' | 'pending' | 'completed'
* Activity item:
  * id: string
  * action: string
  * user: string
  * timestamp: Date
  * receipt_id: string (optional)

## API Integration

* For this prototype, use placeholder data that mimics the structure of future API responses
* In future implementation, dashboard will connect to these Supabase queries:
  * getReceiptStatistics()
  * getRecentReceipts(limit)
  * getRecentActivity(limit)

## Behavioral Specifications

* Dashboard should initially show a loading state
* Statistics cards should animate in sequence when data loads
* Table rows should be hoverable with subtle highlight effect
* Clicking a receipt row should navigate to that receipt's detail view
* Activity items should show relative time (e.g., "2 hours ago")
* Dashboard should automatically refresh data at reasonable intervals (every 5 minutes)
* Filters should apply immediately when changed

## Success Criteria

* Dashboard provides clear, at-a-glance status information
* Navigation to key sections of the application is intuitive
* Information is presented in a logical, hierarchical manner
* Loading and empty states are handled elegantly
* Visual design is consistent with the overall application aesthetic
* All information is accurate and up-to-date
* Layout is responsive and works well on different screen sizes

## Resources

* Dashboard design inspiration from financial and project management tools
* Chart.js or similar libraries for simple data visualization
* Icons for various metrics and statuses
* Consider dashboard layouts from applications like Xero, QuickBooks, or Asana

## Implementation Notes

* The dashboard is often the most frequently viewed page, so performance is critical
* Space is valuable - prioritize the most important information
* Consider implementing light customization options in future iterations
* Ensure all dashboard elements degrade gracefully if data is unavailable
* The dashboard needs to scale well as the number of receipts grows
* Desktop view is the priority, but the layout should adapt to tablets and mobile


