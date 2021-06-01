-- -------------------------
-- DBS211 - Lab 06 Solutions
-- -------------------------

-- Q1
/*
Transactions can be started in 4 ways
1) First connection to the database in each session
2) Running a SET TRANSACTION statement
3) Running a COMMIT statement
4) Running any DDL statement autocommits the existing transaction
*/

-- Q2
CREATE TABLE newEmployees AS
    SELECT * FROM employees WHERE rownum = -1;
    
-- Q3
SET AUTOCOMMIT OFF;
SET TRANSACTION READ WRITE;

-- Q4
INSERT ALL
INTO newEmployees VALUES (100, 'Patel', 'Ralph', 22333, 'rpatel@mail.com', 1, NULL, 'Sales Rep')
INTO newEmployees VALUES (101, 'Denis', 'Betty', 33444, 'bdenis@mail.com', 4, NULL, 'Sales Rep')
INTO newEmployees VALUES (102, 'Biri', 'Ben', 44555, 'bbirir@mail.com', 2, NULL, 'Sales Rep')
INTO newEmployees VALUES (103, 'Newman', 'Chad', 66777, 'cnewman@mail.com', 3, NULL, 'Sales Rep')
INTO newEmployees VALUES (104, 'Ropeburn', 'Audrey', 77888, 'aropebur@mail.com', 1, NULL,'Sales Rep')
SELECT * FROM dual;

-- Q5
SELECT * FROM newEmployees;
SELECT COUNT(*) FROM newEmployees; -- 5

-- Q6
ROLLBACK;
SELECT * FROM newEmployees;
SELECT COUNT(*) FROM newEmployees; -- 0

-- Q7 
INSERT ALL
INTO newEmployees VALUES (100, 'Patel', 'Ralph', 22333, 'rpatel@mail.com', 1, NULL, 'Sales Rep')
INTO newEmployees VALUES (101, 'Denis', 'Betty', 33444, 'bdenis@mail.com', 4, NULL, 'Sales Rep')
INTO newEmployees VALUES (102, 'Biri', 'Ben', 44555, 'bbirir@mail.com', 2, NULL, 'Sales Rep')
INTO newEmployees VALUES (103, 'Newman', 'Chad', 66777, 'cnewman@mail.com', 3, NULL, 'Sales Rep')
INTO newEmployees VALUES (104, 'Ropeburn', 'Audrey', 77888, 'aropebur@mail.com', 1, NULL,'Sales Rep')
SELECT * FROM dual;

COMMIT;
SELECT * FROM newEmployees;
SELECT COUNT(*) FROM newEmployees; -- 5

-- Q8
UPDATE newEmployees SET jobtitle = 'unknown';

-- Q9
COMMIT;

-- Q10
ROLLBACK;
-- a) 
SELECT * FROM newEmployees WHERE upper(jobtitle) = 'UNKNOWN';
SELECT COUNT(*) FROM newEmployees WHERE upper(jobtitle) = 'UNKNOWN'; -- 5

-- b) no

-- c) The commit statement started a new transaction and the 
--    rollback statement only roles back statements in the current transaction

-- Q11
SET TRANSACTION READ WRITE;
DELETE FROM newemployees;

-- Q12
CREATE VIEW vwNewEmps AS
    SELECT * FROM newEmployees
    ORDER BY lastname, firstname;

SELECT * FROM vwNewEmps;

-- Q13
ROLLBACK;
-- a)
SELECT * FROM newemployees -- 0
-- b) 
-- no, the DDL statement to create the view autocommited the transaction and started a new one.  
-- Therefore the rollback statement ran in a new transaction

-- Q14
SET TRANSACTION READ WRITE;
INSERT ALL
INTO newEmployees VALUES (100, 'Patel', 'Ralph', 22333, 'rpatel@mail.com', 1, NULL, 'Sales Rep')
INTO newEmployees VALUES (101, 'Denis', 'Betty', 33444, 'bdenis@mail.com', 4, NULL, 'Sales Rep')
INTO newEmployees VALUES (102, 'Biri', 'Ben', 44555, 'bbirir@mail.com', 2, NULL, 'Sales Rep')
INTO newEmployees VALUES (103, 'Newman', 'Chad', 66777, 'cnewman@mail.com', 3, NULL, 'Sales Rep')
INTO newEmployees VALUES (104, 'Ropeburn', 'Audrey', 77888, 'aropebur@mail.com', 1, NULL,'Sales Rep')
SELECT * FROM dual;

SELECT * FROM newemployees;

-- Q15
SAVEPOINT insertion;

-- Q16
UPDATE newEmployees SET jobtitle = 'unknown';
SELECT * FROM newemployees;

-- Q17 
ROLLBACK TO insertion;
SELECT * FROM newemployees;

-- Q18 
ROLLBACK;
SELECT * FROM newemployees;

-- Q19
REVOKE ALL ON newemployees FROM PUBLIC;

-- Q20 
GRANT READ ON newemployees TO dbs301_201e40;

-- Q21
GRANT INSERT, UPDATE, DELETE ON newemployees TO  dbs301_201e40;

-- Q22 
REVOKE ALL ON newemployees FROM dbs301_201e40;

-- Q23
DROP VIEW vwNewEmps;
DROP TABLE newEmployees;

-- END OF SOLUTIONS --
