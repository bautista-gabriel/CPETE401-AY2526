CREATE TABLE STUDENTS (
    LNAME VARCHAR(100), 
    FNAME VARCHAR(100)
    );


CREATE TABLE authors(
  ID INT(10),
  FNAME VARCHAR(100),
  LNAME VARCHAR(100),
  BIO TEXT,
  DATE_OF_BIRTH DATE
  );

CREATE TABLE publishers(
  ID INT(10),
  Publisher_Name VARCHAR(100),
  Country VARCHAR(100)
  );

CREATE TABLE books(
  BOOK_ID INT(20),
  TITLE VARCHAR(100),
  ISBN INT,
  Publication_Date DATE,
  Price DECIMAL (10,2)
  );

CREATE TABLE book_authors(
  
  )

CREATE TABLE patients(
  Patient_ID INT (15),
  FNAME VARCHAR(100),
  LNAME VARCHAR(100),
  DATE_OF_BIRTH DATE,
  RECORD_DATE DATE,
  PHONE_NUMBER INT (11)
  );

CREATE TABLE doctors(
  Doctor_ID INT (15),
  FNAME VARCHAR (100),
  LNAME VARCHAR (100),
  Medical_Specialty VARCHAR(100),
  Licensed_Year DATE
  );

CREATE TABLE appointments(
  appointment_ID INT (15),
  appointment_date_and_time DATETIME,
  reason_for_visit TEXT,
  appointment_status ENUM('Scheduled', 'Completed', 'Canceled', 'No-Show' )
  );

CREATE TABLE departments(
  department_ID INT(15),
  department_name VARCHAR(100),
  department_location VARCHAR(100)
  );

CREATE TABLE courses(
  course_ID INT(15),
  courses_code VARCHAR(10),
  course_title VARCHAR(50),
  credits INT(1)
  );
