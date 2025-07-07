-- Oracle Database Express Edition Setup Script
-- File: setup.sql
-- Description: Initial database setup for Oracle XE 21.3.0

-- Connect as SYSDBA
CONNECT sys/ORACLE@//localhost:1521/XE as sysdba

-- Display database information
PROMPT ========================================
PROMPT Oracle Database Information
PROMPT ========================================

SELECT name AS database_name, 
       created AS creation_date,
       log_mode
FROM v$database;

SELECT instance_name, 
       status, 
       startup_time,
       version
FROM v$instance;

-- Create tablespace for application data
PROMPT ========================================
PROMPT Creating Application Tablespace
PROMPT ========================================

CREATE TABLESPACE app_data
DATAFILE '/opt/oracle/oradata/XE/app_data01.dbf'
SIZE 100M
AUTOEXTEND ON
NEXT 10M
MAXSIZE 1G;

-- Create application user
PROMPT ========================================
PROMPT Creating Application User
PROMPT ========================================

-- Drop user if exists
BEGIN
    EXECUTE IMMEDIATE 'DROP USER appuser CASCADE';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -1918 THEN -- User does not exist
            RAISE;
        END IF;
END;
/

-- Create new user
CREATE USER appuser 
IDENTIFIED BY AppPass123
DEFAULT TABLESPACE app_data
TEMPORARY TABLESPACE temp
QUOTA UNLIMITED ON app_data;

-- Grant necessary privileges
GRANT CONNECT, RESOURCE TO appuser;
GRANT CREATE SESSION TO appuser;
GRANT CREATE TABLE TO appuser;
GRANT CREATE VIEW TO appuser;
GRANT CREATE SEQUENCE TO appuser;
GRANT CREATE PROCEDURE TO appuser;

-- Create demo user for testing
PROMPT ========================================
PROMPT Creating Demo User
PROMPT ========================================

-- Drop demo user if exists
BEGIN
    EXECUTE IMMEDIATE 'DROP USER demouser CASCADE';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -1918 THEN -- User does not exist
            RAISE;
        END IF;
END;
/

-- Create demo user
CREATE USER demouser 
IDENTIFIED BY Demo123
DEFAULT TABLESPACE app_data
TEMPORARY TABLESPACE temp
QUOTA 50M ON app_data;

-- Grant basic privileges
GRANT CONNECT, RESOURCE TO demouser;
GRANT CREATE SESSION TO demouser;

-- Connect as application user to create schema
PROMPT ========================================
PROMPT Creating Application Schema
PROMPT ========================================

CONNECT appuser/AppPass123@//localhost:1521/XE

-- Create departments table
CREATE TABLE departments (
    dept_id NUMBER(4) PRIMARY KEY,
    dept_name VARCHAR2(50) NOT NULL,
    location VARCHAR2(50),
    created_date DATE DEFAULT SYSDATE
);

-- Create employees table
CREATE TABLE employees (
    emp_id NUMBER(6) PRIMARY KEY,
    first_name VARCHAR2(20) NOT NULL,
    last_name VARCHAR2(25) NOT NULL,
    email VARCHAR2(50) UNIQUE NOT NULL,
    phone VARCHAR2(20),
    hire_date DATE DEFAULT SYSDATE,
    job_title VARCHAR2(50),
    salary NUMBER(8,2),
    dept_id NUMBER(4),
    manager_id NUMBER(6),
    CONSTRAINT fk_emp_dept FOREIGN KEY (dept_id) REFERENCES departments(dept_id),
    CONSTRAINT fk_emp_mgr FOREIGN KEY (manager_id) REFERENCES employees(emp_id)
);

-- Create projects table
CREATE TABLE projects (
    project_id NUMBER(6) PRIMARY KEY,
    project_name VARCHAR2(100) NOT NULL,
    description CLOB,
    start_date DATE,
    end_date DATE,
    budget NUMBER(12,2),
    status VARCHAR2(20) DEFAULT 'PLANNED',
    dept_id NUMBER(4),
    CONSTRAINT fk_proj_dept FOREIGN KEY (dept_id) REFERENCES departments(dept_id),
    CONSTRAINT chk_status CHECK (status IN ('PLANNED', 'ACTIVE', 'COMPLETED', 'CANCELLED'))
);

-- Create sequences
CREATE SEQUENCE dept_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE emp_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE proj_seq START WITH 1 INCREMENT BY 1;

-- Insert sample data
PROMPT ========================================
PROMPT Inserting Sample Data
PROMPT ========================================

-- Insert departments
INSERT INTO departments VALUES (dept_seq.NEXTVAL, 'Information Technology', 'Building A', SYSDATE);
INSERT INTO departments VALUES (dept_seq.NEXTVAL, 'Human Resources', 'Building B', SYSDATE);
INSERT INTO departments VALUES (dept_seq.NEXTVAL, 'Finance', 'Building C', SYSDATE);
INSERT INTO departments VALUES (dept_seq.NEXTVAL, 'Marketing', 'Building D', SYSDATE);

-- Insert employees
INSERT INTO employees VALUES (emp_seq.NEXTVAL, 'John', 'Doe', 'john.doe@company.com', '555-1234', SYSDATE, 'Database Administrator', 75000, 1, NULL);
INSERT INTO employees VALUES (emp_seq.NEXTVAL, 'Jane', 'Smith', 'jane.smith@company.com', '555-5678', SYSDATE, 'HR Manager', 65000, 2, NULL);
INSERT INTO employees VALUES (emp_seq.NEXTVAL, 'Bob', 'Johnson', 'bob.johnson@company.com', '555-9012', SYSDATE, 'Software Developer', 70000, 1, 1);
INSERT INTO employees VALUES (emp_seq.NEXTVAL, 'Alice', 'Brown', 'alice.brown@company.com', '555-3456', SYSDATE, 'Financial Analyst', 60000, 3, NULL);

-- Insert projects
INSERT INTO projects VALUES (proj_seq.NEXTVAL, 'Database Migration', 'Migrate legacy database to Oracle 21c', SYSDATE, ADD_MONTHS(SYSDATE, 6), 150000, 'ACTIVE', 1);
INSERT INTO projects VALUES (proj_seq.NEXTVAL, 'Employee Portal', 'Develop new employee self-service portal', SYSDATE, ADD_MONTHS(SYSDATE, 4), 100000, 'PLANNED', 1);
INSERT INTO projects VALUES (proj_seq.NEXTVAL, 'Financial Reporting System', 'Implement new financial reporting system', SYSDATE, ADD_MONTHS(SYSDATE, 8), 200000, 'PLANNED', 3);

-- Create views
CREATE VIEW emp_dept_view AS
SELECT e.emp_id, 
       e.first_name || ' ' || e.last_name AS full_name,
       e.email,
       e.job_title,
       e.salary,
       d.dept_name,
       d.location
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id;

-- Create indexes for performance
CREATE INDEX idx_emp_dept ON employees(dept_id);
CREATE INDEX idx_emp_email ON employees(email);
CREATE INDEX idx_proj_dept ON projects(dept_id);

-- Commit all changes
COMMIT;

PROMPT ========================================
PROMPT Database Setup Complete!
PROMPT ========================================

-- Display summary
SELECT 'Departments' AS table_name, COUNT(*) AS record_count FROM departments
UNION ALL
SELECT 'Employees' AS table_name, COUNT(*) AS record_count FROM employees
UNION ALL
SELECT 'Projects' AS table_name, COUNT(*) AS record_count FROM projects;

PROMPT
PROMPT To connect as application user:
PROMPT CONNECT appuser/AppPass123@//localhost:1521/XE
PROMPT
PROMPT To connect as demo user:
PROMPT CONNECT demouser/Demo123@//localhost:1521/XE
PROMPT