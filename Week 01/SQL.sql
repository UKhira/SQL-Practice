--Database Creation
CREATE DATABASE testCompany;

--Dept Table Creation
CREATE TABLE Dept
(
	deptno	INTEGER,
	dname	VARCHAR(20) UNIQUE NOT NULL,
	dloc	VARCHAR(30)NOT NULL,
	createDate	DATE,
	CONSTRAINT	d_dno_pk PRIMARY KEY (deptno)
);

--Emp Table Creation
CREATE TABLE emp
(
	empId	INTEGER,
	fname	VARCHAR(50)	NOT NULL,
	lname	VARCHAR(50)	NOT NULL,
	position	VARCHAR(50)	NOT NULL,
	hiredate	DATE	NOT NULL,
	salary	DECIMAL(7,2)	NOT NULL,
	commPct	DECIMAL(2,2),
	email	VARCHAR(100)	UNIQUE NOT NULL,
	deptno	INTEGER,
	CONSTRAINT	e_eid_pk PRIMARY KEY(empId),
	CONSTRAINT	e_dno_fk FOREIGN KEY(deptno) REFERENCES
Dept(deptno)
);

--Adding data to Dept Table	
INSERT INTO
Dept(deptno, dname, dloc, createDate)
VALUES
(10, 'Database Management', 'New Cav', '2021-03-21'),
(20, 'System Design', 'Harrow', '2021-01-06'),
(30, 'IT Development', 'New Cav', '2021-04-25'),
(40, 'Project Management', 'Regents', '2021-02-12'),
(50, 'Systems Testing', 'Marleybone', NULL);

--Adding data to Emp Table
INSERT INTO
Emp(empId, fname, lname, position, hiredate, salary, commPct, email, deptno)
VALUES
(101, 'Joe', 'Bloggs', 'Project Manager', '2021-03-01', 5200.00, 0.25, 'jb@it.com', 40),
(102, 'Jim', 'Marts', 'Database Admin', '2021-03-22', 4400.00, NULL, 'jm@it.com', 10),
(103, 'Jen', 'Fonts', 'Python Developer', '2021-04-28', 4800.00, 0.12, 'jf@it.com', 30),
(104, 'Jon', 'Pop', 'Database Architect', '2021-03-23', 4000.00, NULL, 'jp@it.com', 10),
(105, 'Tom', 'Dogs', 'UI Designer', '2021-01-10', 4000.00, NULL, 'td@it.com', 20),
(106, 'Tek', 'Roggs', 'Project Manager', '2021-01-01', 5200.00, 0.13, 'tr@it.com', 40),
(107, 'Tim', 'Clogs', 'Java Developer', '2021-04-29', 4300.00, 0.15, 'tc@it.com', NULL),
(108, 'Tam', 'Kelps', 'UX Designer', '2021-01-15', 3900.00, NULL, 'tk@it.com', NULL);



-- Queries

-- Select All Columns
SELECT * FROM Dept;

-- Select Specific Columns
SELECT dloc, dname FROM Dept;


-- Arithmatic Expressions

-- Without brackets: * takes precedence over +
SELECT lname, salary, salary + 300 FROM Emp;

-- With brackets: override * precedence and make + take precedence
SELECT lname, salary, 12 * salary + 200 FROM Emp;

SELECT lname, salary, 12 * (salary + 200) FROM Emp;


-- Null values

-- A null value is an unavailable, unassigned, unknown or inapplicable value.oA null value is not the same as zero or a blank value.
SELECT lname, salary, commPct FROM Emp;

-- An arithmetic expression containing a null value will return a null value.
SELECT lname, salary,12 * salary * commPct FROM Emp; 


--  Column Aliases

-- A column alias renames a column heading.oIt follows the AS keyword and uses " " to display the exact same label.

--  This Query will replace existing column names to names in " "
SELECT 
lname AS "Surname", 
salary AS "Monthly Salary", 
commPct AS "Commission"
FROM Emp;

-- It is useful as part of calculations
SELECT 
lname AS "Surname",
12 * salary AS "Yearly Salary",
12 * (salary + salary * commPct) AS "Final Intake"
FROM Emp;


--  Concatanation

-- Concatenate columns: use CONCAT function.
SELECT CONCAT (fname, lname) As "Full Name"
FROM Emp;

-- Concatenate and introduce a blank space.
SELECT CONCAT (fname, ' ', lname) AS "Full Name"
FROM Emp;

-- Concatenate and introduce a string.
SELECT CONCAT (fname, ' ', lname, ' is a ', position) AS "Full Name and Job"
FROM Emp; 


-- Remove Duplicate Rows
SELECT DISTINCT deptNo FROM Emp;


--	Restricting rows with WHERE clause

-- No quotes required in WHERE clause with numbers
SELECT empId, lname, position, hiredate, deptno
FROM Emp
WHERE deptno = 10;

-- Quotes required in WHERE clause with strings.
SELECT empId, lname, position, hiredate, deptno
FROM Emp
WHERE position = "Database Architect";

-- Quotes required in WHERE clause with dates.
SELECT empId, lname, position, hiredate, deptno
FROM Emp
WHERE hiredate = '2021-03-01';


-- Comparing One or Two Values with BETWEEN ... AND

-- Comparison operator in WHERE clause.
SELECT empId, lname, position, salary, deptNo
FROM Emp
WHERE salary >= 4500;

-- BETWEEN ... AND operator (by default boundaries values are included!).
SELECT empId, lname, position, salary, deptNo
FROM Emp
WHERE salary BETWEEN 4000 AND 4800;

-- Two comparison operators with the AND logical operator.
SELECT empId, lname, position, salary, deptNo
FROM Emp
WHERE salary > 4000 AND salary < 4800;


-- Comparing a list of values with IN

-- Using IN operator to see if a value match any of the values in a list.
SELECT empId, lname, position, hiredate, deptno
FROM Emp
WHERE deptNo IN (10, 30, 40);

-- Three = comparison operators with OR logical operator to do the same.
SELECT empId, lname, position, hiredate, deptNo
FROM Emp
WHERE deptNo = 10 OR deptNo = 30 OR deptNo = 40;

-- Combining NOT and IN operator to get the opposite
SELECT empId, lname,position, hiredate, deptNo
FROM Emp
WHERE deptNo NOT IN (10, 30, 40);


-- Matching character patterns with LIKE

-- Finding words starts with specific letter
SELECT empId, lname, position, hiredate, deptNo
FROM Emp
WHERE lname LIKE 'M%';

-- Finding words that contain a specific letter anywhere
SELECT empId, lname, position, hiredate, deptNo
FROM Emp
WHERE lname LIKE'%o%';

-- Finding words that contain a specific letter in a specific position

-- This query will output all "_o_ _..." Words (Doggs, Bog,...)
SELECT empId, lname, position, hiredate, deptNo
FROM Emp
WHERE lname LIKE '_o%';


-- Finding NULL values with IS NULL

-- Retrieving records for which one attribute has no values.
SELECT deptNo, dname, dloc, createDate
FROM Dept
WHERE createDate IS NULL;

-- Retrieving records for which one attribute has values.
SELECT empId, lname, position, commPct, deptNo
FROM Emp
WHERE commPct IS NOT NULL;

-- Retrieving children records with no values in their FKs.
SELECT empId, lname, position, salary, deptNo
FROM Emp
WHERE deptNo IS NULL;



-- Using Logical Operators

-- AND Operator
SELECT empId, lname, position, salary, deptNo 
FROM Emp
WHERE position LIKE '%Database%' AND salary > 4300;

-- OR Operator
SELECT empId, lname, position, salary, deptNo
FROM Emp
WHERE position LIKE '%Database' OR salary > 4300;

-- AND and NOT Operators
SELECT empId, lname, position, salary, deptNo
FROM Emp
WHERE deptNo NOT IN (10, 30) AND salary > 4300;


-- Precedence

-- Without brackets: AND takes precedence over OR.
SELECT empId, lname, position, salary, deptNo
FROM Emp
WHERE position LIKE '%Database%'
OR position LIKE '%Developer%'
AND salary > 4400;

-- With brackets: override AND precedence and make OR take precedence.
SELECT empId, lname, position, salary, deptNo
FROM Emp
WHERE (position LIKE '%Database%'
OR position LIKE '%Developer')
AND salary > 4400;


-- Sort DATA with ORDER BY

-- Sorting in ascending order: the use ASC keyword is optional.
SELECT empId, lname, hiredate, salary
FROM Emp
ORDER BY hiredate;

-- Sorting in descending order and using an alias.
SELECT empId, lname, hiredate, salary * 12 AS AnnSal
FROM Emp
ORDER BY AnnSal DESC;

-- Sorting by multiple columns
SELECT empId, lname, hiredate, salary, deptNo
FROM Emp
ORDER BY deptNo, salary DESC;