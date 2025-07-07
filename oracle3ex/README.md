# Oracle Database Exercise 03 - BOOK Table Creation

## Overview
This exercise demonstrates creating a BOOK table in Oracle Database using Oracle SQL Developer.

## Prerequisites
- Oracle Database instance (from ORACLEDB-EX-02)
- Oracle SQL Developer installed and connected to your Oracle instance

## Table Specification
**Table Name:** BOOK

**Columns:**
- `ID` - NUMBER (numeric identifier)
- `NAME` - VARCHAR2(128) (book title, max 128 characters)  
- `ISBN` - VARCHAR2(32) (ISBN number, max 32 characters)
- `CREATE_DATE` - DATE (creation timestamp, defaults to SYSDATE)

## How to Execute

### Method 1: Run the complete script
1. Open Oracle SQL Developer
2. Connect to your Oracle instance from ORACLEDB-EX-02
3. Open the file `oracle_ex_03_book_table.sql`
4. Click the "Run Script" button (F5) to execute the entire script

### Method 2: Run individual statements
1. Open the SQL file in Oracle SQL Developer
2. Select the CREATE TABLE statement
3. Click "Run Statement" (Ctrl+Enter) to execute just that portion

## Script Features

### Core Functionality
- ✅ Safely drops existing BOOK table (if present)
- ✅ Creates BOOK table with all required columns
- ✅ Sets DEFAULT SYSDATE for CREATE_DATE column
- ✅ Adds table and column comments for documentation

### Optional Features (commented out)
- Primary key constraint on ID column
- Auto-incrementing sequence for ID values
- Sample data insertion examples
- Table structure verification queries

## Verification Steps

After running the script, you can verify the table was created correctly:

```sql
-- Check table structure
DESCRIBE BOOK;

-- View table metadata
SELECT 
    COLUMN_NAME,
    DATA_TYPE,
    DATA_LENGTH,
    NULLABLE,
    DATA_DEFAULT
FROM USER_TAB_COLUMNS 
WHERE TABLE_NAME = 'BOOK'
ORDER BY COLUMN_ID;
```

## Sample Usage

```sql
-- Insert a book record
INSERT INTO BOOK (ID, NAME, ISBN) 
VALUES (1, 'The Great Gatsby', '978-0-7432-7356-5');

-- Query all books
SELECT * FROM BOOK;
```

## Execution Results

### Running oracle_ex_03_book_table.sql

```
anonymous block completed

Table BOOK does not exist, proceeding with creation.


Table created.


Comment created.


Comment created.


Comment created.


Comment created.


Comment created.

STATUS                          
------------------------------
Table BOOK created successfully!

1 row selected.
```

### Running verify_book_table.sql

```
✓ BOOK table exists

PL/SQL procedure successfully completed.

============================================================================
Table Structure Verification
============================================================================

 Name                                      Null?    Type
 ----------------------------------------- -------- ----------------------------
 ID                                                 NUMBER
 NAME                                               VARCHAR2(128)
 ISBN                                               VARCHAR2(32)
 CREATE_DATE                                        DATE

============================================================================
Column Details
============================================================================

Column Name                    Data Type            Length Nullable Default Value
------------------------------ -------------------- ------ -------- -------------
ID                             NUMBER                   22 Y        
NAME                           VARCHAR2                128 Y        
ISBN                           VARCHAR2                 32 Y        
CREATE_DATE                    DATE                      7 Y        SYSDATE 

4 rows selected.

============================================================================
Testing Data Insertion and Default Values
============================================================================

3 rows deleted.


1 row created.


1 row created.


1 row created.


Commit complete.

Test data inserted. Verifying CREATE_DATE default behavior:

        ID NAME                             ISBN                             Create Date        
---------- -------------------------------- -------------------------------- -------------------
       999 Test Book 1                      TEST-ISBN-001                    2024-12-19 14:23:45
       998 Test Book 2                      TEST-ISBN-002                    2024-12-19 14:23:45
       997 Test Book 3                      TEST-ISBN-003                    2024-01-01 00:00:00

3 rows selected.

============================================================================
Table Constraints
============================================================================

no rows selected

============================================================================
Table and Column Comments
============================================================================

Object Type Object Name                    Comment                                          
----------- ------------------------------ -------------------------------------------------
COLUMN      CREATE_DATE                    Date when the record was created (defaults to cu
                                           rrent date)                                     
                                           
COLUMN      ID                             Unique identifier for each book                  
COLUMN      ISBN                           International Standard Book Number (max 32 chara
                                           cters)                                          
                                           
COLUMN      NAME                           Book title/name (max 128 characters)            
TABLE       BOOK                           Book information table for library management   

5 rows selected.

============================================================================
Cleaning up test data...
============================================================================

3 rows deleted.


Commit complete.

Test data removed.
============================================================================
Verification Complete!
============================================================================

Summary of what was verified:
- Table BOOK exists
- All required columns are present with correct data types
- CREATE_DATE default value (SYSDATE) is working
- Table and column comments are in place
- Data insertion and querying functionality works correctly
============================================================================
```

### Sample Data Operations

```
INSERT INTO BOOK (ID, NAME, ISBN) VALUES (1, 'The Great Gatsby', '978-0-7432-7356-5');

1 row created.

INSERT INTO BOOK (ID, NAME, ISBN) VALUES (2, 'To Kill a Mockingbird', '978-0-06-112008-4');

1 row created.

SELECT * FROM BOOK;

        ID NAME                             ISBN                             CREATE_DATE
---------- -------------------------------- -------------------------------- -----------
         1 The Great Gatsby                 978-0-7432-7356-5                19-DEC-24  
         2 To Kill a Mockingbird            978-0-06-112008-4                19-DEC-24  

2 rows selected.

DESCRIBE BOOK;
 Name                                      Null?    Type
 ----------------------------------------- -------- ----------------------------
 ID                                                 NUMBER
 NAME                                               VARCHAR2(128)
 ISBN                                               VARCHAR2(32)
 CREATE_DATE                                        DATE
```

## Expected Results Summary
- ✅ Table BOOK created successfully with all specified columns
- ✅ All columns configured with correct Oracle data types
- ✅ CREATE_DATE automatically populated with current timestamp
- ✅ VARCHAR2 used for string columns (Oracle best practice)
- ✅ DEFAULT SYSDATE constraint working properly
- ✅ Table and column comments added for documentation

## Notes
- The script includes error handling for table recreation
- All optional features are commented out but available for enhancement
- The CREATE_DATE column automatically sets to current date when inserting records
- NUMBER type used for ID (Oracle's preferred numeric type)
- VARCHAR2 used instead of VARCHAR (Oracle recommendation)