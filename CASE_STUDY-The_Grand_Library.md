# Case Study: The Grand Library

## Scenario

The Grand Library is a large, public library that needs a database to manage its collection of books, its members, and the borrowing process. The library wants to keep track of which books are available, who has borrowed which books, and when they are due to be returned.

## Entities and Relationships

*   **`Books`**: Each book has a unique ID, a title, an author, a genre, and a publication year.
*   **`Members`**: Each member has a unique ID, a name, an email address, and a membership start date.
*   **`Loans`**: This table tracks which member has borrowed which book. It includes the loan date and the due date.

## Schema (DDL)

```sql
CREATE TABLE Books (
    BookID INT PRIMARY KEY,
    Title VARCHAR(255),
    Author VARCHAR(255),
    Genre VARCHAR(100),
    PublicationYear INT
);

CREATE TABLE Members (
    MemberID INT PRIMARY KEY,
    Name VARCHAR(255),
    Email VARCHAR(255),
    MembershipDate DATE
);

CREATE TABLE Loans (
    LoanID INT PRIMARY KEY,
    BookID INT,
    MemberID INT,
    LoanDate DATE,
    DueDate DATE,
    FOREIGN KEY (BookID) REFERENCES Books(BookID),
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID)
);
```

## Data (DML)

```sql
-- Inserting data into Books table
INSERT INTO Books (BookID, Title, Author, Genre, PublicationYear) VALUES
(1, 'The Great Gatsby', 'F. Scott Fitzgerald', 'Fiction', 1925),
(2, 'To Kill a Mockingbird', 'Harper Lee', 'Fiction', 1960),
(3, '1984', 'George Orwell', 'Dystopian', 1949),
(4, 'The Catcher in the Rye', 'J.D. Salinger', 'Fiction', 1951),
(5, 'The Lord of the Rings', 'J.R.R. Tolkien', 'Fantasy', 1954),
(6, 'Pride and Prejudice', 'Jane Austen', 'Romance', 1813),
(7, 'The Hobbit', 'J.R.R. Tolkien', 'Fantasy', 1937),
(8, 'Brave New World', 'Aldous Huxley', 'Dystopian', 1932),
(9, 'The Chronicles of Narnia', 'C.S. Lewis', 'Fantasy', 1950),
(10, 'Animal Farm', 'George Orwell', 'Political Satire', 1945);

-- Inserting data into Members table
INSERT INTO Members (MemberID, Name, Email, MembershipDate) VALUES
(101, 'Alice Johnson', 'alice.j@example.com', '2022-01-15'),
(102, 'Bob Smith', 'bob.s@example.com', '2022-03-22'),
(103, 'Charlie Brown', 'charlie.b@example.com', '2022-05-30'),
(104, 'Diana Prince', 'diana.p@example.com', '2022-07-11'),
(105, 'Ethan Hunt', 'ethan.h@example.com', '2022-09-05');

-- Inserting data into Loans table
INSERT INTO Loans (LoanID, BookID, MemberID, LoanDate, DueDate) VALUES
(1001, 1, 101, '2023-01-10', '2023-01-24'),
(1002, 3, 101, '2023-01-10', '2023-01-24'),
(1003, 5, 102, '2023-01-12', '2023-01-26'),
(1004, 7, 103, '2023-01-15', '2023-01-29'),
(1005, 2, 104, '2023-01-18', '2023-02-01'),
(1006, 4, 105, '2023-01-20', '2023-02-03'),
(1007, 6, 102, '2023-01-22', '2023-02-05'),
(1008, 8, 103, '2023-01-25', '2023-02-08'),
(1009, 10, 101, '2023-01-28', '2023-02-11'),
(1010, 9, 104, '2023-01-30', '2023-02-13');
```

## Problem Sets (Using Inner Queries with `IN` operator)

**Problem 1:** Find the titles of all books written by authors who have also written 'Fantasy' books.

**Problem 2:** Find the names of all members who have borrowed books published before 1950.

**Problem 3:** Find the titles of all books that have been borrowed by members who joined the library in 2022.

**Problem 4:** Find the names of members who have borrowed books from the 'Dystopian' genre.

**Problem 5:** Find the titles of all books that were loaned out in January 2023.

## Answers

**Answer 1:**
```sql
SELECT Title
FROM Books
WHERE Author IN (SELECT Author FROM Books WHERE Genre = 'Fantasy');
```

**Answer 2:**
```sql
SELECT Name
FROM Members
WHERE MemberID IN (SELECT MemberID FROM Loans WHERE BookID IN (SELECT BookID FROM Books WHERE PublicationYear < 1950));
```

**Answer 3:**
```sql
SELECT Title
FROM Books
WHERE BookID IN (SELECT BookID FROM Loans WHERE MemberID IN (SELECT MemberID FROM Members WHERE YEAR(MembershipDate) = '2022'));
```

**Answer 4:**
```sql
SELECT Name
FROM Members
WHERE MemberID IN (SELECT MemberID FROM Loans WHERE BookID IN (SELECT BookID FROM Books WHERE Genre = 'Dystopian'));
```

**Answer 5:**
```sql
*SELECT Title
FROM Books
WHERE BookID IN (SELECT BookID FROM Loans WHERE YEAR(LoanDate) = '2023' AND MONTH(LoanDate) = '01' );*
```
