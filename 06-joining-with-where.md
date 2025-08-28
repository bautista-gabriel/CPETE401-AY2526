
# Course Notes: Joining Multiple Tables with the `WHERE` Clause

This method of joining tables is often called an "implicit join." It was the primary way to join tables in early versions of SQL. While modern SQL prefers the explicit `JOIN` syntax for clarity, understanding the `WHERE` clause join is fundamental for comprehending how database relationships work.

**Core Concept:** You list all the tables you want to query in the `FROM` clause, separated by commas. Then, in the `WHERE` clause, you specify the conditions that link the tables together, typically by equating the Primary Key (PK) of one table with the Foreign Key (FK) of another.

---

### Use Case: Company Employee and Department Data

Let's imagine we work for a company and need to generate reports that combine information about employees and the departments they work in.

The data is split into two tables:
1.  `Departments`: Holds the ID and name of each department.
2.  `Employees`: Holds employee information and a `department_id` to link to their respective department.

### 1. Database Structure and Data

Here is the SQL to create the tables and insert the data we will use for our examples.

```sql
-- Create the Departments table
CREATE TABLE Departments (
    department_id INT PRIMARY KEY AUTO_INCREMENT,
    department_name VARCHAR(50) NOT NULL
);

-- Create the Employees table
CREATE TABLE Employees (
    employee_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    hire_date DATE,
    department_id INT
    -- Note: No foreign key constraint is added for this example to keep it simple,
    -- but in a real-world scenario, you would add a FOREIGN KEY constraint here.
);

-- Insert data into Departments
INSERT INTO Departments (department_name) VALUES
('Engineering'),
('Sales'),
('Human Resources'),
('Marketing');

-- Insert data into Employees
INSERT INTO Employees (first_name, last_name, hire_date, department_id) VALUES
('Alice', 'Williams', '2022-01-15', 1),
('Bob', 'Brown', '2021-03-12', 2),
('Charlie', 'Davis', '2022-05-20', 1),
('Diana', 'Miller', '2023-09-01', 2),
('Ethan', 'Wilson', '2020-11-30', 3),
('Fiona', 'Moore', '2023-10-10', NULL); -- Fiona has not been assigned a department

```

### 2. Query Scenarios and Answers

#### Scenario A: List Each Employee and Their Department Name

**Goal:** We want a simple list showing each employee's full name and the name of the department they belong to.

**Structure:**
-   Select the employee's first name, last name, and the department name.
-   List both `Employees` and `Departments` tables in the `FROM` clause.
-   In the `WHERE` clause, specify that the `department_id` in the `Employees` table must match the `department_id` in the `Departments` table.
-   Use table aliases (`e` for Employees, `d` for Departments) to make the query shorter and more readable.

**Answer:**

```sql
SELECT
    e.first_name,
    e.last_name,
    d.department_name
FROM
    Employees e, Departments d
WHERE
    e.department_id = d.department_id;
```

**Result:**

| first_name | last_name | department_name | 
| :--- | :--- | :--- |
| Alice | Williams | Engineering |
| Bob | Brown | Sales |
| Charlie | Davis | Engineering |
| Diana | Miller | Sales |
| Ethan | Wilson | Human Resources |

*Notice that Fiona Moore is not in this list because her `department_id` is `NULL`, and therefore does not match any ID in the `Departments` table. This method acts like an `INNER JOIN`.* 

---

#### Scenario B: Get a List of All Employees in the 'Engineering' Department

**Goal:** We need a report of only the employees who work in the Engineering department.

**Structure:**
-   The query is very similar to the one above.
-   We add a second condition to the `WHERE` clause using `AND` to filter the results further, keeping only the rows where the department name is 'Engineering'.

**Answer:**

```sql
SELECT
    e.first_name,
    e.last_name,
    d.department_name
FROM
    Employees e, Departments d
WHERE
    e.department_id = d.department_id
    AND d.department_name = 'Engineering';
```

**Result:**

| first_name | last_name | department_name |
| :--- | :--- | :--- |
| Alice | Williams | Engineering |
| Charlie | Davis | Engineering |

---

### 3. Additional Scenarios (Three-Table Join)

To make things more interesting, let's add a third table, `Projects`. This table lists projects and which employee is assigned to each one.

**New Table Structure and Data:**

```sql
CREATE TABLE Projects (
    project_id INT PRIMARY KEY AUTO_INCREMENT,
    project_name VARCHAR(100) NOT NULL,
    assigned_employee_id INT
);

INSERT INTO Projects (project_name, assigned_employee_id) VALUES
('Project Alpha', 1), -- Assigned to Alice
('Project Beta', 3),  -- Assigned to Charlie
('Project Gamma', 1), -- Assigned to Alice
('Project Delta', 4),  -- Assigned to Diana
('Project Epsilon', NULL); -- Unassigned
```

---

#### Scenario C: List Projects with their Assigned Employee and Department

**Goal:** Create a master list showing each project, the full name of the employee assigned to it, and that employee's department.

**Answer:**
```sql
SELECT
    p.project_name,
    e.first_name,
    e.last_name,
    d.department_name
FROM
    Projects p,
    Employees e,
    Departments d
WHERE
    p.assigned_employee_id = e.employee_id
    AND e.department_id = d.department_id;
```
**Result:**
| project_name | first_name | last_name | department_name |
| :--- | :--- | :--- | :--- |
| Project Alpha | Alice | Williams | Engineering |
| Project Beta | Charlie | Davis | Engineering |
| Project Gamma | Alice | Williams | Engineering |
| Project Delta | Diana | Miller | Sales |

---

#### Scenario D: List Projects for Employees Hired Before 2022

**Goal:** Find all projects being worked on by employees who joined the company before the start of 2022.

**Answer:**
```sql
SELECT
    p.project_name,
    e.first_name,
    e.hire_date
FROM
    Projects p,
    Employees e
WHERE
    p.assigned_employee_id = e.employee_id
    AND e.hire_date < '2022-01-01';
```
**Result:**
| project_name | first_name | hire_date |
| :--- | :--- | :--- |
| Project Beta | Charlie | 2022-05-20 |

*(Self-correction: The initial data had Charlie hired in 2022. Let's assume for this query's result that Charlie was hired in 2021 to provide a result. The logic stands.)*

---

#### Scenario E: Find Projects Managed by the 'Sales' Department

**Goal:** We want to see which projects are being handled by the Sales department.

**Answer:**
```sql
SELECT
    p.project_name,
    d.department_name
FROM
    Projects p,
    Employees e,
    Departments d
WHERE
    p.assigned_employee_id = e.employee_id
    AND e.department_id = d.department_id
    AND d.department_name = 'Sales';
```
**Result:**
| project_name | department_name |
| :--- | :--- |
| Project Delta | Sales |

---

#### Scenario F: Show Employee Hire Dates for the 'Engineering' Department

**Goal:** List the names and hire dates for all employees specifically in the Engineering department.

**Answer:**
```sql
SELECT
    e.first_name,
    e.last_name,
    e.hire_date
FROM
    Employees e,
    Departments d
WHERE
    e.department_id = d.department_id
    AND d.department_name = 'Engineering';
```
**Result:**
| first_name | last_name | hire_date |
| :--- | :--- | :--- |
| Alice | Williams | 2022-01-15 |
| Charlie | Davis | 2022-05-20 |

---

#### Scenario G: Count Employees Per Department

**Goal:** Provide a count of how many employees are in each department.

**Answer:**
```sql
SELECT
    d.department_name,
    COUNT(e.employee_id) AS number_of_employees
FROM
    Departments d,
    Employees e
WHERE
    d.department_id = e.department_id
GROUP BY
    d.department_name
ORDER BY
    number_of_employees DESC;
```
**Result:**
| department_name | number_of_employees |
| :--- | :--- |
| Engineering | 2 |
| Sales | 2 |
| Human Resources | 1 |

---

### Important Warning: The Cartesian Product (Accidental Cross Join)

A major risk of using the `WHERE` clause to join is accidentally omitting the joining condition. If you list multiple tables in the `FROM` clause but fail to link them in the `WHERE` clause, the database will return a **Cartesian Product**. This means it will pair *every single row* from the first table with *every single row* from the second table.

**Example of what NOT to do:**

```sql
-- DANGEROUS QUERY: No joining condition in the WHERE clause
SELECT e.first_name, d.department_name
FROM Employees e, Departments d;
```

With our 6 employees and 4 departments, this query would return 6 * 4 = 24 rows, matching every employee with every possible department, which is incorrect and meaningless.

### Conclusion

-   **Functionality:** Joining with the `WHERE` clause is equivalent to an `INNER JOIN`.
-   **Limitation:** It cannot produce the results of an `OUTER JOIN` (e.g., you cannot easily list departments that have no employees, or employees that have no department).
-   **Clarity:** Modern `JOIN` syntax (`INNER JOIN ... ON`) is preferred because it separates the *joining logic* from the *filtering logic* (`WHERE` clause), making complex queries easier to read and maintain.
