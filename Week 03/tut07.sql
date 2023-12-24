CREATE DATABASE Megafirm_02; 

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

/* Tutorial 06 Question 01

a) Write a query that displays the average salary for all employees with IDs 1022, 
1023, 1024 and 1025. Label columnas “Average Salary” */
SELECT AVG(salary) 
FROM employees
WHERE employee_id IN (1022, 1023, 1024, 1025);

/* b) Modify the previous query to include these staff who may not have a salary in your average calculation. 
Treat the absence of salary like a 0 value */
SELECT AVG(IFNULL(salary,0))
FROM employees
WHERE employee_id IN (1022, 1023, 1024, 1025);

/* Tutorial 06 Question 02
Write a query that displays the lowest, highest and average salary for the staff who have a job id that is either 907,908, or 909 
and who were hired in 2017. Label the columns “Minimum”, “Maximum” and “Average*/
SELECT MIN(salary) AS Minimum, MAX(salary) AS Maximum, ROUND(AVG(salary),2) AS Average
FROM employees
WHERE job_id IN (907, 908, 909) AND hire_date LIKE '2017%';

/* Tutorial 06 Question 03
Write a query that displays the manager number and, FOR EACH manager, the salary of the lowest-paid employee they manage. 
Exclude anyone whose manager is not known. Exclude any groups where the minimum salary is 47000 or less*/
SELECT manager_id, MIN(salary)
FROM employees
GROUP BY manager_id
HAVING manager_id IS NOT NULL AND  MIN(salary) > 47000;

/* Tutorial 06 Question 04
Write a query that displays department IDs and FOR EACH department, the lowest, highest and average salary but only for these 
departments for which both the maximum and the average salary is greater than 50000. Label the columns “Dept Id”, “Minimum”, 
“Maximum” and “Average”. Also exclude staff not allocated to work in a department. */
SELECT department_id AS 'Dept Id', MIN(salary) AS Minimum,  MAX(salary) AS Maximum, ROUND(AVG(salary),2) AS Average
FROM employees
GROUP BY department_id
HAVING (Maximum > 50000 AND Average > 50000) AND department_id IS NOT NULL;

/* Tutorial 06 Question 05
Write a query that displays a list of department IDs and department names and FOR EACH department the 
average salary in that department. Also include the details of those departments who do not have any employees */
SELECT E.department_id, D.department_name, ROUND(AVG(E.salary),2)
FROM departments D RIGHT JOIN employees E
ON D.department_id = E.department_id
GROUP BY E.department_id;

/* Tutorial 06 Question 06
Write a query that displays a list of job ids and job titles with the number of staff (i.e. a count of the numbers of employees) 
FOR EACH job. Label the columns “Job Id”, “Job Title” and “Staff Count”. Only include the job titles that are not related to 
management. In the end, only include the jobs that have at least 2 employees for each job and order the output in alphabetic order 
of job titles */
SELECT J.job_id AS 'Job Id', J.job_title AS 'Job Title', COUNT(E.employee_id) AS 'Staff Count'
FROM jobs J JOIN employees E 
ON J.job_id = E.job_id
GROUP BY J.job_id
HAVING J.job_title NOT LIKE "%Manag%"
AND COUNT(J.job_id) >= 2
ORDER BY job_title;

/* TUTORIAL 07: SUBQUERIES

Tutorial 07 Question 01
Write a query that displays the department numbers, last names and hire dates of all the staff who works in the same department as 
Matos. Exclude Matos. Rank in ascending order of department number. (Hint: check the number of staff called Matos in your dataset) */
SELECT department_id, last_name, hire_date
FROM employees
WHERE department_id = ANY
	(SELECT department_id
	FROM employees
	WHERE last_name LIKE 'Matos')
HAVING last_name NOT LIKE 'Matos'
ORDER BY department_id;


/*Tutorial 07 Question 02

a) Write a query that displays the last names and salaries of all staff who earn strictly more than the highest salary in department 
40. (Hint: think of 2 different ways of writing this query) */
SELECT last_name, salary
FROM employees
WHERE salary >
	(SELECT MAX(salary)
	FROM employees
	WHERE department_id = 40);

SELECT E.last_name, E.salary
FROM employees E
JOIN 
	(SELECT MAX(salary) AS msal
	FROM employees
	WHERE department_id = 40) M
ON E.salary > M.msal;

/* b) Write a query that displays the last names and salaries of all staff who earn strictly more than the lowest salary in
department 10. (Hint: think of 2 different ways of writing this query) */
SELECT last_name, salary
FROM employees
WHERE salary >
	(SELECT MIN(salary)
	FROM employees
	WHERE department_id = 10);

SELECT E.last_name, E.salary
FROM employees e
JOIN 
	(SELECT MIN(salary) as minsal
	FROM employees
	WHERE department_id = 10) M
ON E.salary > M.minsal;

/* Tutorial 07 Question 03
Write a query that displays the last names, salary, hire dates and department numbers of all employees whose
department location ID is 100. (Hint: think of 2 different ways of writing this query, one using a join, the other 
one using a subquery).*/
SELECT E.last_name, E.salary, E.department_id 
FROM employees E JOIN departments D
ON E.department_id = D.department_id
WHERE D.location_id = 100;

SELECT last_name, salary,department_id
FROM employees
WHERE department_id = ANY
	(SELECT department_id
	FROM departments
	WHERE location_id = 100);

/*Tutorial 07 Question 04
Write a query that displays the last names and salaries of all staff who are managed by an employee whose first 
name start with the letter ‘J’. (Hint: think of 2 ways of writing this query, one using a join, the other one using 
a subquery)*/
SELECT E.last_name, E.salary
FROM employees E JOIN employees M
ON E.manager_id = M.employee_id
WHERE M.first_name LIKE 'J%';

SELECT last_name, salary
FROM employees
WHERE manager_id = 
	(SELECT employee_id
	FROM employees
	WHERE first_name LIKE 'J%');

/*Tutorial 07 Question 05
Write a query that displays the last names and salaries of all staff who work in the same department as someone 
who was hired from the 1st of January 2017 onwards, and, at the same time, who earn more than the average salary 
of those employees not allocated to a department.*/
SELECT last_name, salary
FROM employees
WHERE department_id IN
	(SELECT department_id
	FROM employees
	WHERE hire_date >= '2017-01-01')
OR salary > 
	(SELECT AVG(salary)
	FROM employees
	WHERE department_id IS NULL);

/*Tutorial 07 Question 06
Write a query that displays a list of department IDs and department names for those departments that do not have
any employees with a job code 904*/
SELECT department_id, department_name
FROM departments
WHERE department_id NOT IN
	(SELECT department_id 
	FROM employees
	WHERE job_id = 904
	AND department_id IS NOT NULL)