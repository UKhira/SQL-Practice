CREATE DATABASE LOGICAL_ERD;

CREATE TABLE locations
(
    location_id         INTEGER NOT NULL,
    street_address      VARCHAR(50),
    postal_code         INTEGER,
    city                VARCHAR(10),
    state_province      VARCHAR(10),
    country             VARCHAR(10),
    CONSTRAINT loc_id_pk PRIMARY KEY (location_id)
);

CREATE TABLE jobs
(
    job_id              INTEGER,
    job_title           VARCHAR(20),
    min_salary          DECIMAL(10,2),
    max_salary          DECIMAL(10,2),
    CONSTRAINT job_id_pk PRIMARY KEY (job_id)
);

CREATE TABLE departments
(
    department_id       VARCHAR(10) UNIQUE NOT NULL,
    department_name     VARCHAR(20),
    location_id         INTEGER NOT NULL,
    CONSTRAINT dep_id_pk PRIMARY KEY (department_id),
    CONSTRAINT loc_id_fk FOREIGN KEY (location_id)
    REFERENCES locations(location_id)
);

CREATE TABLE employees 
(
    employee_id         VARCHAR(10) UNIQUE NOT NULL,
    first_name          VARCHAR(20),
    last_name           VARCHAR(20),
    email               VARCHAR(20),
    phone_number        VARCHAR(12),
    hire_date           DATE,
    salary              DECIMAL(10,2),
    commission_pct      DECIMAL(2,2),
    department_id       VARCHAR(10),
    job_id              INTEGER,
    manager_id          VARCHAR,
    CONSTRAINT dep_id_pk PRIMARY KEY (department_id),
    CONSTRAINT emp_id_pk PRIMARY KEY (employee_id),
    CONSTRAINT dep_id_fk FOREIGN KEY (department_id)
    REFERENCES departments(department_id),
    CONSTRAINT j_id_fk FOREIGN KEY (job_id)
    REFERENCES jobs(job_id),
    CONSTRAINT man_id_fk FOREIGN KEY (manager_id)
    REFERENCES employees(employee_id)
);