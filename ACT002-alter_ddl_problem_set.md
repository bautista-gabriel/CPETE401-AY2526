# DDL Alterations Problem Set

**Instructions:** For each problem, write the `ALTER TABLE` statement required to achieve the desired modification.

---

### Problem 1: Add a column

**Scenario:** You have a `users` table and you need to add a column to store the user's last login timestamp.

**Initial Table Structure:**
```sql
CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE
);
```

**Task:** Add a column named `last_login` of type `TIMESTAMP`.

**Answer:**
```sql
ALTER TABLE users ADD COLUMN last_login TIMESTAMP;
```

---

### Problem 2: Modify a column's data type

**Scenario:** The `products` table has a `price` column that is currently an `INTEGER`. You need to change it to `DECIMAL(10, 2)` to support fractional prices.

**Initial Table Structure:**
```sql
CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100),
    price INT
);
```

**Task:** Modify the `price` column to be `DECIMAL(10, 2)`.

**Answer:**
```sql
ALTER TABLE products MODIFY COLUMN price DECIMAL(10, 2);
```

---

### Problem 3: Rename a column

**Scenario:** In the `employees` table, the column `emp_name` needs to be renamed to `full_name` for clarity.

**Initial Table Structure:**
```sql
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(100),
    hire_date DATE
);
```

**Task:** Rename the `emp_name` column to `full_name`.

**Answer:**
```sql
ALTER TABLE employees RENAME COLUMN emp_name TO full_name;
```

---

### Problem 4: Drop a column

**Scenario:** The `customers` table has a `middle_name` column that is no longer needed.

**Initial Table Structure:**
```sql
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    middle_name VARCHAR(50),
    last_name VARCHAR(50)
);
```

**Task:** Drop the `middle_name` column.

**Answer:**
```sql
ALTER TABLE customers DROP COLUMN middle_name;
```

---

### Problem 5: Add a `NOT NULL` constraint

**Scenario:** The `orders` table has an `order_date` column that should not be allowed to be null.

**Initial Table Structure:**
```sql
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE
);
```

**Task:** Add a `NOT NULL` constraint to the `order_date` column.

**Answer:**
```sql
ALTER TABLE orders MODIFY COLUMN order_date DATE NOT NULL;
```

---

### Problem 6: Add a `UNIQUE` constraint

**Scenario:** You want to ensure that every email in the `subscribers` table is unique.

**Initial Table Structure:**
```sql
CREATE TABLE subscribers (
    subscriber_id INT PRIMARY KEY,
    email VARCHAR(100),
    subscription_date DATE
);
```

**Task:** Add a `UNIQUE` constraint to the `email` column.

**Answer:**
```sql
ALTER TABLE subscribers ADD UNIQUE (email);
```

---

### Problem 7: Add a `FOREIGN KEY` constraint

**Scenario:** You have an `order_items` table and a `products` table. You need to link `order_items` to `products` using the `product_id`.

**Initial Table Structures:**
```sql
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100)
);

CREATE TABLE order_items (
    item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT
);
```

**Task:** Add a foreign key constraint to the `product_id` column in `order_items` that references the `product_id` in `products`.

**Answer:**
```sql
ALTER TABLE order_items ADD FOREIGN KEY (product_id) REFERENCES products(product_id);
```

---

### Problem 8: Change the default value of a column

**Scenario:** The `accounts` table has an `is_active` column that should default to `1` (true) for new accounts.

**Initial Table Structure:**
```sql
CREATE TABLE accounts (
    account_id INT PRIMARY KEY,
    username VARCHAR(50),
    is_active BOOLEAN
);
```

**Task:** Set the default value of the `is_active` column to `1`.

**Answer:**
```sql
ALTER TABLE accounts ALTER is_active SET DEFAULT 1;
```

---

### Problem 9: Add a `CHECK` constraint

**Scenario:** In the `inventory` table, the `quantity` of a product should never be negative.

**Initial Table Structure:**
```sql
CREATE TABLE inventory (
    item_id INT PRIMARY KEY,
    item_name VARCHAR(100),
    quantity INT
);
```

**Task:** Add a `CHECK` constraint to ensure the `quantity` is always greater than or equal to 0.

**Answer:**
```sql
ALTER TABLE inventory ADD CONSTRAINT chk_quantity CHECK (quantity >= 0);
```

---

### Problem 10: Rename a table

**Scenario:** The table `old_logs` needs to be renamed to `archived_logs`.

**Initial Table Structure:**
```sql
CREATE TABLE old_logs (
    log_id INT PRIMARY KEY,
    log_message TEXT,
    log_date TIMESTAMP
);
```

**Task:** Rename the table `old_logs` to `archived_logs`.

**Answer:**
```sql
ALTER TABLE old_logs RENAME TO archived_logs;
```

---

## Multiple Alterations Problem Set

**Instructions:** For each problem, write a single `ALTER TABLE` statement to perform all the required modifications.

---

### Problem 11: Add multiple columns

**Scenario:** You need to add columns for `status` and `priority` to the `tasks` table.

**Initial Table Structure:**
```sql
CREATE TABLE tasks (
    task_id INT PRIMARY KEY,
    description TEXT,
    created_at TIMESTAMP
);
```

**Task:** Add a `status` column of type `VARCHAR(20)` with a default value of 'pending' and a `priority` column of type `INT`.

**Answer:**
```sql
ALTER TABLE tasks
ADD COLUMN status VARCHAR(20) DEFAULT 'pending',
ADD COLUMN priority INT;
```

---

### Problem 12: Modify a column and add an index

**Scenario:** The `articles` table has a `slug` column that needs to be longer and indexed for faster lookups.

**Initial Table Structure:**
```sql
CREATE TABLE articles (
    article_id INT PRIMARY KEY,
    title VARCHAR(255),
    slug VARCHAR(50)
);
```

**Task:** Modify the `slug` column to `VARCHAR(100)` and add a unique index to it.

**Answer:**
```sql
ALTER TABLE articles
MODIFY COLUMN slug VARCHAR(100),
ADD UNIQUE INDEX idx_slug (slug);
```

---

### Problem 13: Drop a column and add a new one

**Scenario:** In the `employees` table, the `address` column is too generic. You need to replace it with separate columns for `street`, `city`, and `zip_code`.

**Initial Table Structure:**
```sql
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    full_name VARCHAR(100),
    address VARCHAR(255)
);
```

**Task:** Drop the `address` column and add `street` VARCHAR(150), `city` VARCHAR(100), and `zip_code` VARCHAR(20).

**Answer:**
```sql
ALTER TABLE employees
DROP COLUMN address,
ADD COLUMN street VARCHAR(150),
ADD COLUMN city VARCHAR(100),
ADD COLUMN zip_code VARCHAR(20);
```

---

### Problem 14: Rename a column and change its data type

**Scenario:** The `events` table has a `event_date` column that you want to rename to `start_time` and change its type to `DATETIME`.

**Initial Table Structure:**
```sql
CREATE TABLE events (
    event_id INT PRIMARY KEY,
    event_name VARCHAR(200),
    event_date DATE
);
```

**Task:** Rename the `event_date` column to `start_time` and modify its data type to `DATETIME`.

**Answer:**
```sql
ALTER TABLE events
CHANGE COLUMN event_date start_time DATETIME;
```

---

### Problem 15: Add a foreign key and a new column

**Scenario:** You have a `comments` table that needs to be linked to the `users` table. You also want to add a `is_approved` flag.

**Initial Table Structures:**
```sql
CREATE TABLE users (
    user_id INT PRIMARY KEY,
    username VARCHAR(50)
);

CREATE TABLE comments (
    comment_id INT PRIMARY KEY,
    comment_text TEXT,
    author_id INT
);
```

**Task:** Add a foreign key on the `author_id` column referencing `users(user_id)` and add an `is_approved` column of type `BOOLEAN` with a default of `false`.

**Answer:**
```sql
ALTER TABLE comments
ADD COLUMN is_approved BOOLEAN DEFAULT false,
ADD CONSTRAINT fk_author FOREIGN KEY (author_id) REFERENCES users(user_id);
```