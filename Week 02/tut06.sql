CREATE DATABASE Megafirm; 

DROP TABLE IF EXISTS departments;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS locations;
DROP TABLE IF EXISTS jobs;

-- Create locations Table
CREATE TABLE locations
(
    location_id     INTEGER,
    street_address  VARCHAR(50),
    postal_code     INTEGER,
    city            VARCHAR(10),
    state_province  VARCHAR(10),
    country         VARCHAR(10),
    CONSTRAINT l_locId PRIMARY KEY (location_id)
);

-- Populate the locations table
INSERT INTO 
locations (location_id, street_address, postal_code, city, state_province, country)
VALUES 
(100, '2 Nice Road', 'N2 7TH', 'London', 'Greater London', 'UK'),
(200, '23 Pretty Road', 'BS1 8FD', 'Bristol', 'Bristol County', 'UK'),
(300, '26 Great Street', 'BN1 4BF', 'Brigthon', 'Sussex', 'UK'),
(400, '143 Lovely Road', 'CB1 2NV', 'Cambridge', 'Cambridgeshire', 'UK');

-- Create the jobs table
CREATE TABLE jobs
(
	job_id  		INTEGER,
	job_title		VARCHAR(50) UNIQUE NOT NULL,
	min_salary		DECIMAL(8,2) NOT NULL,
	max_salary		DECIMAL(8,2) NOT NULL,
	CONSTRAINT 		j_jid_pk PRIMARY KEY (job_id)
);

-- Populate the jobs table
INSERT INTO 
jobs (job_id, job_title, min_salary, max_salary)
VALUES
(901, 'Managing Director', 75000, 125000),
(902, 'Programmer', 35000, 80000),
(903, 'Sales Rep', 25000, 45000),
(904, 'Project Manager', 45000, 95000),
(905, 'Marketing Manager', 37000, 68000),
(906, 'Marketing Producer', 34000, 70000),
(907, 'Operations Manager', 28000, 41000),
(908, 'Sales Administrator', 38000, 65000),
(909, 'Database Architect', 44000, 73000),
(910, 'Operations Officer', 32000, 61000),
(911, 'IT Tester', 38000, 55000),
(912, 'Finance Director', 72000, 115000);

-- Create the departments table
CREATE TABLE departments
(
	department_id 	INTEGER,
	department_name	VARCHAR(20) UNIQUE NOT NULL,
	location_id  	INTEGER NOT NULL,
	CONSTRAINT 		d_did_pk PRIMARY KEY (department_id),
	CONSTRAINT 		d_lid_fk FOREIGN KEY (location_id)
	REFERENCES 		locations(location_id)
);

-- Populate the departments table
INSERT INTO 
departments (department_id, department_name, location_id)
VALUES
(10, 'IT', 100),
(20, 'Operations', 200),
(30, 'Sales', 300),
(40, 'Marketing', 400),
(50, 'Management', 100),
(60, 'Security', 200);

-- Create the employees table
CREATE TABLE employees
(
	employee_id 	INTEGER,
	first_name 		VARCHAR(50) NOT NULL,
	last_name 		VARCHAR(50) NOT NULL,
	email 			VARCHAR(50) NOT NULL UNIQUE,
	phone_number 	VARCHAR(15) NOT NULL,
	hire_date 		DATE NOT NULL, 
	salary 			DECIMAL(8,2),
	commission_pct	DECIMAL(2,2),
	manager_id 		INTEGER,
	department_id 	INTEGER,
	job_id 			INTEGER,
	CONSTRAINT 		e_eid_pk PRIMARY KEY (employee_id),
	CONSTRAINT 		e_mid_fk FOREIGN KEY (manager_id)
	REFERENCES 		employees(employee_id),
	CONSTRAINT 		e_did_fk FOREIGN KEY (department_id)
	REFERENCES 		departments(department_id),
	CONSTRAINT 		e_jid_fk FOREIGN KEY (job_id)
	REFERENCES 		jobs(job_id)
);

-- Populate the employees table
INSERT INTO 
employees (employee_id, first_name, last_name, email, phone_number, hire_date, salary, 
			commission_pct, manager_id, department_id, job_id)
VALUES 
(1001, 'Jim', 'King', 'jk@firm.com', '02079111001', '2011-01-21', 98000, NULL, NULL, 50, 901),
(1002, 'Jane', 'Queen', 'jq@firm.com', '02079111002', '2012-02-05', 99000, NULL, NULL, 50, 901),
(1003, 'Jen', 'Probert', 'jp@firm.com', '02079111003', '2014-11-23', 79000, NULL, 1001, 10, 904),
(1004, 'Mike', 'Brent', 'mb@firm.com', '02079111004', '2013-10-06', 51000, NULL, 1003, 10, 902),
(1005, 'Nadia', 'Tamsa', 'nt@firm.com', '02079111005', '2013-10-08', 62000, NULL, 1003, 10, 902),
(1006, 'Mo', 'Ali', 'ma@firm.com', '02079111006', '2015-11-24', 41000, 0.15, 1002, 30, 903),
(1007, 'Dania', 'Kolova', 'dk@firm.com', '02079111007', '2016-05-15', 38000, 0.25, 1006, 30, 903),
(1008, 'Manu', 'Ogoda', 'mo@firm.com', '02079111008', '2017-08-12', 33000, 0.35, 1007, 30, 903),
(1009, 'Marc', 'Daniel', 'md@firm.com', '02079111009', '2014-01-02', 35000, 0.35, 1007, 30, NULL),
(1010, 'Louise', 'Matos', 'lm@firm.com', '0207911110', '2017-11-05', 53000, NULL, 1002, 40, 905),
(1011, 'Ram', 'Binghi', 'rb@firm.com', '0207911111', '2012-03-30', 35000, NULL, 1010, 40, 906),
(1012, 'Tim', 'Norm', 'tn@firm.com', '0207911112', '2018-03-31', 48000, NULL, 1010, 40, 906),
(1013, 'Alex', 'Smart', 'as@firm.com', '0207911113', '2012-03-30', 39000, NULL, 1001, NULL, 907),
(1014, 'Bruno', 'Silba', 'bs@firm.com', '0207911114', '2014-05-08', 37000, NULL, 1013, 20, 910),
(1015, 'Laurie', 'Kaldav', 'lk@firm.com', '0207911115', '2017-08-11', 34000, NULL, 1013, 20, 910),
(1016, 'Sophie', 'Lanou', 'sl@firm.com', '0207911116', '2017-08-19', 34000, 0.10, 1007, 30, 908),
(1017, 'Yann', 'Taylor', 'yt@firm.com', '0207911117', '2018-09-03', 44000, NULL, 1002, 10, 909),
(1018, 'Sam', 'Tring', 'st@firm.com', '0207911118', '2018-09-05', 47000, NULL, 1003, 10, 909),
(1019, 'Don', 'Matos', 'dm@firm.com', '0207911119', '2017-10-04', 49000, NULL, 1003, NULL, 909),
(1020, 'Dan', 'Ritch', 'dr@firm.com', '0207911120', '2019-01-14', 35000, NULL, 1013, 20, 910),
(1021, 'Jenna', 'Novski', 'jn@firm.com', '0207911121', '2019-02-13', 38000, NULL, 1005, 10, 911),
(1022, 'Malia', 'Mundi', 'mm@firm.com', '0207911122', '2019-07-15', 43000, NULL, 1005, 10, 911),
(1023, 'Kurt', 'Thorpe', 'kt@firm.com', '0207911123', '2020-04-21', 44000, NULL, 1018, 10, 911),
(1024, 'Nikolai', 'Mikonov', 'nm@firm.com', '0207911124', '2020-11-02', NULL, NULL, NULL, NULL, NULL),
(1025, 'Gino', 'Gondolini', 'gg@firm.com', '0207911125', '2020-11-02', NULL, NULL, NULL, NULL, NULL);


-- Tutorial 05 Question 01

/* Write a query that displays a list of department names alongside the cities and countries where 
these departments are located, for all departments in Cambridge. */   
SELECT D.department_name, L.city, L.country
FROM departments D JOIN locations L
ON D.location_id = L.location_id
WHERE L.city = 'Cambridge';

-- Tutorial 05 Question 02

/* Write a query that displays a list of department names alongside the full names and salaries of the employees 
who work in those departments, but only for the employees who earn more than 45K and for the departments whose 
name start with the letter M. To avoid the issue of the capitalisation of the letter M, use UPPER to convert from 
lower-case to upper-case */
SELECT  D.department_name, CONCAT(E.first_name, " ", E.last_name) AS full_name, E.Salary
FROM departments D JOIN employees E
ON D.department_id = E.department_id
WHERE E.salary > 45000.00 AND 
UPPER(D.department_name) LIKE ('M%');


-- Tutorial 05 Question 03

/* Write a query that displays a list of countries, cities, department names alongside the full names and salaries of 
the members of staff who work in those departments and cities. Do this for staff that were either 
hired after 2 March 2015 or who earn less than £46000. Order your output by country, city, and 
department name.*/
SELECT L.country, L.city, D.department_name, CONCAT(E.first_name," ", E.last_name) AS full_name, E.salary
FROM locations L JOIN departments D ON L.location_id =  D.location_id
JOIN employees E ON D.department_id = E.department_id
WHERE E.hire_date > '2015-03-02' OR E.salary < 46000.00
ORDER BY L.country, L.city, D.department_name;


-- Tutorial 05 Question 04

/* Write a query that displays a list of departments alongside the full names, hire dates and salaries of the 
employeeswho work in those departments but only for the employees whose surname starts with a P and those 
employees whose surname starts with a S */
SELECT D.department_name, CONCAT(E.first_name, " ", E.last_name) AS full_name, E.hire_date, E.salary
FROM departments D JOIN employees E 
ON D.department_id = E.department_id
WHERE E.last_name LIKE 'P%' OR E.last_name LIKE 'S%';


-- Tutorial 05 Question 05

/* Write a query that displays a list of IDs, first names and surnames of the employees who manage other employees
with the IDs, first names and surnames of the employees that they manage. Rename the headers of the columns related 
to the managers and the columns related to the employees to differentiate between them by using aliase */
SELECT M.employee_id AS Manager_idNo, M.first_name AS Manager_fname, M.last_name AS Manager_lname,
E.first_name AS Employee_fname, E.last_name AS Employee_lname
FROM employees E JOIN employees M 
ON E.manager_id = M.employee_id;


-- Tutorial 05 Question 06

/* Modify the previous query to output only one column displaying the details of the managers and their 
respective employees. For every employee, this column should display something like “Jenny Bloggs (ID: 1234) 
manages John Smith (ID: 5678)”. Give it an appropriate header like “Management Report” */
SELECT CONCAT(M.first_name, " ", M.last_name, " ( ID: ", M.employee_id, ")", " manages ", E.first_name, " ",
E.last_name, " (ID: ", E.employee_id, ")") AS Management_Report
FROM employees E JOIN employees M 
ON E.manager_id = M.employee_id;


-- Tutorial 05 Question 07

/* Write a query that displays a list of employee surnames, salaries and job roles for those employees who work 
in the IT department */
SELECT E.last_name, E.salary, J.job_title
FROM employees E JOIN jobs J ON E.job_id = J.job_id
JOIN departments D ON E.department_id = D.department_id
WHERE D.department_name = 'IT';


/* Tutorial 05 Question 08

Write a query that displays a list of employee surnames, first names, salaries, job roles with the names of 
the departments where they work and the cities and countries where these departments are located */
SELECT E.last_name, E.first_name, E.salary, J.job_title, D.department_name, L.city, L.country
FROM employees E JOIN jobs J ON E.job_id = J.job_id
JOIN departments D ON E.department_id = D.department_id
JOIN locations L ON D.location_id = L.location_id;


/* Tutorial 05 Question 09

Write a query that displays a list of employee surnames, salaries, job roles, hire dates and their department 
names and cities for those employees who work in London, who were hired before the 25th April 2019 and whose salary 
is not between 40,000 and 50,000 */
SELECT E.last_name, E.salary, J.job_title, E.hire_date, D.department_name, L.city
FROM employees E JOIN jobs J ON E.job_id = J.job_id
JOIN departments D ON E.department_id = D.department_id
JOIN locations L ON D.location_id = L.location_id
WHERE (L.city LIKE 'London') AND (E.hire_date < '2019-04-25') AND (E.salary NOT BETWEEN 40000.00 AND 50000.00);


/*Tutorial 05 Question 10

Write a query that displays a list of employee surnames, salaries, job roles and department names along with 
the surnames, salaries, job roles and department names of those staff who manage them.*/
SELECT E.last_name AS Employee_lname, E.salary AS Employee_salary, J.job_title AS Employee_Job, D.department_name AS Employee_dep,
M.last_name AS Manager_lname, M.salary AS Manager_salary, MJ.job_title AS Manager_job, MD.department_name AS Manager_dep
FROM employees E JOIN jobs J ON E.job_id = J.job_id
JOIN departments D ON E.department_id = D.department_id
JOIN employees M ON E.employee_id = M.manager_id
JOIN jobs MJ ON M.job_id = MJ.job_id
JOIN departments MD ON M.department_id = MD.department_id;



/* Tutorial 05 Question 11

Write a query that displays a list of departments alongside the full names, hire dates and salaries of the employees
who work in those departments. To this list add the names of the departments who do not have any employees. */
SELECT D.department_name, CONCAT(E.first_name," ", E.last_name)AS full_name, E.hire_date, E.salary
FROM departments D LEFT OUTER JOIN employees E
ON D.department_id = E.department_id;


/* Tutorial 05 Question 12

Write a query that displays a list of departments alongside the full names, hire dates and salaries of the 
employees who work in those departments. To this list add the names of the employees who do not work in a department. */
SELECT D.department_name, CONCAT(E.first_name, ' ', E.last_name) AS full_name, E.hire_date, E.salary
FROM departments D RIGHT OUTER JOIN employees E
ON E.department_id = D.department_id;


/* Tutorial 05 Question 13

Write a query that displays the surnames and salaries of employees who have jobs and their job titles. To this list, 
add the employees who do not have jobs and the jobs for which there are no employees who have these jobs */
SELECT E.last_name AS surname, E.salary, J.job_title
FROM employees E RIGHT OUTER JOIN jobs J
ON E.job_id = J.job_id
UNION
SELECT E.last_name AS surname, E.salary, J.job_title
FROM employees E LEFT OUTER JOIN jobs J
ON E.job_id = J.job_id;