/*
Name: Filipe da Cunha de Freitas
Student ID: 155737190
User ID: dbs211_203c09
Purpose: DBS211NCC - Lab06
*/

-------------------------------------------------------------------------------------------------------------------------

--1.	List the 4 ways that we know that a transaction can be started
-- >> User has established a new connection to the server
-- >> BEGIN statement in Oracle SQL
-- >> COMMIT statement
-- >> Any DDL statement, that automatucally triggers an auto-commit of the current transaction and starts a new one

-------------------------------------------------------------------------------------------------------------------------

--2.	Using SQL, create an empty table, that is the same as the employees table, and name it newEmployees
CREATE TABLE newEmployees AS SELECT* FROM employees;

-------------------------------------------------------------------------------------------------------------------------

--3 Execute the following commands: SET AUTCOMMIT OFF; SET TRANSACTION READ WRITE;
SET AUTCOMMIT OFF;
SET TRANSACTION READ WRITE;

-------------------------------------------------------------------------------------------------------------------------

--4.	Write an INSERT statement to populate the newEmployees table with the rows of the sample data. 
--      Insert the NULL value for the reportsTo column. (Write a single INSERT statement to insert all the rows)
INSERT ALL
    INTO newEmployees  VALUES (100, 'Patel', 'Ralph', '22333', 'rpatel@mail.com', '1', NULL, 'Sales Rep')
    INTO newEmployees  VALUES (101, 'Denis', 'Betty', '33444', 'bdenis@mail.com', '4', NULL, 'Sales Rep')
    INTO newEmployees  VALUES (102, 'Biri', 'Ben', '44555', 'bbirir@mail.com', '2', NULL, 'Sales Rep')
    INTO newEmployees  VALUES (103, 'Newman', 'Chad', '66777', 'cnewman@mail.com', '3', NULL,  'Sales Rep')
    INTO newEmployees  VALUES (104, 'Ropeburn', 'Audrey', '77888', 'aropebur@mail.com', '1', NULL,  'Sales Rep')
SELECT 1 FROM DUAL;

-------------------------------------------------------------------------------------------------------------------------

--5.	Create a query that shows all the inserted rows from the newEmployees table. How many rows are selected?
SELECT * FROM newEmployees;
-->> 28 rows

-------------------------------------------------------------------------------------------------------------------------

--6.	Execute the rollback command. Display all rows and columns from the newEmployees table. How many rows are selected?
ROLLBACK;
SELECT * FROM newEmployees;
-->> 23 rows

-------------------------------------------------------------------------------------------------------------------------

--7.	Repeat Task 4. Make the insertion permanent to the table newEmployees. Display all rows and columns from the newEmployee table. How many rows are selected?
COMMIT;
INSERT ALL
    INTO newEmployees  VALUES (100, 'Patel', 'Ralph', '22333', 'rpatel@mail.com', '1', NULL, 'Sales Rep')
    INTO newEmployees  VALUES (101, 'Denis', 'Betty', '33444', 'bdenis@mail.com', '4', NULL, 'Sales Rep')
    INTO newEmployees  VALUES (102, 'Biri', 'Ben', '44555', 'bbirir@mail.com', '2', NULL, 'Sales Rep')
    INTO newEmployees  VALUES (103, 'Newman', 'Chad', '66777', 'cnewman@mail.com', '3', NULL,  'Sales Rep')
    INTO newEmployees  VALUES (104, 'Ropeburn', 'Audrey', '77888', 'aropebur@mail.com', '1', NULL,  'Sales Rep')
SELECT 1 FROM DUAL;

SELECT * FROM newEmployees;
-->> 28 rows

-------------------------------------------------------------------------------------------------------------------------

--8.	Write an update statement to update the value of column jobTitle to ‘unknown’ for all the employees in the newEmployees table.
UPDATE newEmployees SET jobTitle = 'unknown';

-------------------------------------------------------------------------------------------------------------------------

--9.	Make your changes permanent.
COMMIT;

-------------------------------------------------------------------------------------------------------------------------

--10.	Execute the rollback command. 
--a.	Display all employees from the newEmployees table whose job title is ‘unknown’. How many rows are still updated?
ROLLBACK;
SELECT * FROM newEmployees;
WHERE LOWER(jobtitle) = 'unknown';
-->> 28 rows remained updated with job title equal to 'unknown'

--b.	Was the rollback command effective?
-->> Rollback command worked as expected. It was not effective to revert the job title update, because a commit statement was ran after the update. 

--c.	What was the difference between the result of the rollback execution from Task 6 and the result of the rollback execution of this task?
-->>  Rollback of task 6 was effective in reverting the update; rollback in task 10a was not effective. The difference was the commit statement ran after the update in task 10a.

--11.	Begin a new transaction and then create a statement to delete to employees from the newEmployees table
BEGIN
    DELETE FROM newEmployees;
END;

-------------------------------------------------------------------------------------------------------------------------

--12.	Create a VIEW, called vwNewEmps, that queries all the records in the newEmployees table sorted by last name and then by first name.
CREATE VIEW vwNewEmps AS
SELECT * FROM newEmployees
ORDER BY lastname, firstname;

-------------------------------------------------------------------------------------------------------------------------

--13.	Perform a rollback to undo the deletion of the employees
--a.	How many employees are now in the newEmployees table?
ROLLBACK;
SELECT * FROM newEmployees;
--b.	Was the rollback effective and why?
-->> The rollback was not effective to undo the deletion. It removed the view created in the task 12.

-------------------------------------------------------------------------------------------------------------------------

--14.	Begin a new transaction and rerun the data insertion from Task 4 (copy the code down to Task 14 and run it)
BEGIN
    INSERT ALL
        INTO newEmployees  VALUES (100, 'Patel', 'Ralph', '22333', 'rpatel@mail.com', '1', NULL, 'Sales Rep')
        INTO newEmployees  VALUES (101, 'Denis', 'Betty', '33444', 'bdenis@mail.com', '4', NULL, 'Sales Rep')
        INTO newEmployees  VALUES (102, 'Biri', 'Ben', '44555', 'bbirir@mail.com', '2', NULL, 'Sales Rep')
        INTO newEmployees  VALUES (103, 'Newman', 'Chad', '66777', 'cnewman@mail.com', '3', NULL,  'Sales Rep')
        INTO newEmployees  VALUES (104, 'Ropeburn', 'Audrey', '77888', 'aropebur@mail.com', '1', NULL,  'Sales Rep')
        SELECT 1 FROM DUAL; 
END;

-------------------------------------------------------------------------------------------------------------------------

--15.	Set a Savepoint, called insertion, after inserting the data
SAVEPOINT insertion;

-------------------------------------------------------------------------------------------------------------------------

--16.	Rerun the update statement from Task 8 and run a query to view the data (copy the code down and run it again)
UPDATE newEmployees SET jobtitle = 'unknown';
SELECT * FROM newEmployees;

-------------------------------------------------------------------------------------------------------------------------

--17.	Rollback the transaction to the Savepoint created in task 15 above and run a query to view the data. 
--      What does the data look like (i.e. describe what happened?
ROLLBACK TO insertion;
SELECT * FROM newEmployees;
-->> All the 5 records entered in the task 14 had the attritube jobtitle rollbacked to "Sales Rep". 

-------------------------------------------------------------------------------------------------------------------------

--18.	Use the basic for of the rollback statement and again view the data.  Describe what the results look like and what happened.
ROLLBACK;
SELECT * FROM newEmployees;
-->> this rollback one transaction before the rollback to insertion, meaning that it reverted the insert transaction from task 14; therefore, the at this poinst, the table is empty

-------------------------------------------------------------------------------------------------------------------------

--19.	Write a statement that denies all access to the newemployees table for all public users
REVOKE ALL ON newEmployees FROM public;

-------------------------------------------------------------------------------------------------------------------------

--20.	Write a statement that allows a classmate (use their database login) read only access to the newemployees table.
GRANT READ ON newEmployees TO dbs211_203c01;

-------------------------------------------------------------------------------------------------------------------------

--21.	Write a statement that allows the same classmate to modify (insert, update and delete) the data of the newemployees table.
GRANT INSERT, UPDATE, DELETE ON newEmployees TO dbs211_203c01;

-------------------------------------------------------------------------------------------------------------------------

--22.	Write a statement the denies all access to the newemployees table for the same classmate.
REVOKE ALL ON newEmployees FROM dbs211_203c01;


-------------------------------------------------------------------------------------------------------------------------
--23.	Write statements to permanently remove the view and table created for this lab
DROP VIEW vwNewEmps;
DROP TABLE newEmployees;