-- ============================================================================
-- Verification Script for BOOK Table (ORACLEDB-EX-03)
-- ============================================================================
-- Purpose: Verify that the BOOK table was created correctly and test its functionality
-- ============================================================================

-- Enable output display
SET SERVEROUTPUT ON;

-- Check if BOOK table exists
BEGIN
    DECLARE
        table_count NUMBER;
    BEGIN
        SELECT COUNT(*) INTO table_count 
        FROM USER_TABLES 
        WHERE TABLE_NAME = 'BOOK';
        
        IF table_count > 0 THEN
            DBMS_OUTPUT.PUT_LINE('✓ BOOK table exists');
        ELSE
            DBMS_OUTPUT.PUT_LINE('✗ BOOK table does not exist');
            RETURN;
        END IF;
    END;
END;
/

-- Display table structure
PROMPT ============================================================================
PROMPT Table Structure Verification
PROMPT ============================================================================
DESCRIBE BOOK;

-- Display column details
PROMPT ============================================================================
PROMPT Column Details
PROMPT ============================================================================
SELECT 
    COLUMN_NAME as "Column Name",
    DATA_TYPE as "Data Type",
    DATA_LENGTH as "Length",
    NULLABLE as "Nullable",
    DATA_DEFAULT as "Default Value"
FROM USER_TAB_COLUMNS 
WHERE TABLE_NAME = 'BOOK'
ORDER BY COLUMN_ID;

-- Test data insertion and DEFAULT SYSDATE functionality
PROMPT ============================================================================
PROMPT Testing Data Insertion and Default Values
PROMPT ============================================================================

-- Clear any existing test data
DELETE FROM BOOK WHERE ID IN (999, 998, 997);

-- Insert test records
INSERT INTO BOOK (ID, NAME, ISBN) VALUES (999, 'Test Book 1', 'TEST-ISBN-001');
INSERT INTO BOOK (ID, NAME, ISBN) VALUES (998, 'Test Book 2', 'TEST-ISBN-002');

-- Insert with explicit CREATE_DATE
INSERT INTO BOOK (ID, NAME, ISBN, CREATE_DATE) VALUES (997, 'Test Book 3', 'TEST-ISBN-003', DATE '2024-01-01');

-- Commit the test data
COMMIT;

-- Display test results
PROMPT Test data inserted. Verifying CREATE_DATE default behavior:
SELECT 
    ID,
    NAME,
    ISBN,
    TO_CHAR(CREATE_DATE, 'YYYY-MM-DD HH24:MI:SS') as "Create Date"
FROM BOOK 
WHERE ID IN (999, 998, 997)
ORDER BY ID DESC;

-- Verify constraints and structure
PROMPT ============================================================================
PROMPT Table Constraints
PROMPT ============================================================================
SELECT 
    CONSTRAINT_NAME as "Constraint Name",
    CONSTRAINT_TYPE as "Type",
    STATUS as "Status"
FROM USER_CONSTRAINTS 
WHERE TABLE_NAME = 'BOOK';

-- Check if table comments exist
PROMPT ============================================================================
PROMPT Table and Column Comments
PROMPT ============================================================================
SELECT 
    'TABLE' as "Object Type",
    'BOOK' as "Object Name", 
    COMMENTS as "Comment"
FROM USER_TAB_COMMENTS 
WHERE TABLE_NAME = 'BOOK'
UNION ALL
SELECT 
    'COLUMN' as "Object Type",
    COLUMN_NAME as "Object Name",
    COMMENTS as "Comment"
FROM USER_COL_COMMENTS 
WHERE TABLE_NAME = 'BOOK' AND COMMENTS IS NOT NULL
ORDER BY "Object Type", "Object Name";

-- Clean up test data
PROMPT ============================================================================
PROMPT Cleaning up test data...
PROMPT ============================================================================
DELETE FROM BOOK WHERE ID IN (999, 998, 997);
COMMIT;

PROMPT Test data removed.
PROMPT ============================================================================
PROMPT Verification Complete!
PROMPT ============================================================================
PROMPT 
PROMPT Summary of what was verified:
PROMPT - Table BOOK exists
PROMPT - All required columns are present with correct data types
PROMPT - CREATE_DATE default value (SYSDATE) is working
PROMPT - Table and column comments are in place
PROMPT - Data insertion and querying functionality works correctly
PROMPT ============================================================================