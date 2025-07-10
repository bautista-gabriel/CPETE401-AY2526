-- Drops the STUDENTS table if it already exists to avoid errors when creating it again
DROP TABLE IF EXISTS STUDENTS;
-- Creates the STUDENTS table with two columns: LNAME and FNAME, both VARCHAR(100)
CREATE TABLE STUDENTS (
  LNAME VARCHAR(100),
  FNAME VARCHAR(100)
);


-- Inserts a single row into STUDENTS with FNAME='JUAN' and LNAME='CRUZ'
INSERT INTO STUDENTS
  (FNAME, LNAME)
VALUES
  ('JUAN','CRUZ');

-- Inserts multiple identical rows into STUDENTS
INSERT INTO STUDENTS
VALUES
  ('JUAN','CRUZ'),
  ('JUAN','CRUZ'),
  ('JUAN','CRUZ'),
  ('JUAN','CRUZ'),
  ('JUAN','CRUZ'),
  ('JUAN','CRUZ');


-- Inserts a row with only FNAME provided; LNAME will be NULL
INSERT INTO STUDENTS
(FNAME)
VALUES
('JUAN CRUZ');


-- Inserts a row using SET syntax, specifying values for each column
INSERT INTO 
  STUDENTS
SET
  LNAME = 'CRUZ',
  FNAME = 'JUAN';

-- Deletes all data from STUDENTS and resets AUTO_INCREMENT counters (if any)
TRUNCATE STUDENTS;

-- Deletes rows from STUDENTS where PRODUCT_ID > 5 (note: PRODUCT_ID does not exist in STUDENTS, this will error)
DELETE FROM STUDENTS WHERE PRODUCT_ID > 5;

-- Creates the PRODUCTS table with PRODUCT_ID as an auto-incrementing primary key and NAME as VARCHAR(100)
CREATE TABLE PRODUCTS 
(
  PRODUCT_ID INT PRIMARY KEY AUTO_INCREMENT,
  NAME VARCHAR(100)
)


-- Inserts six rows into PRODUCTS, all with NAME='CORNED BEEF'
INSERT INTO PRODUCTS 
  (NAME) VALUES ('CORNED BEEF'),
  ('CORNED BEEF'),
  ('CORNED BEEF'),
  ('CORNED BEEF'),
  ('CORNED BEEF'),
  ('CORNED BEEF');

-- Inserts a row into PRODUCTS with PRODUCT_ID=NULL (auto-incremented) and NAME='HOT CAKE'
INSERT INTO PRODUCTS
VALUES
(NULL,'HOT CAKE')

-- Inserts a row into PRODUCTS with only NAME specified; PRODUCT_ID auto-increments
INSERT INTO PRODUCTS
(NAME)
VALUES
('HOT CAKE')


-- Replaces or inserts a row into PRODUCTS with PRODUCT_ID=22 and NAME='ITEM X'
REPLACE INTO PRODUCTS
  VALUES
(22, 'ITEM X')






