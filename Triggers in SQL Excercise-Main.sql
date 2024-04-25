--Create a Subset (new table) of table employee_data for demo purposes
USE MyDatabase
SELECT EmpID, FirstName, LastName,ADEmail,MaritalDesc
INTO EmployeeContacts
FROM employee_data
----------------------------------
--Set EmpID as Primary Key

--Ensure there are no duplicates:
SELECT EmpID, COUNT(*)
FROM EmployeeContacts
GROUP BY EmpID
HAVING COUNT(*) > 1;

--Ensure there are no NULL Values
SELECT COUNT(*)
FROM EmployeeContacts
WHERE EmpID IS NULL;

--Make EmpID Not Nullable
ALTER TABLE EmployeeContacts
ALTER COLUMN EmpID INT NOT NULL;

--Make EmpID the primary key
ALTER TABLE EmployeeContacts
ADD CONSTRAINT PK_EmployeeContacts PRIMARY KEY (EmpID);

--Create Log Table Where Changes will be stored
CREATE TABLE EmployeeContacts_log (
    EmpID INT, -- the ID of the employee whose record was changed
    FirstName_old NVARCHAR(255),
    FirstName NVARCHAR(255),
    LastName_old NVARCHAR(255),
    LastName NVARCHAR(255),
    ADEmail_old NVARCHAR(255),
    ADEmail NVARCHAR(255),
    MaritalDesc_old NVARCHAR(255),
    MaritalDesc NVARCHAR(255),
    ModifiedDate DATETIME,
    ModifiedBy NVARCHAR(255),
    Operation CHAR(1) -- 'I' for Insert, 'U' for Update, 'D' for Delete
);

 ------------------------------------------------------ 
--Creating Triggers -These have to be done as Stand-Alone Scripts. Please see the separate files in the git repository

--Create Trigger for Updates (on EmployeeContacts)

--Create Trigger for Insert

--Create Trigger for Deletion
--------------------------------------------------------------
--TEST Update, we'll change the MartialDesc and Last Name of EmpID 1013
UPDATE EmployeeContacts
SET MaritalDesc = 'Married', LastName = 'Smith'
WHERE EmpID = 1013;

---TEST Insert, we'll insert a new record
INSERT INTO EmployeeContacts (EmpID, FirstName, LastName, ADEmail, MaritalDesc)
VALUES (4001, 'John', 'Doe', 'john.doe@example.com', 'Single');

--TEST Delete, we'll delete the record with the EmpID 1021
DELETE FROM EmployeeContacts
WHERE EmpID = 1021;

--Finally Test and See if all changes were captured as expected

SELECT * FROM EmployeeContacts_log






