-- ============================================================================
-- RDBMS – Oracle
-- Exercise ORACLEDB-EX-03: BOOK Table Creation
-- ============================================================================
-- Description: Create a BOOK table with specified columns in Oracle Database
-- Requirements: Oracle SQL Developer connected to Oracle instance from EX-02
-- ============================================================================

-- Drop table if it exists (for cleanup/recreation)
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE BOOK';
   DBMS_OUTPUT.PUT_LINE('Table BOOK dropped successfully.');
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
      DBMS_OUTPUT.PUT_LINE('Table BOOK does not exist, proceeding with creation.');
END;
/

-- Create BOOK table with specified columns
CREATE TABLE BOOK (
    ID          NUMBER,
    NAME        VARCHAR2(128),
    ISBN        VARCHAR2(32),
    CREATE_DATE DATE DEFAULT SYSDATE
);

-- Add comments to document the table structure
COMMENT ON TABLE BOOK IS 'Book information table for library management';
COMMENT ON COLUMN BOOK.ID IS 'Unique identifier for each book';
COMMENT ON COLUMN BOOK.NAME IS 'Book title/name (max 128 characters)';
COMMENT ON COLUMN BOOK.ISBN IS 'International Standard Book Number (max 32 characters)';
COMMENT ON COLUMN BOOK.CREATE_DATE IS 'Date when the record was created (defaults to current date)';

-- Display table creation confirmation
SELECT 'Table BOOK created successfully!' AS STATUS FROM DUAL;

-- ============================================================================
-- Optional: Add Primary Key constraint
-- ============================================================================
-- Uncomment the following line if you want ID to be a primary key
-- ALTER TABLE BOOK ADD CONSTRAINT PK_BOOK PRIMARY KEY (ID);

-- ============================================================================
-- Optional: Create sequence for auto-incrementing ID
-- ============================================================================
-- Uncomment the following lines if you want auto-incrementing ID values
-- CREATE SEQUENCE BOOK_SEQ START WITH 1 INCREMENT BY 1;
-- 
-- -- Create trigger for auto-increment
-- CREATE OR REPLACE TRIGGER BOOK_ID_TRIGGER
-- BEFORE INSERT ON BOOK
-- FOR EACH ROW
-- BEGIN
--     :NEW.ID := BOOK_SEQ.NEXTVAL;
-- END;
-- /

-- ============================================================================
-- Sample Data Insertion Examples
-- ============================================================================
-- Example INSERT statements (uncomment to use)

-- INSERT INTO BOOK (ID, NAME, ISBN) VALUES (1, 'The Great Gatsby', '978-0-7432-7356-5');
-- INSERT INTO BOOK (ID, NAME, ISBN) VALUES (2, 'To Kill a Mockingbird', '978-0-06-112008-4');
-- INSERT INTO BOOK (ID, NAME, ISBN) VALUES (3, '1984', '978-0-452-28423-4');

-- Note: CREATE_DATE will automatically be set to SYSDATE due to DEFAULT constraint

-- ============================================================================
-- Verification Queries
-- ============================================================================
-- Uncomment the following queries to verify the table structure and data

-- -- Display table structure
-- DESCRIBE BOOK;
-- 
-- -- Show all columns and their properties
-- SELECT 
--     COLUMN_NAME,
--     DATA_TYPE,
--     DATA_LENGTH,
--     NULLABLE,
--     DATA_DEFAULT
-- FROM USER_TAB_COLUMNS 
-- WHERE TABLE_NAME = 'BOOK'
-- ORDER BY COLUMN_ID;
-- 
-- -- Display all records (if any data was inserted)
-- SELECT * FROM BOOK;

-- ============================================================================
-- End of Script
-- ============================================================================