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