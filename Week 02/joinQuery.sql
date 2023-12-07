CREATE DATABASE Company;

DROP TABLE IF EXISTS Device;
DROP TABLE IF EXISTS Dept;
DROP TABLE IF EXISTS Emp;

-- Creating Dept Table
CREATE TABLE Dept
(
    deptNo              INTEGER,
    dName               VARCHAR(20)     UNIQUE NOT NULL,
    dLoc                VARCHAR(30)     NOT NULL,
    createDate          DATE,
    CONSTRAINT d_dno_pk                 PRIMARY KEY (deptNo)
);

-- Creating Emp Table
CREATE TABLE Emp
(
    empId               INTEGER,
    fName               VARCHAR(50)     NOT NULL,
    lName               VARCHAR(50)     NOT NULL,
    position            VARCHAR(50)     NOT NULL,
    hireDate            DATE            NOT NULL,
    salary              DECIMAL(7,2),
    commPct             DECIMAL(2,2),
    email               VARCHAR(100)    UNIQUE NOT NULL,
    deptNo              INTEGER,
    mgrId               INTEGER,
    CONSTRAINT e_eid_pk                 PRIMARY KEY(empId),
    CONSTRAINT e_dno_fk                 FOREIGN KEY(deptNo) REFERENCES  Dept(deptNo),
    CONSTRAINT e_mid_fk                 FOREIGN KEY(mgrId) REFERENCES Emp(empId)
);

-- Creating Device Table
CREATE TABLE Device
(
    deviceNo                INTEGER,
    deviceMake              VARCHAR(50)  NOT NULL,
    deviceModel             VARCHAR(50)  NOT NULL,
    devicePurchaseDate      DATE         NOT NULL,
    devicePrice             DECIMAL(7,2) NOT NULL,
    deviceFaults            VARCHAR(200),
    empId                   INTEGER      NOT NULL,
    CONSTRAINT d_deno_pk                 PRIMARY KEY(deviceNo),
    CONSTRAINT d_eno_fk                  FOREIGN KEY(empId) REFERENCES Emp(empId)           
);

-- Populating Dept Table
INSERT INTO Dept
(deptNo, dName, dLoc, createDate)
VALUES
(10, 'Database Management', 'New Cav', '2023-03-21'),
(20, 'System Design', 'Harrow', '2021-01-06'),
(30, 'IT Development', 'New Cav', '2021-04-25'),
(40, 'Project Management', 'Regents', '2021-02-12'),
(50, 'System Testing', 'Marleybone', NULL);

-- Populating Emp Table
INSERT INTO Emp
(empId, fName, lName, position, hireDate, salary, commPct, email, deptNo, mgrId)
VALUES
(101, 'Joe', 'Bloggs', 'Projet Manager', '2021-03-01', 5200.00, 0.25, 'jb@it.com', 40, NULL),
(102, 'Jim', 'Marts', 'Database Admin', '2021-03-22', 4400.00, NULL, 'jm@it.com', 10, 101),
(103, 'Jen', 'Fonts', 'Python Developer', '2021-04-28', 4800.00, 0.12, 'jf@it.com', 30, 101),
(104, 'Jen', 'Pop', 'Database Architect', '2021-03-23', 4000.00, NULL, 'jp@it.com', 10, 102),
(105, 'Tom', 'Dogs', 'UI Designer', '2021-01-10', 4000.00, NULL, 'td@it.com', 20, 102),
(106, 'Tek', 'Roggs', 'Project Manager', '2021-01-01', 5200.00, 0.13, 'tr@it.com', 40, NULL),
(107, 'Tim', 'Clogs', 'Java Developer', '2021-04-29', 4300.00, 0.15, 'tc@it.com', NULL, 105),
(108, 'Tam', 'Kelps', 'UX Designer', '2021-06-15', 3900.00, NULL, 'tk@it.com', NULL, 106);

-- Populating Device Table
INSERT INTO Device
(deviceNo, deviceMake, deviceModel, devicePurchaseDate, devicePrice, deviceFaults, empId)
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

-- Join statement using ON clause (without prefixes)