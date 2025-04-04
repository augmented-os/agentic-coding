-- Migration file 001: Create enum types
-- Description: Defines all enum types needed for the receipt processing system

-- User roles
CREATE TYPE user_role AS ENUM ('admin', 'bookkeeper', 'client');

-- Receipt processing status
CREATE TYPE receipt_status AS ENUM ('new', 'in_progress', 'pending', 'completed');

-- File status
CREATE TYPE file_status AS ENUM ('active', 'archived', 'deleted');

-- Receipt type
CREATE TYPE receipt_type AS ENUM ('direct', 'disbursement');

-- Upload source types
CREATE TYPE upload_source AS ENUM ('email', 'webapp');

-- Xero account types
CREATE TYPE xero_account_type AS ENUM (
  'BANK', 'CURRENT', 'CURRLIAB', 'DEPRECIATN', 'DIRECTCOSTS', 
  'EQUITY', 'EXPENSE', 'FIXED', 'INVENTORY', 'LIABILITY', 
  'NONCURRENT', 'OTHERINCOME', 'OVERHEADS', 'PREPAYMENT', 
  'REVENUE', 'SALES', 'TERMLIAB'
);

-- Xero account classes
CREATE TYPE xero_account_class AS ENUM (
  'ASSET', 'EQUITY', 'EXPENSE', 'LIABILITY', 'REVENUE'
);

-- Xero status
CREATE TYPE xero_status AS ENUM ('ACTIVE', 'ARCHIVED');

-- Receipt workflow state (tracks which step in the 6-step workflow)
CREATE TYPE receipt_state AS ENUM (
  'extract_details',      -- Step 1: Extract Details
  'match_supplier',       -- Step 2: Match Supplier
  'assign_line_items',    -- Step 3: Assign Line Items
  'set_payment_details',  -- Step 4: Set Payment Details
  'push_to_xero',         -- Step 5: Push to Xero
  'complete'              -- Step 6: Complete
); 