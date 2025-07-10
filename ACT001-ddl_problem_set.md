
# DDL Problem Set: Creating MariaDB Tables

This document contains a series of problem sets designed to test your ability to create well-structured tables in MariaDB using Data Definition Language (DDL). For each problem, read the scenario and requirements carefully, then write the necessary `CREATE TABLE` statements.

Check your work against the suggested solution provided in the collapsible section.

---

## Problem 1: Online Bookstore Inventory

**Scenario:** You are building the backend for an online bookstore. You need to track books, their authors, and the publishers. A book can have multiple authors, and an author can write multiple books.

**Requirements:**

1.  **`authors` table:**
    *   A unique ID for each author.
    *   Author's first name and last name (required).
    *   A short biography (optional).
    *   Date of birth (optional).

2.  **`publishers` table:**
    *   A unique ID for each publisher.
    *   Publisher's name (required and must be unique).
    *   Country of origin (required).

3.  **`books` table:**
    *   A unique ID for each book.
    *   The book's title (required).
    *   The ISBN (International Standard Book Number), which must be unique.
    *   Publication date (required).
    *   Price (required, must be a positive value).
    *   A foreign key linking to the `publishers` table. If a publisher is deleted, this key should become `NULL`.

4.  **`book_authors` linking table:**
    *   A table to resolve the many-to-many relationship between books and authors.
    *   It should contain foreign keys referencing the `books` and `authors` tables.
    *   The combination of a book and an author must be unique.
    *   If a book or an author is deleted, the corresponding record in this table should also be deleted.

<details>
<summary>Click for Suggested Solution</summary>

```sql
-- Authors Table
CREATE TABLE authors (
    author_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    biography TEXT NULL,
    date_of_birth DATE NULL,
    PRIMARY KEY (author_id)
);

-- Publishers Table
CREATE TABLE publishers (
    publisher_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    publisher_name VARCHAR(255) NOT NULL,
    country VARCHAR(100) NOT NULL,
    PRIMARY KEY (publisher_id),
    UNIQUE KEY uk_publisher_name (publisher_name)
);

-- Books Table
CREATE TABLE books (
    book_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    isbn VARCHAR(20) NOT NULL,
    publication_date DATE NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    publisher_id INT UNSIGNED NULL,
    PRIMARY KEY (book_id),
    UNIQUE KEY uk_isbn (isbn),
    CONSTRAINT chk_price CHECK (price > 0),
    FOREIGN KEY (publisher_id) REFERENCES publishers(publisher_id) ON DELETE SET NULL
);

-- Book-Authors Linking Table
CREATE TABLE book_authors (
    book_id BIGINT UNSIGNED NOT NULL,
    author_id INT UNSIGNED NOT NULL,
    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY (book_id) REFERENCES books(book_id) ON DELETE CASCADE,
    FOREIGN KEY (author_id) REFERENCES authors(author_id) ON DELETE CASCADE
);
```

</details>

---

## Problem 2: Clinic Appointment System

**Scenario:** You are designing a database for a small medical clinic. You need to manage doctors, patients, and their appointments.

**Requirements:**

1.  **`patients` table:**
    *   A unique ID for each patient.
    *   Patient's first name, last name, and date of birth (all required).
    *   A unique phone number for contact.
    *   The date the patient record was created.

2.  **`doctors` table:**
    *   A unique ID for each doctor.
    *   Doctor's first name and last name (required).
    *   A medical specialty (e.g., 'Cardiology', 'Pediatrics') which is required.
    *   The year they were licensed to practice (e.g., 2010).

3.  **`appointments` table:**
    *   A unique ID for each appointment.
    *   Foreign keys to link to one `patient` and one `doctor`.
    *   The date and time of the appointment (required).
    *   The reason for the visit (a short text field).
    *   The status of the appointment, which can only be one of the following: 'Scheduled', 'Completed', 'Canceled', 'No-Show'. The default should be 'Scheduled'.
    *   If a patient or doctor is deleted from the system, their appointments should also be deleted.

<details>
<summary>Click for Suggested Solution</summary>

```sql
-- Patients Table
CREATE TABLE patients (
    patient_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    date_of_birth DATE NOT NULL,
    phone_number VARCHAR(25) NOT NULL,
    record_created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (patient_id),
    UNIQUE KEY uk_phone_number (phone_number)
);

-- Doctors Table
CREATE TABLE doctors (
    doctor_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    specialty VARCHAR(100) NOT NULL,
    license_year YEAR NOT NULL,
    PRIMARY KEY (doctor_id)
);

-- Appointments Table
CREATE TABLE appointments (
    appointment_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    patient_id BIGINT UNSIGNED NOT NULL,
    doctor_id INT UNSIGNED NOT NULL,
    appointment_datetime DATETIME NOT NULL,
    reason_for_visit VARCHAR(255) NULL,
    status ENUM('Scheduled', 'Completed', 'Canceled', 'No-Show') DEFAULT 'Scheduled',
    PRIMARY KEY (appointment_id),
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id) ON DELETE CASCADE,
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id) ON DELETE CASCADE
);
```

</details>

---

## Problem 3: University Course Catalog

**Scenario:** You are creating a database for a university's course catalog. You need to store information about departments and the courses they offer. Some courses have prerequisites, which are other courses in the same table.

**Requirements:**

1.  **`departments` table:**
    *   A unique ID for each department.
    *   The department name (e.g., 'Computer Science'), which must be unique.
    *   The department's office location (e.g., 'Building 5, Room 201').

2.  **`courses` table:**
    *   A unique ID for each course.
    *   A course code (e.g., 'CS101'), which must be unique.
    *   The course title (e.g., 'Introduction to Programming').
    *   The number of credits (a small, positive integer).
    *   A foreign key linking to the `departments` table. If a department is deleted, all its courses should also be deleted.
    *   A self-referencing foreign key named `prerequisite_course_id` that links to another course's ID within the *same* table. This indicates that a course must be taken before this one. This field should be optional (a course may not have a prerequisite).
    *   If a prerequisite course is deleted, the `prerequisite_course_id` for any course that depends on it should be set to `NULL`.

<details>
<summary>Click for Suggested Solution</summary>

```sql
-- Departments Table
CREATE TABLE departments (
    department_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    department_name VARCHAR(150) NOT NULL,
    office_location VARCHAR(100) NULL,
    PRIMARY KEY (department_id),
    UNIQUE KEY uk_department_name (department_name)
);

-- Courses Table
CREATE TABLE courses (
    course_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    course_code VARCHAR(20) NOT NULL,
    course_title VARCHAR(255) NOT NULL,
    credits TINYINT UNSIGNED NOT NULL,
    department_id INT UNSIGNED NOT NULL,
    prerequisite_course_id INT UNSIGNED NULL,
    PRIMARY KEY (course_id),
    UNIQUE KEY uk_course_code (course_code),
    FOREIGN KEY (department_id) REFERENCES departments(department_id) ON DELETE CASCADE,
    FOREIGN KEY (prerequisite_course_id) REFERENCES courses(course_id) ON DELETE SET NULL
);
```

</details>
