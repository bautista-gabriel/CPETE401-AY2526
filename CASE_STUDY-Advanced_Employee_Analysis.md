# Advanced Case Study: Corporate HR Database

## Introduction

This case study provides a comprehensive challenge for advanced SQL users. You will work with a normalized HR database consisting of six interconnected tables. The problems require a deep understanding of joins, subqueries, aggregate functions, and complex query construction to analyze employee, department, and location data.

## Database Schema

Here is the schema for the corporate HR database:

**Tables:**
1.  `regions`: Stores region information (e.g., Americas, Europe).
2.  `countries`: Stores country information and links to regions.
3.  `locations`: Stores office location details and links to countries.
4.  `departments`: Stores department information and links to locations.
5.  `jobs`: Stores job titles and salary ranges.
6.  `employees`: Stores employee details and links to jobs, departments, and managers.

**Visual Schema:**

```
+-----------+      +-------------+      +-------------+
|  regions  |      |  countries  |      |  locations  |
+-----------+      +-------------+      +-------------+
| region_id |<---- | country_id  |<---- | location_id |
| region_name|     | country_name|      | city        |
+-----------+      | region_id   |      | country_id  |
                   +-------------+      +-------------+
                                             ^
                                             |
                                             |
+---------------+      +-----------------+   |
|     jobs      |      |   departments   |---+
+---------------+      +-----------------+
| job_id        |<---- | department_id   |
| job_title     |      | department_name |
| min_salary    |      | location_id     |
| max_salary    |      +-----------------+
+---------------+              ^
        ^                      |
        |                      |
        |      +-----------------+
        +------|    employees    |
               +-----------------+
               | employee_id     |
               | first_name      |
               | last_name       |
               | email           |
               | hire_date       |
               | salary          |
               | job_id          |
               | department_id   |
               | manager_id      |
               +-----------------+
```

## Table Structures

```sql
CREATE TABLE regions (
    region_id INT PRIMARY KEY AUTO_INCREMENT,
    region_name VARCHAR(25)
);

CREATE TABLE countries (
    country_id CHAR(2) PRIMARY KEY,
    country_name VARCHAR(40),
    region_id INT,
    FOREIGN KEY (region_id) REFERENCES regions(region_id)
);

CREATE TABLE locations (
    location_id INT PRIMARY KEY AUTO_INCREMENT,
    street_address VARCHAR(40),
    postal_code VARCHAR(12),
    city VARCHAR(30) NOT NULL,
    state_province VARCHAR(25),
    country_id CHAR(2),
    FOREIGN KEY (country_id) REFERENCES countries(country_id)
);

CREATE TABLE departments (
    department_id INT PRIMARY KEY AUTO_INCREMENT,
    department_name VARCHAR(30) NOT NULL,
    location_id INT,
    FOREIGN KEY (location_id) REFERENCES locations(location_id)
);

CREATE TABLE jobs (
    job_id VARCHAR(10) PRIMARY KEY,
    job_title VARCHAR(35) NOT NULL,
    min_salary DECIMAL(8, 2),
    max_salary DECIMAL(8, 2)
);

CREATE TABLE employees (
    employee_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(20),
    last_name VARCHAR(25) NOT NULL,
    email VARCHAR(25) NOT NULL UNIQUE,
    phone_number VARCHAR(20),
    hire_date DATE NOT NULL,
    job_id VARCHAR(10) NOT NULL,
    salary DECIMAL(8, 2) NOT NULL,
    commission_pct DECIMAL(2, 2),
    manager_id INT,
    department_id INT,
    FOREIGN KEY (job_id) REFERENCES jobs(job_id),
    FOREIGN KEY (department_id) REFERENCES departments(department_id),
    FOREIGN KEY (manager_id) REFERENCES employees(employee_id)
);
```

## Data

```sql
-- Regions
INSERT INTO regions (region_id, region_name) VALUES (1, 'Europe'), (2, 'Americas'), (3, 'Asia');

-- Countries
INSERT INTO countries (country_id, country_name, region_id) VALUES ('US', 'United States of America', 2), ('CA', 'Canada', 2), ('UK', 'United Kingdom', 1), ('DE', 'Germany', 1);

-- Locations
INSERT INTO locations (location_id, street_address, postal_code, city, state_province, country_id) VALUES 
(1000, '1297 Via Cola di Rie', '00989', 'Rome', 'RM', 'IT'),
(1100, '93091 Calle della Testa', '10934', 'Venice', 'VE', 'IT'),
(1200, '2017 Shinjuku-ku', '1689', 'Tokyo', 'Tokyo Prefecture', 'JP'),
(1400, '2014 Jabberwocky Rd', '26192', 'Southlake', 'Texas', 'US'),
(1500, '2011 Interiors Blvd', '99236', 'South San Francisco', 'California', 'US'),
(1700, '2004 Charade Rd', '98199', 'Seattle', 'Washington', 'US'),
(1800, '147 Spadina Ave', 'M5V 2L7', 'Toronto', 'Ontario', 'CA'),
(2000, '40-5-12 Laogianggen', '190518', 'Beijing', NULL, 'CN'),
(2400, '8204 Arthur St', NULL, 'London', NULL, 'UK'),
(2500, 'Magdalen Centre, The Oxford Science Park', 'OX9 9ZB', 'Oxford', 'Oxford', 'UK');

-- Departments
INSERT INTO departments (department_id, department_name, location_id) VALUES 
(10, 'Administration', 1700),
(20, 'Marketing', 1800),
(30, 'Purchasing', 1700),
(40, 'Human Resources', 2400),
(50, 'Shipping', 1500),
(60, 'IT', 1400),
(70, 'Public Relations', 2400),
(80, 'Sales', 2500),
(90, 'Executive', 1700),
(100, 'Finance', 1700),
(110, 'Accounting', 1700);

-- Jobs
INSERT INTO jobs (job_id, job_title, min_salary, max_salary) VALUES 
('AD_PRES', 'President', 20000, 40000),
('AD_VP', 'Administration Vice President', 15000, 30000),
('IT_PROG', 'Programmer', 4000, 10000),
('FI_MGR', 'Finance Manager', 8200, 16000),
('FI_ACCOUNT', 'Accountant', 4200, 9000),
('PU_MAN', 'Purchasing Manager', 8000, 15000),
('PU_CLERK', 'Purchasing Clerk', 2500, 5500),
('ST_MAN', 'Stock Manager', 5500, 8500),
('ST_CLERK', 'Stock Clerk', 2000, 5000),
('SA_MAN', 'Sales Manager', 10000, 20000),
('SA_REP', 'Sales Representative', 6000, 12000);

-- Employees
INSERT INTO employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES
(100, 'Steven', 'King', 'sking', '515.123.4567', '2020-06-17', 'AD_PRES', 24000.00, NULL, NULL, 90),
(101, 'Neena', 'Kochhar', 'nkochhar', '515.123.4568', '2021-09-21', 'AD_VP', 17000.00, NULL, 100, 90),
(102, 'Lex', 'De Haan', 'ldehaan', '515.123.4569', '2021-01-13', 'AD_VP', 17000.00, NULL, 100, 90),
(103, 'Alexander', 'Hunold', 'ahunold', '590.423.4567', '2022-01-03', 'IT_PROG', 9000.00, NULL, 102, 60),
(104, 'Bruce', 'Ernst', 'bernst', '590.423.4568', '2022-05-21', 'IT_PROG', 6000.00, NULL, 103, 60),
(108, 'Nancy', 'Greenberg', 'ngreenbe', '515.124.4569', '2022-08-17', 'FI_MGR', 12008.00, NULL, 101, 100),
(109, 'Daniel', 'Faviet', 'dfaviet', '515.124.4169', '2022-08-16', 'FI_ACCOUNT', 9000.00, NULL, 108, 100),
(114, 'Den', 'Raphaely', 'draphael', '515.127.4561', '2022-12-07', 'PU_MAN', 11000.00, NULL, 100, 30),
(115, 'Alexander', 'Khoo', 'akhoo', '515.127.4562', '2023-05-18', 'PU_CLERK', 3100.00, NULL, 114, 30),
(121, 'Adam', 'Fripp', 'afripp', '650.123.2234', '2021-04-10', 'ST_MAN', 8200.00, NULL, 100, 50),
(122, 'Payam', 'Kaufling', 'pkaufli', '650.123.3234', '2023-05-01', 'ST_MAN', 7900.00, NULL, 100, 50),
(145, 'John', 'Russell', 'jrussel', '011.44.1344.429268', '2020-10-01', 'SA_MAN', 14000.00, 0.4, 100, 80),
(146, 'Karen', 'Partners', 'kpartner', '011.44.1344.467268', '2021-01-05', 'SA_MAN', 13500.00, 0.3, 100, 80),
(150, 'Peter', 'Tucker', 'ptucker', '011.44.1344.129268', '2021-01-30', 'SA_REP', 10000.00, 0.3, 145, 80),
(151, 'David', 'Bernstein', 'dbernste', '011.44.1344.345268', '2021-03-24', 'SA_REP', 9500.00, 0.25, 145, 80);
```

## Problem Set (No Joins)

1.  **Employees with Salary Above Average**: Find all employees whose salary is greater than the overall average salary.
2.  **Highest Earning Employee**: Find the full name of the employee with the highest salary.
3.  **Employees in the Executive Department**: Find the full names of all employees who work in the department with `department_id` 90.
4.  **Count Employees Hired in 2022**: Find the total number of employees hired during the year 2022.
5.  **Employees Without a Manager**: Find the full names of all employees who do not have a manager.
6.  **Employees with Commission**: Count the number of employees who receive a commission.
7.  **Programmers in the Company**: Find the full names of all employees whose `job_id` is 'IT_PROG'.
8.  **Employees Earning More Than a Specific Colleague**: Find the names of all employees who earn more than 'Neena Kochhar'.
9.  **Employees Hired After a Specific Colleague**: Find the names of all employees who were hired after 'Lex De Haan'.
10. **Salary Range Query**: Find the full names of all employees with a salary between $9,000 and $12,000.
11. **Departments Without Employees**: Find the `department_name` of all departments that have no employees.
12. **Jobs Without Employees**: Find the `job_title` of all jobs that are not currently filled by any employee.
13. **Employees with the Same Job as a Colleague**: Find the names of all employees who hold the same job as 'Bruce Ernst', excluding Bruce himself.
14. **Employees in Finance-Related Departments**: Find the full names of all employees working in departments with `department_id` 100 or 110.
15. **Second Highest Salary**: Find the full name and salary of the employee(s) with the second-highest salary in the company.

---

## Solutions (No Joins)

```sql
-- 1. Employees with Salary Above Average
SELECT first_name, last_name, salary FROM employees WHERE salary > (SELECT AVG(salary) FROM employees);

-- 2. Highest Earning Employee
SELECT first_name, last_name FROM employees WHERE salary = (SELECT MAX(salary) FROM employees);

-- 3. Employees in the Executive Department
SELECT first_name, last_name FROM employees WHERE department_id = 90;

-- 4. Count Employees Hired in 2022
SELECT COUNT(*) AS employees_hired_in_2022 FROM employees WHERE YEAR(hire_date) = 2022;

-- 5. Employees Without a Manager
SELECT first_name, last_name FROM employees WHERE manager_id IS NULL;

-- 6. Employees with Commission
SELECT COUNT(*) AS employees_with_commission FROM employees WHERE commission_pct IS NOT NULL;

-- 7. Programmers in the Company
SELECT first_name, last_name FROM employees WHERE job_id = 'IT_PROG';

-- 8. Employees Earning More Than a Specific Colleague
SELECT first_name, last_name FROM employees WHERE salary > (SELECT salary FROM employees WHERE first_name = 'Neena' AND last_name = 'Kochhar');

-- 9. Employees Hired After a Specific Colleague
SELECT first_name, last_name FROM employees WHERE hire_date > (SELECT hire_date FROM employees WHERE first_name = 'Lex' AND last_name = 'De Haan');

-- 10. Salary Range Query
SELECT first_name, last_name FROM employees WHERE salary BETWEEN 9000 AND 12000;

-- 11. Departments Without Employees
SELECT department_name FROM departments WHERE department_id NOT IN (SELECT DISTINCT department_id FROM employees WHERE department_id IS NOT NULL);

-- 12. Jobs Without Employees
SELECT job_title FROM jobs WHERE job_id NOT IN (SELECT DISTINCT job_id FROM employees);

-- 13. Employees with the Same Job as a Colleague
SELECT first_name, last_name FROM employees WHERE job_id = (SELECT job_id FROM employees WHERE first_name = 'Bruce' AND last_name = 'Ernst') AND employee_id != (SELECT employee_id FROM employees WHERE first_name = 'Bruce' AND last_name = 'Ernst');

-- 14. Employees in Finance-Related Departments
SELECT first_name, last_name FROM employees WHERE department_id IN (100, 110);

-- 15. Second Highest Salary
SELECT first_name, last_name, salary FROM employees WHERE salary = (SELECT MAX(salary) FROM employees WHERE salary < (SELECT MAX(salary) FROM employees));
```

## Problem Set (Multiple Subqueries with Aggregate Functions, No Joins)

1.  **Total Salary of a Specific Department in a Specific Country**: Find the total salary of all employees working in the 'Sales' department in the 'United Kingdom'.
2.  **Lowest Salary in a Specific Job in a Specific Location**: Find the minimum salary of all 'Sales Representatives' working in 'Oxford'.
3.  **Highest Salary of an Employee Hired in a Specific Year in a Specific Department**: Find the maximum salary of an employee who was hired in 2021 and works in the 'Sales' department.
4.  **Number of Employees in a Specific Department with Salary Above a Certain Amount**: Count the number of employees in the 'IT' department who earn more than the salary of 'Daniel Faviet'.
5.  **Average Salary of Employees in a Specific Region**: Find the average salary of all employees working in the 'Americas' region.

---

## Solutions (Multiple Subqueries with Aggregate Functions, No Joins)

```sql
-- 1. Total Salary of a Specific Department in a Specific Country
SELECT SUM(salary)
FROM employees
WHERE department_id = (
  SELECT department_id
  FROM departments
  WHERE department_name = 'Sales'
  AND location_id IN (
    SELECT location_id
    FROM locations
    WHERE country_id = 'UK'
  )
);

-- 2. Lowest Salary in a Specific Job in a Specific Location
SELECT MIN(salary)
FROM employees
WHERE job_id = (
  SELECT job_id
  FROM jobs
  WHERE job_title = 'Sales Representative'
)
AND department_id = (
  SELECT department_id
  FROM departments
  WHERE location_id = (
    SELECT location_id
    FROM locations
    WHERE city = 'Oxford'
  )
);

-- 3. Highest Salary of an Employee Hired in a Specific Year in a Specific Department
SELECT MAX(salary)
FROM employees
WHERE YEAR(hire_date) = 2021
AND department_id = (
  SELECT department_id
  FROM departments
  WHERE department_name = 'Sales'
);

-- 4. Number of Employees in a Specific Department with Salary Above a Certain Amount
SELECT COUNT(*)
FROM employees
WHERE department_id = (
  SELECT department_id
  FROM departments
  WHERE department_name = 'IT'
)
AND salary > (
  SELECT salary
  FROM employees
  WHERE first_name = 'Daniel' AND last_name = 'Faviet'
);

-- 5. Average Salary of Employees in a Specific Region
SELECT AVG(salary)
FROM employees
WHERE department_id IN (
  SELECT department_id
  FROM departments
  WHERE location_id IN (
    SELECT location_id
    FROM locations
    WHERE country_id IN (
      SELECT country_id
      FROM countries
      WHERE region_id = (
        SELECT region_id
        FROM regions
        WHERE region_name = 'Americas'
      )
    )
  )
);
```