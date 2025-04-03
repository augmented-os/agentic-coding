# Business Requirements Document

## Custom Receipt/Invoice Processing System for Bookkeeping Business

### 1. Project Overview

#### 1.1 Purpose

To develop a custom receipt/invoice processing system that replaces the current Receipt Bank/Dext solution, providing a more efficient workflow for bookkeepers handling short-term rental businesses, reducing processing time, and creating vendor lock-in.

#### 1.2 Current Challenges

* Inefficient workflow for setting rental-specific fields
* Manual process for line item extraction
* Difficulty splitting costs across multiple rentals
* Inability to efficiently track receipt/invoice status

#### 1.3 Business Objectives

* Reduce processing time for receipt/invoice handling
* Lower costs for clients
* Improve accuracy of data extraction
* Create vendor lock-in through proprietary solution
* Streamline the bookkeeper workflow

### 2. System Requirements

#### 2.1 User Interfaces


1. **Client Interfaces**
   * Email submission capability
   * Progressive Web App (functioning on both mobile and desktop)
   * Web portal for upload and status tracking
2. **Bookkeeper Interface**
   * Status-based dashboard (Inbox/New, In Progress, Awaiting, Completed)
   * Multi-tenant filtering capability (prominent filter control)
   * Receipt/invoice processing workflow
   * Search and retrieval functionality for completed items

#### 2.2 Functional Requirements

##### 2.2.1 Receipt/Invoice Submission

* Accept uploads via email, mobile app, and web app
* Support common file formats (PDF, JPG, PNG, etc.)
* Provide submission confirmation to clients

##### 2.2.2 Data Extraction

* Automatically extract key data:
  * Supplier name
  * Invoice/receipt date
  * Due date
  * Line items and descriptions
  * Line item totals
  * Invoice/receipt total
  * VAT details (20% or exempt)

##### 2.2.3 Processing Workflow


1. **Extract Details** - Automatic data extraction from the receipt/invoice
2. **Match Supplier** - Identify and match suppliers from existing database
3. **Assign Line Items** - Associate line items with appropriate rentals
4. **Set Payment Details** - Configure payment information and timing
5. **Push to Xero** - Send completed entry to Xero accounting system
6. **Complete** - Mark transaction as processed and archive

##### 2.2.4 Rental and Host Management

* Dropdown selection for rental property
* Automatic population of host information based on rental selection
* Automatic assignment of account codes based on host
* Support for splitting costs equally across multiple rentals

##### 2.2.5 VAT Handling

* Support for 20% VAT rate
* Support for VAT-exempt transactions
* VAT registration status tracking for suppliers

##### 2.2.6 Status Management

* Track receipts/invoices in various states:
  * New/Inbox/Unprocessed
  * In Progress
  * Awaiting (for transactions pending bank clearance)
  * Completed
* Allow filtering by status

#### 2.3 Integration Requirements

* Utilize existing Xero integration for submitting invoices
* Pull in account codes and tracking categories from existing database
* Access rental and host information from existing tables

#### 2.4 Technical Requirements

* Multi-tenant architecture
* Progressive Web App design
* Email processing capabilities
* OCR or AI-based data extraction
* Secure data handling and storage

### 3. User Roles and Permissions

#### 3.1 Clients

* Submit receipts/invoices
* View status of submissions
* Access historical submissions

#### 3.2 Bookkeepers

* Process receipts/invoices through workflow
* Assign rentals, hosts, and account codes
* Split costs across multiple rentals
* Push completed entries to Xero
* View and search completed transactions

### 4. Success Criteria

#### 4.1 Performance Metrics

* Processing time reduction compared to current solution
* Accuracy of automated data extraction
* Client satisfaction with new system
* Cost reduction for end clients

#### 4.2 Business Outcomes

* Increased client retention through proprietary system
* Reduced processing costs
* Improved bookkeeper efficiency
* More accurate financial data in Xero

### 5. Constraints and Assumptions

#### 5.1 Constraints

* Must integrate with existing Xero integration
* Must support multi-tenant architecture
* Monthly processing volume approximately 1,000 receipts/invoices

#### 5.2 Assumptions

* Existing database structure will support new system requirements
* VAT handling limited to 20% rate and exempt status
* Cost splitting predominantly requires equal distribution

### 6. Implementation Considerations

#### 6.1 Phased Approach


1. Core system development (upload, extraction, processing)
2. Client interfaces (email, PWA)
3. Advanced features (cost splitting, awaiting state)

#### 6.2 Data Migration

* Plan for migrating existing supplier data
* Strategy for transitioning clients from Receipt Bank/Dext

### 7. Glossary

* **Rental**: Property managed for short-term rental
* **Host**: Entity that owns or manages the rental property
* **Account Code**: Accounting classification for transactions
* **Tracking Category**: Additional classification for reporting in Xero
* **VAT**: Value Added Tax (at 20% or exempt in this context)


