# Product Requirements Document

## Receipt/Invoice Processing System Prototype

### 1. Product Overview

#### 1.1 Purpose

To develop a rapid prototype of the receipt/invoice processing system that demonstrates core functionality while using a simplified architecture for quick deployment.

#### 1.2 Target Users

* Bookkeepers managing short-term rental accounts
* Clients submitting receipts/invoices (limited functionality in prototype)

#### 1.3 MVP Scope

The prototype will focus on essential functionality:

* Receipt/invoice upload and processing
* Basic data extraction
* Assignment to rentals and hosts
* Simplified Xero integration

### 2. Technical Specifications

#### 2.1 Architecture

* Backend database: Supabase
* File storage: Supabase Storage Buckets
* Authentication: Supabase Auth

#### 2.2 Data Model

##### Core Tables

* `tenants` - Client information
* `rentals` - Rental property details
* `hosts` - Host/owner information
* `suppliers` - Vendor/supplier details
* `receipts` - Receipt/invoice metadata
* `receipt_line_items` - Individual line items from receipts
* `account_codes` - Accounting classifications
* `tracking_categories` - Additional classifications for Xero reporting

#### 2.3 File Storage

* Use Supabase buckets for storing uploaded receipt/invoice files
* Organize files by client and date for easy retrieval
* Implement appropriate access controls

### 3. Functional Requirements

#### 3.1 Minimum Viable Features

##### 3.1.1 Receipt/Invoice Upload

* Web interface for manual upload
* Support for PDF, JPG, and PNG formats
* Basic validation of uploaded files

##### 3.1.2 Data Extraction

* Manual data entry form for prototype phase
* Future integration point for OCR/AI extraction

##### 3.1.3 Processing Workflow


1. Upload receipt/invoice file
2. Enter or confirm extracted data
3. Select supplier from existing list or add new
4. Assign to rental property
5. Set payment details
6. Mark as ready for Xero

##### 3.1.4 Status Management

* Basic status tracking: New, In Progress, Pending, Completed
* Filter view by status

#### 3.2 Bookkeeper Interface

* Simple dashboard showing receipts by status
* Receipt processing workflow screens
* Client/rental filtering capability
* Search functionality for existing records

### 4. User Experience

#### 4.1 Bookkeeper Web Interface

* Focus on efficiency and minimal clicks
* Responsive design for desktop use
* Clear status indicators and filters
* Intuitive receipt processing flow

### 5. Integration Points

#### 5.1 Xero Integration

* Simplified connection to existing Xero integration
* Manual trigger to send completed receipts to Xero
* Confirmation of successful Xero submission

### 6. Prototype Limitations

The following features are deferred for future development:

* Automated OCR/AI data extraction
* Email submission capability
* Mobile app interface
* Cost splitting across multiple rentals
* Advanced status tracking (Awaiting state)
* Client portal

### 7. Development Priorities

#### 7.1 Phase 1: Core Functionality

* Database setup in Supabase
* File upload to Supabase buckets
* Basic bookkeeper dashboard
* Manual receipt processing workflow

#### 7.2 Phase 2: Usability Improvements

* Search and filtering enhancements
* Bulk operations
* Status management refinement

#### 7.3 Phase 3: Integration

* Xero connection
* Export functionality

### 8. Success Criteria

#### 8.1 Prototype Completion Criteria

* Bookkeepers can upload and process receipts through the entire workflow
* Data can be manually entered and associated with appropriate rentals
* Records can be filtered and searched
* Basic integration with Xero is functional

#### 8.2 Feedback Collection Plan

* Structured user testing with bookkeeping team
* Documentation of pain points and enhancement requests
* Prioritization of features for full production version


