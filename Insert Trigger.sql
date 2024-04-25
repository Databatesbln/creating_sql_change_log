CREATE TRIGGER handle_EmployeeContactsInsert
ON EmployeeContacts
AFTER INSERT
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
        NULL, NULL, NULL, NULL,  -- No old values for inserts
        FirstName, LastName, ADEmail, MaritalDesc,
        GETDATE(),
        SYSTEM_USER,
        'I'
    FROM 
        inserted;
END;
