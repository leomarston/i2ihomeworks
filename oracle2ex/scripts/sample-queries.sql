-- Oracle Database Sample Queries
-- File: sample-queries.sql
-- Description: Comprehensive collection of sample SQL queries for Oracle XE 21.3.0

-- Connect as application user
CONNECT appuser/AppPass123@//localhost:1521/XE

-- Basic Data Retrieval
PROMPT ========================================
PROMPT Basic Data Retrieval Examples
PROMPT ========================================

-- Select all departments
SELECT * FROM departments ORDER BY dept_id;

-- Select all employees with department names
SELECT e.emp_id,
       e.first_name,
       e.last_name,
       e.job_title,
       e.salary,
       d.dept_name
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id
ORDER BY e.last_name;

-- Select projects with budget greater than 100,000
SELECT project_name, budget, status
FROM projects
WHERE budget > 100000
ORDER BY budget DESC;

-- Aggregate Functions
PROMPT ========================================
PROMPT Aggregate Function Examples
PROMPT ========================================

-- Count employees by department
SELECT d.dept_name,
       COUNT(e.emp_id) AS employee_count,
       AVG(e.salary) AS avg_salary,
       MAX(e.salary) AS max_salary,
       MIN(e.salary) AS min_salary
FROM departments d
LEFT JOIN employees e ON d.dept_id = e.dept_id
GROUP BY d.dept_name
ORDER BY employee_count DESC;

-- Total project budget by department
SELECT d.dept_name,
       COUNT(p.project_id) AS project_count,
       NVL(SUM(p.budget), 0) AS total_budget
FROM departments d
LEFT JOIN projects p ON d.dept_id = p.dept_id
GROUP BY d.dept_name
ORDER BY total_budget DESC;

-- Advanced Queries
PROMPT ========================================
PROMPT Advanced Query Examples
PROMPT ========================================

-- Employees earning above average salary
SELECT emp_id,
       first_name || ' ' || last_name AS full_name,
       salary,
       (SELECT AVG(salary) FROM employees) AS avg_salary,
       salary - (SELECT AVG(salary) FROM employees) AS above_avg
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees)
ORDER BY salary DESC;

-- Hierarchical query for employee management structure
SELECT LEVEL,
       LPAD(' ', (LEVEL-1)*2, ' ') || first_name || ' ' || last_name AS employee_hierarchy,
       job_title,
       salary
FROM employees
START WITH manager_id IS NULL
CONNECT BY PRIOR emp_id = manager_id
ORDER SIBLINGS BY last_name;

-- Window Functions
PROMPT ========================================
PROMPT Window Function Examples
PROMPT ========================================

-- Rank employees by salary within their department
SELECT emp_id,
       first_name || ' ' || last_name AS full_name,
       d.dept_name,
       salary,
       RANK() OVER (PARTITION BY e.dept_id ORDER BY salary DESC) AS salary_rank,
       DENSE_RANK() OVER (PARTITION BY e.dept_id ORDER BY salary DESC) AS salary_dense_rank,
       ROW_NUMBER() OVER (PARTITION BY e.dept_id ORDER BY salary DESC) AS row_num
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id
ORDER BY d.dept_name, salary DESC;

-- Running total of project budgets
SELECT project_name,
       budget,
       SUM(budget) OVER (ORDER BY project_id ROWS UNBOUNDED PRECEDING) AS running_total,
       AVG(budget) OVER (ORDER BY project_id ROWS 2 PRECEDING) AS moving_avg_3
FROM projects
ORDER BY project_id;

-- Date Functions
PROMPT ========================================
PROMPT Date Function Examples
PROMPT ========================================

-- Employee tenure analysis
SELECT emp_id,
       first_name || ' ' || last_name AS full_name,
       hire_date,
       SYSDATE AS current_date,
       TRUNC(MONTHS_BETWEEN(SYSDATE, hire_date)) AS months_employed,
       TRUNC(MONTHS_BETWEEN(SYSDATE, hire_date) / 12, 2) AS years_employed,
       CASE 
           WHEN MONTHS_BETWEEN(SYSDATE, hire_date) < 12 THEN 'New Employee'
           WHEN MONTHS_BETWEEN(SYSDATE, hire_date) < 60 THEN 'Experienced'
           ELSE 'Veteran'
       END AS employee_category
FROM employees
ORDER BY hire_date;

-- Project timeline analysis
SELECT project_name,
       start_date,
       end_date,
       TRUNC(end_date - start_date) AS duration_days,
       TRUNC(MONTHS_BETWEEN(end_date, start_date), 1) AS duration_months,
       CASE
           WHEN end_date < SYSDATE THEN 'Overdue'
           WHEN start_date > SYSDATE THEN 'Future'
           ELSE 'Active'
       END AS project_status
FROM projects
WHERE start_date IS NOT NULL AND end_date IS NOT NULL
ORDER BY start_date;

-- String Functions
PROMPT ========================================
PROMPT String Function Examples
PROMPT ========================================

-- Email domain analysis
SELECT SUBSTR(email, INSTR(email, '@') + 1) AS email_domain,
       COUNT(*) AS employee_count
FROM employees
GROUP BY SUBSTR(email, INSTR(email, '@') + 1)
ORDER BY employee_count DESC;

-- Name formatting examples
SELECT emp_id,
       first_name,
       last_name,
       UPPER(first_name || ' ' || last_name) AS full_name_upper,
       LOWER(first_name || ' ' || last_name) AS full_name_lower,
       INITCAP(first_name || ' ' || last_name) AS full_name_proper,
       SUBSTR(first_name, 1, 1) || '.' || SUBSTR(last_name, 1, 1) || '.' AS initials,
       LENGTH(first_name || last_name) AS name_length
FROM employees
ORDER BY last_name;

-- Subqueries and CTEs
PROMPT ========================================
PROMPT Common Table Expression Examples
PROMPT ========================================

-- Find departments with highest average salary
WITH dept_avg_salary AS (
    SELECT d.dept_id,
           d.dept_name,
           AVG(e.salary) AS avg_salary,
           COUNT(e.emp_id) AS emp_count
    FROM departments d
    LEFT JOIN employees e ON d.dept_id = e.dept_id
    GROUP BY d.dept_id, d.dept_name
),
max_avg_salary AS (
    SELECT MAX(avg_salary) AS max_avg
    FROM dept_avg_salary
)
SELECT das.dept_name,
       ROUND(das.avg_salary, 2) AS avg_salary,
       das.emp_count
FROM dept_avg_salary das
CROSS JOIN max_avg_salary mas
WHERE das.avg_salary = mas.max_avg;

-- Recursive CTE for organizational hierarchy
WITH RECURSIVE emp_hierarchy AS (
    -- Base case: top-level managers
    SELECT emp_id, first_name, last_name, manager_id, job_title, 1 as level,
           first_name || ' ' || last_name as path
    FROM employees
    WHERE manager_id IS NULL
    
    UNION ALL
    
    -- Recursive case: employees with managers
    SELECT e.emp_id, e.first_name, e.last_name, e.manager_id, e.job_title, 
           eh.level + 1,
           eh.path || ' -> ' || e.first_name || ' ' || e.last_name
    FROM employees e
    JOIN emp_hierarchy eh ON e.manager_id = eh.emp_id
)
SELECT level, LPAD(' ', (level-1)*2, ' ') || first_name || ' ' || last_name AS hierarchy,
       job_title, path
FROM emp_hierarchy
ORDER BY level, last_name;

-- Data Modification Examples
PROMPT ========================================
PROMPT Data Modification Examples
PROMPT ========================================

-- Create a backup table
CREATE TABLE employees_backup AS SELECT * FROM employees;

-- Update example: Give 5% raise to IT department
UPDATE employees 
SET salary = salary * 1.05
WHERE dept_id = (SELECT dept_id FROM departments WHERE dept_name = 'Information Technology');

-- Show the changes
SELECT e.first_name || ' ' || e.last_name AS full_name,
       e.salary AS current_salary,
       eb.salary AS original_salary,
       e.salary - eb.salary AS raise_amount
FROM employees e
JOIN employees_backup eb ON e.emp_id = eb.emp_id
WHERE e.salary != eb.salary;

-- Rollback the changes
ROLLBACK;

-- Performance and System Views
PROMPT ========================================
PROMPT System Information Queries
PROMPT ========================================

-- Database information
SELECT name AS database_name,
       created,
       log_mode,
       open_mode
FROM v$database;

-- Instance information
SELECT instance_name,
       host_name,
       version,
       startup_time,
       status
FROM v$instance;

-- Session information
SELECT username,
       status,
       machine,
       program,
       logon_time
FROM v$session
WHERE username IS NOT NULL
ORDER BY logon_time DESC;

-- Table space usage
SELECT tablespace_name,
       ROUND(bytes/1024/1024, 2) AS size_mb,
       ROUND(maxbytes/1024/1024, 2) AS max_size_mb,
       autoextensible
FROM dba_data_files
ORDER BY tablespace_name;

-- Object counts by type
SELECT object_type,
       COUNT(*) AS object_count
FROM user_objects
GROUP BY object_type
ORDER BY object_count DESC;

PROMPT ========================================
PROMPT Sample Queries Complete!
PROMPT ========================================

-- Clean up backup table
DROP TABLE employees_backup;

PROMPT
PROMPT All sample queries have been executed successfully.
PROMPT You can modify and run these queries to explore Oracle database features.
PROMPT