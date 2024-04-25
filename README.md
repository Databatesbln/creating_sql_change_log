# Implementing Audit Trails with SQL Triggers for Enhanced Data Management - Summary
By implementing triggers for INSERT, UPDATE, and DELETE operations, into a new log table, each change to the data is automatically logged with both its previous and new values, along with metadata such as the operation type, modification date, and user who made the change. This setup is incredibly useful in a variety of business scenarios, such as ensuring compliance with data governance standards, enhancing the auditability of sensitive data, facilitating accurate and timely debugging of data-related issues, and providing a historical record for security analysis and operational transparency.
I took the following employee dataset and loaded it to MSSQL https://www.kaggle.com/datasets/ravindrasinghrana/employeedataset

Use the "Triggers in SQL Excersice-Main.sql" for the full script. Please note that each trigger can only be created as a stand-alone script which are added to the repository as well. 


The final output will be a comprehensive log table that will look like: 

![image](https://github.com/Databatesbln/creating_sql_change_log/assets/73246189/b85e01e3-8ba9-4a53-9980-f16cc6f37e79)

All 3 types of changes were executed and captured as expected:

We see EmpID's old and new Last name as well the old and new Marital Status (MartialDesc) with the Operation "U" for Update. 

We see EmpID 4001 with no old values as this record was newly created, hence the Operation "I". 

And we see the deleted EmpID 1021 that has no new values asit was deleted Operation "D". 




