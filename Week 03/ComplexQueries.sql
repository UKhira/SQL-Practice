CREATE DATABASE complexQuery;

DROP TABLE IF EXISTS Device;
DROP TABLE IF EXISTS Emp;
DROP TABLE IF EXISTS Dept;

-- Creating Dept table
CREATE TABLE Dept
(
    deptNo INTEGER,
    dName VARCHAR(20) UNIQUE NOT NULL,
    dLoc VARCHAR(30) NOT NULL,
    createDate DATE,
    CONSTRAINT d_dno_pk PRIMARY KEY (deptNo)
);

-- Creating Emp table
CREATE TABLE Emp(
    empId INTEGER,
    fName VARCHAR(50) NOT NULL,
    lName VARCHAR(50) NOT NULL,
    position VARCHAR(50) NOT NULL,
    hireDate DATE NOT NULL,
    salary DECIMAL(7,2) NOT NULL,
    commPct DECIMAL(2,2),
    email VARCHAR(100) UNIQUE NOT NULL,
    deptNo INTEGER,
    mgrId INTEGER,
    CONSTRAINT e_eid_pk PRIMARY KEY (empId),
    CONSTRAINT e_dno_fk FOREIGN KEY (deptNo) 
    REFERENCES Dept(deptNo),
    CONSTRAINT e_mid_fk FOREIGN KEY (mgrId) 
    REFERENCES Emp(empId)
);

-- Creating Device table
CREATE TABLE Device
(
    deviceNo INTEGER,
    deviceMake VARCHAR(50) NOT NULL,
    deviceModel VARCHAR(50) NOT NULL,
    devicePurchDate DATE NOT NULL,
    devicePrice DECIMAL(7,2) NOT NULL,
    deviceFaults VARCHAR(200),
    empId INTEGER NOT NULL,
    CONSTRAINT d_dno_pk PRIMARY KEY (deviceNo),
    CONSTRAINT d_eid_fk FOREIGN KEY (empId) 
    REFERENCES Emp(empId)
);

-- Populating Dept tables
INSERT INTO Dept 
(deptNo, dName, dLoc, createDate)
VALUES
(10, 'Database Management', 'New Cav', '2021-03-21'),
(20, 'Systems Design', 'Harrow', '2021-01-06'),
(30, 'IT Development', 'New Cav', '2021-04-25'),
(40, 'Project Management', 'Regents', '2021-02-12'),
(50, 'Systems Testing', 'Marylebone', NULL);

-- Populating Emp tables
INSERT INTO Emp 
(empId, fName, lName, position, hireDate, salary, commPct, email, deptNo, mgrId)
VALUES
(101, 'Joe', 'Bloggs', 'Project Manager', '2021-03-01', 5200.00, 0.25, 'jb@it.com', 40, NULL),
(102, 'Jim', 'Marts', 'Database Admin', '2021-03-22', 4400.00, NULL, 'jm@it.com', 10, 101),
(103, 'Jen', 'Fonts', 'Python Developer', '2021-04-28', 4800.00, 0.12, 'jf@it.com', 30, 101),
(104, 'Jon', 'Pop', 'Database Architect', '2021-03-23', 4000.00, NULL, 'jp@it.com', 10, 102),
(105, 'Tom', 'Dogs', 'UI Designer', '2021-01-10', 4000.00, NULL, 'td@it.com', 20, 102),
(106, 'Tek', 'Roggs', 'Project Manager', '2021-01-01', 5200.00, 0.13, 'tr@it.com', 40, NULL),
(107, 'Tim', 'Clogs', 'Java Developer', '2021-04-29', 4300.00, 0.15, 'tc@it.com', NULL, 105),
(108, 'Tam', 'Kelps', 'UX Designer', '2021-06-15', 3900.00, NULL, 'tk@it.com', NULL, 106);

-- Populating Device tables
INSERT INTO Device
(deviceNo, deviceMake, deviceModel, devicePurchDate, devicePrice, deviceFaults, empId)
VALUES
(751, 'Pear Phone', 'P Phone 13', '2021-01-12', 976.00, NULL, 106),
(752, 'Pear Tablet', 'P Tablet 04', '2021-01-12', 854.00, NULL, 106),
(753, 'Space Laptop', 'S PC 11', '2021-01-13', 1231.00, 'Scratched', 106),
(754, 'Space Phone', 'S Phone 11', '2021-03-23', 887.00, NULL, 101),
(755, 'Pear Tablet', 'P Tablet 05', '2021-03-23', 1045.00, NULL, 101),
(756, 'Pear Phone', 'P Phone 13', '2021-04-02', 976.00, NULL, 102),
(757, 'Pear Phone', 'P Phone 13', '2021-04-01', 976.00, NULL, 104),
(758, 'Pear Phone', 'P Phone 13', '2021-02-12', 976.00, 'Slow', 105),
(759, 'Space Laptop', 'S PC 54', '2021-02-13', 1143.00, NULL, 105),
(760, 'Space Tablet', 'S Tab 2312', '2021-02-15', 998.00, NULL, 105),
(761, 'Move Phone', 'M Phone 32', '2021-05-07', 1241.00, 'Crashes', 103),
(762, 'Move Laptop', 'M Laptop 3223', '2021-05-08', 1678.00, NULL, 103);

-- Group functions with numeric data

-- Use MIN, MAX, SUM, AVG.
SELECT MIN(salary), MAX(salary), SUM(salary), AVG(salary)
FROM Emp;

-- With rounding.
SELECT MIN(salary), MAX(salary), SUM(salary), ROUND(AVG(salary),2)
FROM Emp;


-- Group functions with numeric data (and additional condition)
/* Group functions MIN, MAX, SUM and AVG return one value.oThe attribute position cannot be retrieved as it 
contains multiple values */
SELECT MIN(salary), MAX(salary), SUM(salary), ROUND(AVG(salary),2)
FROM Emp
WHERE position LIKE '%Developer%';

-- Group functions with strings of characters

/* MIN retrieves the string that is positioned the earliest alphabetically.
MAX retrieves the string that is positioned the furthest alphabetically.
COUNT retrieves the number of strings in the column */
SELECT MIN(lName), MAX(lName), COUNT(lName)
FROM Emp;

-- Group functions with dates

/* MIN retrieves the earliest date.
MAX retrieves the furthest date.
COUNT retrieves the number of dates in the column. */
SELECT MIN(hireDate), MAX(hireDate), COUNT(hireDate)
FROM Emp;


-- COUNT group function – specify column or not

-- Without specifying a column: use *.
SELECT COUNT(*)
FROM Emp
WHERE deptNo = 10;

/* With a specific column:
Using the PK is a good idea as it is a unique identifier */
SELECT COUNT(empId)
FROM Emp
WHERE deptNo = 10;

-- COUNT group function – handling repeated values

-- It counts repeated values as separate values.
SELECT COUNT(deptNo)
FROM Emp;

-- Use DISTINCT to retrieve the total number of different values.
SELECT COUNT(DISTINCT deptNo)
FROM Emp;

-- Group functions and NULL values

-- Group functions ignore null values in column.
SELECT AVG(commPct)
FROM Emp;

/* The IFNULL function (in MySQL) replaces null values with 0s and force the group function to include null values in 
the aggregation. */
SELECT AVG(IFNULL(commPct,0))
FROM Emp;

/* Creating groups of data */
SELECT deptNo, MIN(salary), MAX(salary), AVG(salary), SUM(salary), COUNT(salary)
FROM Emp
GROUP BY deptNo;

-- GROUP BY clause – include grouped column or not

-- The grouped column can be in the SELECT list.
SELECT deptNo, AVG(salary), SUM(salary)
FROM Emp
GROUP BY deptNo;

-- The grouped column does not have to be in the SELECT list.
SELECT AVG(salary), SUM(salary)
FROM Emp 
GROUP BY deptNo;

-- GROUP BY clause – with multiple columns
SELECT deptNo, position, AVG(salary)
FROM Emp
GROUP BY deptNo, position;

-- Restricting group results

-- HAVING clause
SELECT deptNo, AVG(salary)
FROM Emp
GROUP BY deptNo
HAVING AVG(salary) > 4500;

-- HAVING clause and WHERE clause
SELECT deptNo, SUM(salary) AS "Dept Payroll" 
FROM Emp
WHERE deptNo IS NOT NULL
GROUP BY deptNo
HAVING SUM(salary) > 4500
ORDER BY SUM(salary); 

-- Using subqueries
SELECT lName, fName, salary
FROM Emp
WHERE salary >
    (SELECT salary
    FROM Emp
    WHERE lName = 'Pop');

-- Single-row subqueries
SELECT lName, fName,deptNo
FROM Emp
WHERE deptNo <> 
    (SELECT deptNo
    FROM Emp
    WHERE empId = 103);

-- Single-row subqueries 
SELECT lName,fName, position,mgrId
FROM Emp
WHERE position = 
    (SELECT position
    FROM Emp
    WHERE empId = 104)
AND mgrId = 
    (SELECT mgrId
    FROM Emp
    WHERE empId = 108);

