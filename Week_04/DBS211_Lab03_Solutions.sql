/*
Name: Lydia Li
Purpose: DBS211 Lab 3 - SOLUTIONS
*/

-- Q1 Display the information of all offices. 
SELECT * FROM offices;

-- Q2 Display the employee number for all employees whose office code is 1.
SELECT employeeNumber
FROM employees
WHERE officecode = 1;
    
-- Q3 Display customer number, customer name, contact first name and contact last name, 
--    and phone for all customers in Paris.
SELECT customerNumber, customername, contactfirstname, contactlastname, phone
FROM customers
WHERE UPPER(city) = 'PARIS'  -- answer should use either upper or lower function
ORDER BY customerNumber;  -- ORDER BY is optional in this solution

-- Q4 Repeat Q3 with formated name and from Canada
SELECT  customerNumber, 
        customername, 
        contactlastname || ', ' || contactfirstname AS contact, 
        phone
FROM customers
WHERE UPPER(country) = 'CANADA'
ORDER BY customerNumber;

-- Q5 Display customer number for customers who have payments.
SELECT DISTINCT customerNumber 
FROM payments
ORDER BY customerNumber;  -- DISTINCT should be used to eliminate duplicate results
    
-- Q6 List customer numbers, check number, and amount for customers whose payment amount 
--    is not in the range of $30,000 to $65,000. Sort the output by top payments amount first.
SELECT customerNumber, checkNumber, amount
FROM payments
WHERE amount NOT BETWEEN 30000 AND 65000
ORDER BY amount DESC;
    
-- Q7 Display the order information for all orders that are cancelled. 
SELECT * FROM orders
WHERE UPPER(status) = 'CANCELLED';
    
-- Q8 Markup values
SELECT productcode, productname, buyprice, msrp,
    msrp - buyprice AS markup,
    round(100 *(msrp - buyprice) / buyprice,1) AS percmarkup
FROM products;

-- Q9 Display the information of all products with string 'co' in their product name. 
--    (c and o can be lower or upper case).
SELECT * FROM products
WHERE UPPER(productName) LIKE '%CO%';
    
-- Q10 Display all customers whose contact first name starts with letter s (both lowercase 
--    and uppercase) and includes letter e (both lowercase and uppercase).
SELECT *
	FROM customers
    WHERE UPPER(contactFirstName) LIKE 'S%E%';
    
-- Q11 Insert yourself
INSERT INTO employees VALUES
    (1800, 'Li', 'Lydia', 'x1234', 'clint.macdonald@senecacollege.ca', 4, 1088, 'Cashier');
    
-- Q12 display yourself
SELECT * FROM employees
WHERE employeenumber = 1800;
-- note: Only the PK should be used in the WHERE condition to identify the exact row

-- Q13 promotion to head chashier
UPDATE employees
SET jobtitle = 'Head Cashier'
WHERE employeenumber = 1800; -- must only use PK in WHERE condtion to identify the exact row
        -- check update was successful
        SELECT * FROM employees
        WHERE employeenumber = 1800;

-- Q14 insert another fictional employee
INSERT INTO employees VALUES
    (1801, 'Smeltzer', 'Kim', 'x4567', 'kim.smeltzer@email.com', 4, 1800, 'Cashier');

-- Q15 Delete yourself
DELETE FROM employees 
WHERE employeenumber = 1800;
-- did NOT work, referential integrity prevents the deletion.

-- Q16  delete fake employee
DELETE FROM employees
WHERE employeenumber = 1801;

DELETE FROM employees 
WHERE employeenumber = 1800;
-- it worked now

-- Q17 
INSERT ALL 
INTO employees VALUES (1800, 'Li', 'Lydia', 'x1234', 'clint.macdonald@senecacollege.ca', 4, 1088, 'Cashier')
INTO employees VALUES (1801, 'Smeltzer', 'Kim', 'x4567', 'kim.smeltzer@email.com', 4, 1800, 'Cashier')
SELECT * FROM dual;

-- Q18 
DELETE FROM employees
WHERE employeenumber = 1800 OR employeenumber = 1801;