
# Course Notes: MariaDB Querying (Single Table)

This document covers the essentials of querying a single table in MariaDB. We will explore various statements and functions to retrieve, filter, sort, and aggregate data.

## Sample Table for Examples

For our examples, let's assume we have a table named `employees`.

**Table: `employees`**

| id  | first_name | last_name | department | salary | hire_date  |
| --- | ---------- | --------- | ---------- | ------ | ---------- |
| 1   | John       | Doe       | HR         | 50000  | 2022-01-15 |
| 2   | Jane       | Smith     | IT         | 75000  | 2021-11-20 |
| 3   | Peter      | Jones     | IT         | 80000  | 2022-03-10 |
| 4   | Mary       | Williams  | Sales      | 60000  | 2022-05-02 |
| 5   | David      | Brown     | Sales      | 65000  | 2023-01-20 |
| 6   | Emily      | Davis     | HR         | 55000  | 2023-02-18 |
| 7   | Michael    | Miller    | IT         | 90000  | 2020-07-22 |


## 1. The `SELECT` Statement

The `SELECT` statement is used to query the database and retrieve data that matches criteria that you specify.

### a. Selecting All Columns

To select all columns from a table, use the `*` wildcard.

**Structure:**
```sql
SELECT * FROM table_name;
```

**Example:**
```sql
SELECT * FROM employees;
```

**Result:**
```
+----+------------+-----------+------------+--------+------------+
| id | first_name | last_name | department | salary | hire_date  |
+----+------------+-----------+------------+--------+------------+
|  1 | John       | Doe       | HR         |  50000 | 2022-01-15 |
|  2 | Jane       | Smith     | IT         |  75000 | 2021-11-20 |
|  3 | Peter      | Jones     | IT         |  80000 | 2022-03-10 |
|  4 | Mary       | Williams  | Sales      |  60000 | 2022-05-02 |
|  5 | David      | Brown     | Sales      |  65000 | 2023-01-20 |
|  6 | Emily      | Davis     | HR         |  55000 | 2023-02-18 |
|  7 | Michael    | Miller    | IT         |  90000 | 2020-07-22 |
+----+------------+-----------+------------+--------+------------+
```

### b. Selecting Specific Columns

You can specify the columns you want to retrieve.

**Structure:**
```sql
SELECT column1, column2, ... FROM table_name;
```

**Example:**
```sql
SELECT first_name, last_name, salary FROM employees;
```

**Result:**
```
+------------+-----------+--------+
| first_name | last_name | salary |
+------------+-----------+--------+
| John       | Doe       |  50000 |
| Jane       | Smith     |  75000 |
| Peter      | Jones     |  80000 |
| Mary       | Williams  |  60000 |
| David      | Brown     |  65000 |
| Emily      | Davis     |  55000 |
| Michael    | Miller    |  90000 |
+------------+-----------+--------+
```

## 2. Filtering Data with `WHERE`

The `WHERE` clause is used to filter records and extract only those that fulfill a specified condition.

**Structure:**
```sql
SELECT column1, column2, ...
FROM table_name
WHERE condition;
```

**Example: Find all employees in the 'IT' department.**
```sql
SELECT first_name, last_name, department
FROM employees
WHERE department = 'IT';
```

**Result:**
```
+------------+-----------+------------+
| first_name | last_name | department |
+------------+-----------+------------+
| Jane       | Smith     | IT         |
| Peter      | Jones     | IT         |
| Michael    | Miller    | IT         |
+------------+-----------+------------+
```

**Example: Find all employees with a salary greater than 60000.**
```sql
SELECT first_name, last_name, salary
FROM employees
WHERE salary > 60000;
```

**Result:**
```
+------------+-----------+--------+
| first_name | last_name | salary |
+------------+-----------+--------+
| Jane       | Smith     |  75000 |
| Peter      | Jones     |  80000 |
| David      | Brown     |  65000 |
| Michael    | Miller    |  90000 |
+------------+-----------+--------+
```

## 3. Sorting Results with `ORDER BY`

The `ORDER BY` keyword is used to sort the result-set in ascending or descending order.

- `ASC`: Ascending order (default)
- `DESC`: Descending order

**Structure:**
```sql
SELECT column1, column2, ...
FROM table_name
ORDER BY column_to_sort ASC|DESC;
```

**Example: Get all employees sorted by their salary in descending order.**
```sql
SELECT first_name, last_name, salary
FROM employees
ORDER BY salary DESC;
```

**Result:**
```
+------------+-----------+--------+
| first_name | last_name | salary |
+------------+-----------+--------+
| Michael    | Miller    |  90000 |
| Peter      | Jones     |  80000 |
| Jane       | Smith     |  75000 |
| David      | Brown     |  65000 |
| Mary       | Williams  |  60000 |
| Emily      | Davis     |  55000 |
| John       | Doe       |  50000 |
+------------+-----------+--------+
```

## 4. Limiting Results with `LIMIT`

The `LIMIT` clause is used to specify the number of records to return.

**Structure:**
```sql
SELECT column1, column2, ...
FROM table_name
LIMIT number_of_rows;
```

**Example: Get the top 3 highest-paid employees.**
```sql
SELECT first_name, last_name, salary
FROM employees
ORDER BY salary DESC
LIMIT 3;
```

**Result:**
```
+------------+-----------+--------+
| first_name | last_name | salary |
+------------+-----------+--------+
| Michael    | Miller    |  90000 |
| Peter      | Jones     |  80000 |
| Jane       | Smith     |  75000 |
+------------+-----------+--------+
```

## 5. Subqueries with `IN` and `EXISTS`

A subquery is a query nested inside another query.

### a. `IN` Operator

The `IN` operator allows you to specify multiple values in a `WHERE` clause. It is often used with a subquery.

**Structure:**
```sql
SELECT column_name(s)
FROM table_name
WHERE column_name IN (subquery);
```

**Example: Find employees who work in departments that have a 'Sales' or 'HR' name (using a subquery for demonstration).**
Let's assume we have another table `departments`.

**Table: `departments`**
```
+----+------------+
| id | name       |
+----+------------+
|  1 | HR         |
|  2 | IT         |
|  3 | Sales      |
+----+------------+
```

**Query:**
```sql
SELECT first_name, last_name, department
FROM employees
WHERE department IN (SELECT name FROM departments WHERE name = 'Sales' OR name = 'HR');
```

**Result:**
```
+------------+-----------+------------+
| first_name | last_name | department |
+------------+-----------+------------+
| John       | Doe       | HR         |
| Mary       | Williams  | Sales      |
| David      | Brown     | Sales      |
| Emily      | Davis     | HR         |
+------------+-----------+------------+
```

### b. `EXISTS` Operator

The `EXISTS` operator is used to test for the existence of any record in a subquery. The `EXISTS` operator returns `TRUE` if the subquery returns one or more records.

**Structure:**
```sql
SELECT column_name(s)
FROM table_name
WHERE EXISTS (subquery);
```

**Example: Find all employees who have a corresponding department in the `departments` table.**
```sql
SELECT first_name, last_name, department
FROM employees e
WHERE EXISTS (SELECT 1 FROM departments d WHERE d.name = e.department);
```
*(Note: `SELECT 1` is a common convention as the actual value selected in the subquery doesn't matter, only that a row is returned)*

**Result:**
The query will return all employees because for each employee's department, a matching name exists in the `departments` table.

## 6. Aggregate Functions

Aggregate functions perform a calculation on a set of values and return a single value.

### a. `COUNT()`

The `COUNT()` function returns the number of rows that matches a specified criterion.

**Example: How many employees are in the 'IT' department?**
```sql
SELECT COUNT(*)
FROM employees
WHERE department = 'IT';
```

**Result:**
```
+----------+
| COUNT(*) |
+----------+
|        3 |
+----------+
```

### b. `SUM()`

The `SUM()` function returns the total sum of a numeric column.

**Example: What is the total salary paid to employees in the 'Sales' department?**
```sql
SELECT SUM(salary)
FROM employees
WHERE department = 'Sales';
```

**Result:**
```
+-------------+
| SUM(salary) |
+-------------+
|      125000 |
+-------------+
```

### c. `AVG()`

The `AVG()` function returns the average value of a numeric column.

**Example: What is the average salary for all employees?**
```sql
SELECT AVG(salary)
FROM employees;
```

**Result:**
```
+-------------+
| AVG(salary) |
+-------------+
|  67857.1429 |
+-------------+
```

### d. `MIN()` and `MAX()`

- `MIN()`: Returns the smallest value of the selected column.
- `MAX()`: Returns the largest value of the selected column.

**Example: Find the minimum and maximum salaries.**
```sql
SELECT MIN(salary) AS min_salary, MAX(salary) AS max_salary
FROM employees;
```

**Result:**
```
+------------+------------+
| min_salary | max_salary |
+------------+------------+
|      50000 |      90000 |
+------------+------------+
```

## 7. Grouping Data with `GROUP BY`

The `GROUP BY` statement groups rows that have the same values into summary rows, like "find the number of employees in each department". The `GROUP BY` statement is often used with aggregate functions (`COUNT`, `MAX`, `MIN`, `SUM`, `AVG`) to group the result-set by one or more columns.

**Structure:**
```sql
SELECT column_name(s), aggregate_function(column_name)
FROM table_name
GROUP BY column_name(s);
```

**Example: Count the number of employees in each department.**
```sql
SELECT department, COUNT(*) AS number_of_employees
FROM employees
GROUP BY department;
```

**Result:**
```
+------------+---------------------+
| department | number_of_employees |
+------------+---------------------+
| HR         |                   2 |
| IT         |                   3 |
| Sales      |                   2 |
+------------+---------------------+
```

**Example: Find the average salary for each department.**
```sql
SELECT department, AVG(salary) AS average_salary
FROM employees
GROUP BY department;
```

**Result:**
```
+------------+----------------+
| department | average_salary |
+------------+----------------+
| HR         |     52500.0000 |
| IT         |     81666.6667 |
| Sales      |     62500.0000 |
+------------+----------------+
```

## 8. Filtering Groups with `HAVING`

The `HAVING` clause was added to SQL because the `WHERE` keyword cannot be used with aggregate functions. `HAVING` enables you to filter groups based on the results of aggregate functions.

**Structure:**
```sql
SELECT column_name(s), aggregate_function(column_name)
FROM table_name
GROUP BY column_name(s)
HAVING condition;
```

**Example: List departments that have more than 2 employees.**
```sql
SELECT department, COUNT(*) AS number_of_employees
FROM employees
GROUP BY department
HAVING COUNT(*) > 2;
```

**Result:**
```
+------------+---------------------+
| department | number_of_employees |
+------------+---------------------+
| IT         |                   3 |
+------------+---------------------+
```

**Example: List departments with an average salary greater than 60000.**
```sql
SELECT department, AVG(salary) AS average_salary
FROM employees
GROUP BY department
HAVING AVG(salary) > 60000;
```

**Result:**
```
+------------+----------------+
| department | average_salary |
+------------+----------------+
| IT         |     81666.6667 |
| Sales      |     62500.0000 |
+------------+----------------+
```
