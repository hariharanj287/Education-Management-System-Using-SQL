CREATE DATABASE project5; 
USE project5;

CREATE TABLE staff_details(s_id INT PRIMARY KEY,    -- PRIMARY KEY Constraint 
Name VARCHAR(30),
Gender ENUM ("Male","Female"),          -- ENUM
Qualification VARCHAR (30) NOT NULL,   -- NOT NULL Constraint
Staff_Role VARCHAR(40),
Salary BIGINT);

CREATE TABLE Department(dep_id INT PRIMARY KEY, dep_name VARCHAR(200),
dep_hod VARCHAR(200),s_id int ,
CONSTRAINT Fky_dep FOREIGN KEY (s_id) REFERENCES staff_details(s_id) ON DELETE CASCADE );   -- FOREIGN KEY CONSTRAINT


CREATE TABLE Student_Record(St_id INT PRIMARY KEY AUTO_INCREMENT,              -- AUTO_INCREMENT
student_name VARCHAR(40),
Email VARCHAR(50) UNIQUE,            -- UNIQUE CONSTRAINT
Age INT CHECK(Age >= 18),            -- CHECK CONSTRAINT
CUR_CGPA DECIMAL(4,2),
Country VARCHAR(45) DEFAULT "INDIA" ,  -- DEFAULT CONSTRAINT
dep_id INT,
CONSTRAINT FK_stu FOREIGN KEY (dep_id) REFERENCES Department(dep_id) ON DELETE CASCADE);

CREATE TABLE student_Hosteldata(h_id  INT PRIMARY KEY,
Room_no INT,
Block_name VARCHAR(20),
Warden_name VARCHAR(35),
student_DOJ DATE, 
St_id INT,
CONSTRAINT FK_hos FOREIGN KEY(St_id) REFERENCES Student_Record(St_id) ON DELETE SET NULL);

--  TABLE 1: staff_details TABLE
INSERT INTO staff_details (s_id, Name, Gender, Qualification, Staff_Role, Salary) VALUES
(1, 'ARUN S', 'Male', 'PhD', 'Assistant Professor', 30000),
(2, 'SHIVANI R', 'Female', 'ME', 'Professor', 60000),
(3, 'GOPINATH V', 'Male', 'M.Tech', 'Associate Professor', 42000),
(4, 'SANKARI S', 'Female', 'M.Tech', 'Senior Professor', 56000),
(5, 'RAMYA B', 'Female', 'phD', 'Assistant Professor', 35000),
(6, 'NAVEEN J', 'Male', 'ME', 'Professor', 47000),
(7, 'VIJAY J', 'Male', 'phD', 'Associate Professor', 58000);

-- TABLE 2: Department TABLE
INSERT INTO Department (dep_id,dep_name,dep_hod,s_id) VALUES(101,'ECE','SENTHIL R',1),
(102,'CSE','SHANTHI S',2),
(103,'EEE','SIVA J',3),
(104,'MECH','KANNAN G',4),
(105,'BIO MEDICAL','MALA V',2),
(106,'CSBS','SNEHA E',NULL),
(107,'AIDS','SURESH A',NULL);

-- TABLE 3: Student_Record
INSERT INTO Student_Record (student_name, Email, Age, CUR_CGPA, Country, dep_id) VALUES
('HARIHARAN J', 'hariharanj287@gmail.com', 20, 8.5, DEFAULT, 101),
('MARISELVAM V', 'shivammari@gmail.com', 22, 9.1, DEFAULT, 102),
('NISANTH N', 'nisanthnisa@gmail.com', 18, 7.8, DEFAULT, 103),
('LAKSHMI R', 'lakshmi22@gmail.com', 21, 8.2, DEFAULT, 104),
('MANIRAJ K', 'mrking@gmail.com', 20, 8.9, DEFAULT, 105),
('DIVYA T', 'divyaduraisamy@gmail.com', 19, 7.5, DEFAULT, 106),
('KATHIRVEL S', 'kathirvels@gmail.com', 18, 8.0, DEFAULT, 107);

-- TABLE 4: student_Hosteldata
INSERT INTO student_Hosteldata (h_id, Room_no, Block_name, Warden_name, student_DOJ, St_id) VALUES
(1, 450, 'A Block', 'SARAVANAN D', '2020-06-15', 1),
(2, 155, 'B Block', 'RAJAGOPAL B', '2021-07-08', 2),
(3, 213, 'C Block', 'Rajesh G', '2020-06-25', 3),
(4, 455, 'A Block', 'SUKUMAR V', '2020-06-01', 4),
(5, 170, 'B Block', 'Narayanan P', '2021-07-05', 5),
(6, 225, 'C Block', 'KUMAR N', '2020-06-10', 6),
(7, 455, 'A Block', 'PALANIVEL C', '2021-07-15', 7);

SELECT * FROM staff_details;
SELECT * FROM Department;
SELECT * FROM Student_Record;
SELECT * FROM student_Hosteldata;

-- JOINS
-- inner join

SELECT 
    sd.s_id,sd.Name,
    sd.Gender,sd.Qualification,
    sd.Salary,d.dep_id,
    d.dep_name,d.dep_hod FROM staff_details AS sd
INNER JOIN Department AS d
    ON sd.s_id = d.s_id
    ORDER BY s_id; 
    
    -- LEFT JOIN
    SELECT 
    sd.s_id,sd.Name,
    sd.Gender,sd.Qualification,
    sd.Salary,d.dep_id,
    d.dep_name,d.dep_hod FROM staff_details AS sd
LEFT JOIN Department AS d
    ON sd.s_id = d.s_id
    ORDER BY s_id; 
    
 -- RIGHT JOIN
 SELECT
    sd.s_id,sd.Name,
    sd.Gender,sd.Qualification,sd.Salary,
    d.dep_id,d.dep_name,
    d.dep_hod FROM staff_details AS sd
RIGHT JOIN Department AS d
    ON sd.s_id = d.s_id
    ORDER BY s_id; 
   
   -- AGGREGATE FUNCTIONS
    -- AGGREGATE FUNCTIONS
   
   
SELECT COUNT(*) AS Total_Departments FROM Department;

SELECT SUM(Salary) AS Total_Salary FROM staff_details;

SELECT AVG(Salary) AS Average_Salary FROM staff_details;

SELECT MAX(CUR_CGPA) AS Highest_CGPA FROM Student_Record;

SELECT MIN(CUR_CGPA) AS Lowest_CGPA FROM Student_Record;
 
 -- LIKE OPERATORS
 
 SELECT * FROM Department WHERE dep_name LIKE 'C%';
 SELECT * FROM Student_Record WHERE Email LIKE '%gmail.com';
 SELECT * FROM staff_details WHERE Name LIKE '%AN%';
 -- IN OPERATOR
SELECT * FROM student_Hosteldata WHERE Room_no IN (450, 155, 213);
-- BETWEEN Operator
SELECT * FROM student_Hosteldata WHERE student_DOJ BETWEEN '2020-06-01' AND '2021-07-01';
-- NOT BETWEEN
SELECT * FROM student_Hosteldata WHERE student_DOJ NOT BETWEEN '2020-06-01' AND '2021-07-01';
-- BETWEEN with IN
SELECT * FROM staff_details WHERE s_id IN 
(SELECT s_id FROM Department WHERE dep_id IN (101, 102, 103)) AND Salary BETWEEN 30000 AND 50000;

-- SUB QUERIES
-- SINGLE ROW SUB QUERY
SELECT Email FROM Student_Record 
WHERE CUR_CGPA = (SELECT MAX(CUR_CGPA) FROM Student_Record);

-- Multi Row Subquery
SELECT * FROM Student_Record 
WHERE dep_id IN (SELECT dep_id FROM Student_Record WHERE student_name = 'HARIHARAN J');

-- Multi column sub query
-- Find staff members who belong to 'CSE' or 'ECE' departments

SELECT 
    sr.student_name, 
    sr.Email, 
    (SELECT CONCAT(d.dep_name, ', ', d.dep_hod) 
     FROM Department d 
     WHERE d.dep_id = sr.dep_id) AS dep_info
FROM 
    Student_Record sr;
    
    -- Correlated Sub Query
    -- Find staff with salary higher than the average salary of their department
SELECT Name, Salary 
FROM staff_details sd
WHERE Salary > (SELECT AVG(Salary) 
                FROM staff_details 
                WHERE Qualification = sd.Qualification);
    
    -- Non Correlated Sub Query
    -- Find students with the highest CGPA
SELECT student_name, CUR_CGPA 
FROM Student_Record 
WHERE CUR_CGPA = (SELECT MAX(CUR_CGPA) FROM Student_Record);
    
    -- SCALAR Sub Query
    -- Find the average salary of all staff and show it alongside each staff's details
SELECT Name, Salary, (SELECT AVG(Salary) FROM staff_details) AS Avg_Salary
FROM staff_details;

-- Create a new user with a username and password
CREATE USER 'sqlhari'@'localhost' IDENTIFIED BY 'hari123.';
GRANT ALL PRIVILEGES ON project7.* TO 'sqlhari'@'localhost';
-- Revoke all privileges on the 'project7' database from 'new_user'
REVOKE ALL PRIVILEGES ON project7.* FROM 'sqlhari'@'localhost';
  












