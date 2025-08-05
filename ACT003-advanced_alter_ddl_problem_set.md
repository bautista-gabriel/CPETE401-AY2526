
# Advanced DDL Alterations Problem Set (Hard)

**Instructions:** For each problem, write a single `ALTER TABLE` statement to perform all the required modifications. These problems focus on complex, multi-part alterations.

---

### Problem 1: Restructure User Profile Information

**Scenario:** The `user_profiles` table has a single `bio` column and an `account_type` stored as a string. You need to break down the bio into more specific fields, change the `account_type` to a more efficient data type, and add a new field for social media links.

**Initial Table Structure:**
```sql
CREATE TABLE user_profiles (
    profile_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    bio TEXT,
    account_type VARCHAR(50) DEFAULT 'basic',
    join_date DATE
);
```

**Task:**
1.  Drop the `bio` column.
2.  Add a `tagline` column of type `VARCHAR(100)`.
3.  Add a `personal_statement` column of type `TEXT`.
4.  Change the `account_type` column to be `ENUM('basic', 'premium', 'enterprise')` with a default of 'basic'.
5.  Add a `website_url` column of type `VARCHAR(255)`.

**Answer:**
```sql
ALTER TABLE user_profiles
DROP COLUMN bio,
ADD COLUMN tagline VARCHAR(100),
ADD COLUMN personal_statement TEXT,
MODIFY COLUMN account_type ENUM('basic', 'premium', 'enterprise') DEFAULT 'basic',
ADD COLUMN website_url VARCHAR(255);
```

---

### Problem 2: Overhaul Product Details

**Scenario:** The `products` table has a generic `description` and a `release_date` stored as a `VARCHAR`. You need to replace the description, change the release date format, and add manufacturing details.

**Initial Table Structure:**
```sql
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(255),
    description VARCHAR(255),
    release_date VARCHAR(50)
);
```

**Task:**
1.  Rename the `description` column to `summary` and change its type to `TEXT`.
2.  Change the `release_date` column to be of type `DATE`.
3.  Add a `manufacturer_id` column of type `INT`.
4.  Add a `sku` (Stock Keeping Unit) column of type `VARCHAR(100)`.

**Answer:**
```sql
ALTER TABLE products
CHANGE COLUMN description summary TEXT,
MODIFY COLUMN release_date DATE,
ADD COLUMN manufacturer_id INT,
ADD COLUMN sku VARCHAR(100);
```

---

### Problem 3: Refactor Employee Records

**Scenario:** The `employees` table uses a single `contact_info` column and has a `department` column that needs to be renamed and its data type changed. You also need to add a column for the employee's level.

**Initial Table Structure:**
```sql
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    full_name VARCHAR(100),
    contact_info VARCHAR(255),
    department VARCHAR(50)
);
```

**Task:**
1.  Drop the `contact_info` column.
2.  Add an `email` column of type `VARCHAR(100)`.
3.  Add a `phone_number` column of type `VARCHAR(20)`.
4.  Rename the `department` column to `department_code` and change its type to `INT`.
5.  Add a `job_level` column of type `INT`.

**Answer:**
```sql
ALTER TABLE employees
DROP COLUMN contact_info,
ADD COLUMN email VARCHAR(100),
ADD COLUMN phone_number VARCHAR(20),
CHANGE COLUMN department department_code INT,
ADD COLUMN job_level INT;
```

---

### Problem 4: Consolidate Customer Data

**Scenario:** The `customers` table has separate columns for different parts of an address and a `notes` column that is no longer needed. You need to consolidate the address and add a customer status field.

**Initial Table Structure:**
```sql
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    address_street VARCHAR(100),
    address_city VARCHAR(50),
    address_state VARCHAR(50),
    notes TEXT
);
```

**Task:**
1.  Drop the `address_street`, `address_city`, and `address_state` columns.
2.  Drop the `notes` column.
3.  Add a `full_address` column of type `VARCHAR(255)`.
4.  Add a `status` column of type `ENUM('active', 'inactive', 'prospect')` with a default of 'prospect'.

**Answer:**
```sql
ALTER TABLE customers
DROP COLUMN address_street,
DROP COLUMN address_city,
DROP COLUMN address_state,
DROP COLUMN notes,
ADD COLUMN full_address VARCHAR(255),
ADD COLUMN status ENUM('active', 'inactive', 'prospect') DEFAULT 'prospect';
```

---

### Problem 5: Adjusting Log File Structure

**Scenario:** The `system_logs` table has a `log_level` stored as a string and a `details` column that needs to be renamed. You also need to add columns for the source IP and user agent.

**Initial Table Structure:**
```sql
CREATE TABLE system_logs (
    log_id BIGINT PRIMARY KEY,
    log_timestamp TIMESTAMP,
    log_level VARCHAR(20),
    details TEXT
);
```

**Task:**
1.  Modify the `log_level` column to be `ENUM('INFO', 'WARN', 'ERROR', 'DEBUG')`.
2.  Rename the `details` column to `log_message`.
3.  Add a `source_ip` column of type `VARCHAR(45)`.
4.  Add a `user_agent` column of type `VARCHAR(255)`.

**Answer:**
```sql
ALTER TABLE system_logs
MODIFY COLUMN log_level ENUM('INFO', 'WARN', 'ERROR', 'DEBUG'),
CHANGE COLUMN details log_message TEXT,
ADD COLUMN source_ip VARCHAR(45),
ADD COLUMN user_agent VARCHAR(255);
```

---

### Problem 6: Reorganizing Document Metadata

**Scenario:** The `documents` table has a `file_path` that needs to be changed to `storage_key`, and a generic `metadata` column. You need to replace the metadata column with more specific fields.

**Initial Table Structure:**
```sql
CREATE TABLE documents (
    doc_id INT PRIMARY KEY,
    title VARCHAR(255),
    file_path VARCHAR(255),
    metadata JSON
);
```

**Task:**
1.  Rename the `file_path` column to `storage_key` and change its type to `VARCHAR(500)`.
2.  Drop the `metadata` column.
3.  Add a `file_size_kb` column of type `INT`.
4.  Add a `mime_type` column of type `VARCHAR(100)`.
5.  Add a `version` column of type `INT` with a default value of 1.

**Answer:**
```sql
ALTER TABLE documents
CHANGE COLUMN file_path storage_key VARCHAR(500),
DROP COLUMN metadata,
ADD COLUMN file_size_kb INT,
ADD COLUMN mime_type VARCHAR(100),
ADD COLUMN version INT DEFAULT 1;
```

---

### Problem 7: Updating Course Information

**Scenario:** The `courses` table has a `course_code` that needs to be longer, a `credits` column that should support decimals, and an `instructor` column to be replaced by `instructor_id`.

**Initial Table Structure:**
```sql
CREATE TABLE courses (
    course_id INT PRIMARY KEY,
    course_code VARCHAR(10),
    course_title VARCHAR(150),
    credits INT,
    instructor VARCHAR(100)
);
```

**Task:**
1.  Modify the `course_code` column to be `VARCHAR(20)`.
2.  Modify the `credits` column to be `DECIMAL(3, 1)`.
3.  Drop the `instructor` column.
4.  Add an `instructor_id` column of type `INT`.

**Answer:**
```sql
ALTER TABLE courses
MODIFY COLUMN course_code VARCHAR(20),
MODIFY COLUMN credits DECIMAL(3, 1),
DROP COLUMN instructor,
ADD COLUMN instructor_id INT;
```

---

### Problem 8: Enhancing Order Details

**Scenario:** The `orders` table has a `shipping_info` text field that needs to be broken down. It also needs a `status` column to be changed and a column for tracking information.

**Initial Table Structure:**
```sql
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    order_date DATETIME,
    shipping_info TEXT,
    status VARCHAR(20)
);
```

**Task:**
1.  Drop the `shipping_info` column.
2.  Add a `shipping_address` column of type `VARCHAR(255)`.
3.  Add a `shipping_carrier` column of type `VARCHAR(50)`.
4.  Modify the `status` column to be `ENUM('placed', 'shipped', 'delivered', 'cancelled')`.
5.  Add a `tracking_number` column of type `VARCHAR(100)`.

**Answer:**
```sql
ALTER TABLE orders
DROP COLUMN shipping_info,
ADD COLUMN shipping_address VARCHAR(255),
ADD COLUMN shipping_carrier VARCHAR(50),
MODIFY COLUMN status ENUM('placed', 'shipped', 'delivered', 'cancelled'),
ADD COLUMN tracking_number VARCHAR(100);
```

---

### Problem 9: Restructuring Media Library

**Scenario:** The `media_library` table has a `filename` that needs renaming and a `file_type` that needs to be more specific. You also need to add dimensions and duration.

**Initial Table Structure:**
```sql
CREATE TABLE media_library (
    media_id INT PRIMARY KEY,
    filename VARCHAR(255),
    upload_date TIMESTAMP,
    file_type VARCHAR(10)
);
```

**Task:**
1.  Rename the `filename` column to `media_title` and change its type to `VARCHAR(200)`.
2.  Modify the `file_type` column to be `ENUM('video', 'audio', 'image')`.
3.  Add a `duration_seconds` column of type `INT`.
4.  Add a `width_pixels` column of type `INT`.
5.  Add a `height_pixels` column of type `INT`.

**Answer:**
```sql
ALTER TABLE media_library
CHANGE COLUMN filename media_title VARCHAR(200),
MODIFY COLUMN file_type ENUM('video', 'audio', 'image'),
ADD COLUMN duration_seconds INT,
ADD COLUMN width_pixels INT,
ADD COLUMN height_pixels INT;
```

---

### Problem 10: Overhauling Vehicle Specifications

**Scenario:** The `vehicles` table has a `specs` JSON column that is being deprecated in favor of individual columns. The `model_year` also needs to be changed to a more appropriate type.

**Initial Table Structure:**
```sql
CREATE TABLE vehicles (
    vehicle_id INT PRIMARY KEY,
    make VARCHAR(50),
    model VARCHAR(50),
    model_year VARCHAR(4),
    specs JSON
);
```

**Task:**
1.  Drop the `specs` column.
2.  Modify the `model_year` column to be of type `YEAR`.
3.  Add an `engine_type` column of type `VARCHAR(50)`.
4.  Add a `transmission` column of type `ENUM('automatic', 'manual')`.
5.  Add a `color` column of type `VARCHAR(30)`.

**Answer:**
```sql
ALTER TABLE vehicles
DROP COLUMN specs,
MODIFY COLUMN model_year YEAR,
ADD COLUMN engine_type VARCHAR(50),
ADD COLUMN transmission ENUM('automatic', 'manual'),
ADD COLUMN color VARCHAR(30);
```
