-- Selects all columns from the BOOK table
SELECT * FROM BOOK;

-- Selects only the TITLE and PRICE columns from the BOOK table
SELECT TITLE, PRICE FROM BOOK;

-- Selects TITLE and calculates 20% of PRICE for each book
SELECT TITLE, PRICE * 0.20 FROM BOOK;

-- Selects TITLE and PRICE for books published by publisher with code 'PL'
SELECT TITLE, PRICE FROM BOOK WHERE PUBLISHER_CODE = 'PL';

-- Selects TITLE and PRICE for books with PRICE between 10 and 20 (inclusive)
SELECT 
  TITLE, PRICE 
FROM 
  BOOK 
WHERE 
  PRICE >= 10 AND PRICE <= 20;

-- Same as above, but uses BETWEEN for range filtering
SELECT 
  TITLE, PRICE 
FROM 
  BOOK 
WHERE 
  PRICE BETWEEN 10 AND 20;

-- Incorrect: No book can have both publisher codes 'TB' and 'FA' at the same time
SELECT * FROM BOOK WHERE PUBLISHER_CODE = 'TB' AND PUBLISHER_CODE = 'FA';

-- Selects books with publisher code either 'TB' or 'FA'
SELECT * FROM BOOK WHERE PUBLISHER_CODE = 'TB' OR PUBLISHER_CODE = 'FA';

-- Same as above, but uses IN for multiple values
SELECT * FROM BOOK WHERE PUBLISHER_CODE IN ('TB','FA');

-- Wildcard explanations:
-- %  - Matches any number of characters
-- _  - Matches exactly one character

-- Examples:
-- ALUMINUM  -  A%   (matches any title starting with 'A')
--           -  'A %' (matches any title starting with 'A ')

-- BEE       - B__   (matches any title starting with 'B' and exactly two more characters)
--            ___    (matches any title with exactly three characters)

-- Selects TITLEs where the title starts with 'AND ', contains ' AND ', or ends with ' AND'
SELECT TITLE FROM BOOK WHERE
  TITLE LIKE 'AND %'
  OR TITLE LIKE '% AND %'     
  OR TITLE LIKE '% AND';

-- Example TITLE: REPRIMAND (matches '% AND')

-- Selects all columns for books published by 'TA', with PRICE > 20, and is a paperback ('Y')
SELECT * FROM BOOK WHERE PUBLISHER_CODE = 'TA'
AND PRICE > 20 AND PAPERBACK = 'Y';
