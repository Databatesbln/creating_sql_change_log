CREATE TRIGGER handle_EmployeeContactsUpdate
ON EmployeeContacts
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;  -- Ensures that the trigger does not return the number of rows affected

    INSERT INTO EmployeeContacts_log (
        EmpID, 
        FirstName_old, LastName_old, ADEmail_old, MaritalDesc_old,
        FirstName, LastName, ADEmail, MaritalDesc,
        ModifiedDate, ModifiedBy, Operation
    )
    SELECT 
        i.EmpID,
        d.FirstName, d.LastName, d.ADEmail, d.MaritalDesc,
        i.FirstName, i.LastName, i.ADEmail, i.MaritalDesc,
        GETDATE(),
        SYSTEM_USER,
        'U'
    FROM 
        inserted AS i
    JOIN 
        deleted AS d ON i.EmpID = d.EmpID;
END;
