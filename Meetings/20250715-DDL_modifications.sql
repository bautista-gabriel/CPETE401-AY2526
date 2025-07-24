-- Drop the STUDENTS table if it exists
DROP TABLE IF EXISTS STUDENTS;

-- Create the STUDENTS table with last name and first name columns
CREATE TABLE STUDENTS (
  LNAME VARCHAR(100),   -- Last name
  FNAME VARCHAR(100)    -- First name
);

-- Add middle name column to STUDENTS
ALTER TABLE STUDENTS ADD MNAME VARCHAR(100);

-- Add student number column as the first column
ALTER TABLE STUDENTS ADD STUDENT_NO VARCHAR(100) FIRST;

-- Add address column after student number
ALTER TABLE STUDENTS ADD ADDRESS VARCHAR(100) AFTER STUDENT_NO;

-- Example of multiple ALTER TABLE operations (some lines are invalid SQL)
ALTER TABLE STUDENTS 
  ADD MNAME VARCHAR(100),                -- Add middle name
  ADD STUDENT_NO VARCHAR(100) FIRST,     -- Add student number as first column
  ADD ADDRESS VARCHAR(100) AFTER STUDENT_NO, -- Add address after student number
  MODIFY LKSAJDF;LASKJDF,                -- Invalid: example placeholder
  CHANGE AKSJDFLASKJFL,                  -- Invalid: example placeholder
  DROP AL;SKDFJALS,                      -- Invalid: example placeholder

-- Change the data type of STUDENT_NO to VARCHAR(7)
ALTER TABLE STUDENTS MODIFY STUDENT_NO VARCHAR(7);

-- Move ADDRESS column to be the first column (syntax may vary by SQL dialect)
ALTER TABLE STUDENTS MODIFY ADDRESS VARCHAR(100) FIRST;

-- Rename MNAME column to MIDDLE_NAME
ALTER TABLE STUDENTS CHANGE MNAME MIDDLE_NAME VARCHAR(100);

-- Rename ADDRESS column to ADDR and place it after MIDDLE_NAME
ALTER TABLE STUDENTS CHANGE ADDRESS ADDR VARCHAR(100) AFTER MIDDLE_NAME;

-- Drop the ADDR column from STUDENTS
ALTER TABLE STUDENTS DROP ADDR;

-- Drop the PERSONS table if it exists
DROP TABLE IF EXISTS PERSONS;

-- Create the PERSONS table with name and contact number columns
CREATE TABLE PERSONS(
  NAME VARCHAR(100),      -- Name
  CONTACT_NO INT(12)      -- Contact number
);

-- Remove NAME column and add FNAME, MNAME, LNAME columns to PERSONS
ALTER TABLE PERSONS
  DROP NAME,              -- Drop NAME column
  ADD FNAME VARCHAR(100), -- Add first name
  ADD MNAME VARCHAR(100), -- Add middle name
  ADD LNAME VARCHAR(100); -- Add last name

-- Rename NAME to FNAME and add MNAME and LNAME columns
ALTER TABLE PERSONS
  CHANGE NAME FNAME VARCHAR(100), -- Rename NAME to FNAME
  ADD MNAME VARCHAR(100),         -- Add middle name
  ADD LNAME VARCHAR(100);         -- Add last name
