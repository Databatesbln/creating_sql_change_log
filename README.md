# Implementing Audit Trails with SQL Triggers for Enhanced Data Management - Summary
By implementing triggers for INSERT, UPDATE, and DELETE operations, into a new log table, each change to the data is automatically logged with both its previous and new values, along with metadata such as the operation type, modification date, and user who made the change. This setup is incredibly useful in a variety of business scenarios, such as ensuring compliance with data governance standards, enhancing the auditability of sensitive data, facilitating accurate and timely debugging of data-related issues, and providing a historical record for security analysis and operational transparency.
I took the following employee dataset and loaded it to MSSQL https://www.kaggle.com/datasets/ravindrasinghrana/employeedataset


--------------------------------------------
-- First of all, create a Subset (new table) of table employee_data for demo purposes with only a few columns
USE MyDatabase
SELECT EmpID, FirstName, LastName,ADEmail,MaritalDesc
INTO EmployeeContacts
FROM employee_data

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
#  Creating the triggers. These triggers have to be created in a stand-alone script (one for each) and are attached to the repository. 

--Create Trigger for Updates 

--Create Trigger for Insert

--Create Trigger for Deletion

# Testing the triggers after creation - one for each scenario

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

# Finally Test and See if all changes were captured as expected

SELECT * FROM EmployeeContacts_log

![image](https://github.com/Databatesbln/creating_sql_change_log/assets/73246189/b85e01e3-8ba9-4a53-9980-f16cc6f37e79)

As you can see, all 3 types of changes were executed and captured as expected:
We see EmpID's old and new Last name as well the old and new Marital Status (MartialDesc) with the Operation "U" for Update. 

We see EmpID 4001 with no old values as this record was newly created, hence the Operation "I". 

And we see the deleted EmpID 1021 that has no new values asit was deleted Operation "D". 




