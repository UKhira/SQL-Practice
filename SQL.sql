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

SELECT lname, salary, salary + 300 FROM Emp;

SELECT lname, salary, 12 * salary + 200 FROM Emp;

SELECT lname, salary, 12 * (salary + 200) FROM Emp;


-- Null values

SELECT lname, salary, commPct FROM Emp;

SELECT lname, salary,12 * salary * commPct FROM Emp; 


--  Column Aliases

--  This Query will replace existing column names to names in " "
SELECT 
lname AS "Surname", 
salary AS "Monthly Salary", 
commPct AS "Commission"
FROM Emp;

SELECT 
lname AS "Surname",
12 * salary AS "Yearly Salary",
12 * (salary + salary * commPct) AS "Final Intake"
FROM Emp;


--  Concatanation

SELECT CONCAT (fname,lname) As "Full Name"
FROM Emp;

SELECT CONCAT (fname, ' ', lname) AS "Full Name"
FROM Emp;

SELECT CONCAT (fname, ' ', lname, ' is a ', position) AS "Full Name and Job"
FROM Emp; 


-- Duplicate Rows
SELECT DISTINCT deptNo FROM Emp;


--	Restricting rows with WHERE clause
SELECT empId, lname, position, hiredate, deptno
FROM Emp
WHERE deptno = 10;

SELECT empId, lname, position, hiredate, deptno
FROM Emp
WHERE position = "Database Architect";

SELECT empId, lname, position, hiredate, deptno
FROM Emp
WHERE hiredate = '2021-03-01';


-- Comparing One or Two Values with BETWEEN ... AND
SELECT empId, lname, position, salary, deptNo
FROM Emp
WHERE salary >= 4500;

SELECT empId, lname, position, salary, deptNo
FROM Emp
WHERE salary BETWEEN 4000 AND 4800;

SELECT empId, lname, position, salary, deptNo
FROM Emp
WHERE salary > 4000 AND salary < 4800;


-- Comparing a list of values with IN
SELECT empId, lname, position, hiredate, deptno
FROM Emp
WHERE deptNo IN (10, 30, 40);

SELECT empId, lname, position, hiredate, deptNo
FROM Emp
WHERE deptNo = 10 OR deptNo = 30 OR deptNo = 40;