CREATE TRIGGER handle_EmployeeContactsDelete
ON EmployeeContacts
AFTER DELETE
AS
BEGIN
    SET NOCOUNT ON;  -- Avoids returning the number of rows affected

    INSERT INTO EmployeeContacts_log (
        EmpID, 
        FirstName_old, LastName_old, ADEmail_old, MaritalDesc_old,
        FirstName, LastName, ADEmail, MaritalDesc,
        ModifiedDate, ModifiedBy, Operation
    )
    SELECT 
        EmpID,
        FirstName, LastName, ADEmail, MaritalDesc,
        NULL, NULL, NULL, NULL,  -- No new values for deletes
        GETDATE(),
        SYSTEM_USER,
        'D'
    FROM 
        deleted;
END;
