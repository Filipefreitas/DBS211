/*
Name: Lydia  Li
Purpose: DBS211 Lab 5 - SOLUTIONS
*/
-- -----------------------------------------------------------------------------------------------------------------------
-- Q1
-- a)
SELECT employeeNumber, firstname, lastname, city, phone || ' x' || extension AS WorkPhone, postalcode
	FROM employees, offices
    WHERE employees.officeCode = offices.officeCode AND lower(country) = 'france';
-- b)
SELECT employeeNumber, firstname, lastname, city, phone || ' x' || extension AS WorkPhone, postalcode
	FROM employees JOIN offices ON employees.officeCode = offices.officeCode 
    WHERE upper(country) = 'FRANCE';

-- Q2
SELECT c.customernumber, customername, 
    to_char(paymentdate, 'mon dd, yyyy') as paydate,
    amount
FROM customers c JOIN payments p ON c.customernumber = p.customernumber
WHERE upper(country) = 'CANADA'
ORDER BY c.customernumber;

-- Q3
SELECT customernumber, customername, amount, country
FROM customers LEFT JOIN payments USING (customernumber)
WHERE upper(country) = 'USA' AND amount IS NULL
ORDER BY customernumber;

-- Q4 	Create a view (vwCustomer_Order) to list all orders with the following data for all customers:
		-- Customer Number, Order number, order date, product name, quantity ordered, and price for each product in every order
DROP VIEW vwCustomerOrder;  -- just in case i make a mistake, then I can drop it to recreate it.
-- a)
CREATE VIEW vwCustomerOrder AS
	SELECT CustomerNumber, o.orderNumber, orderDate, productName, quantityOrdered, priceEach
		FROM orders o JOIN orderdetails od ON o.ordernumber = od.ordernumber
			JOIN products USING (productCode)
            JOIN customers USING (customerNumber);
            
-- b) 	Write a statement to view the results of the view just created.        
SELECT * FROM vwCustomerOrder;

-- -----------------------------------------------------------------------------------------------------------------------
-- Q5 Using vwCustomerOrder (just created) display the information for customer number 124.  
--    Sort the output based on order number and then order line number.

SELECT DISTINCT customerNumber, orderLineNumber, v.orderNumber
	FROM vwCustomerOrder v INNER JOIN orderdetails od ON v.orderNumber = od.orderNumber 
	WHERE customerNumber = 124
    ORDER BY orderNumber, orderLineNumber;

-- -----------------------------------------------------------------------------------------------------------------------
-- Q6 Display customer number, first name, last name, phone, and credit limits for all customers who do not have any orders.
SELECT 	o.customerNumber,
		contactfirstname,
		contactLastName, 
        phone,
        creditlimit
	FROM customers c LEFT JOIN orders o ON c.customerNumber = o.customerNumber
    WHERE o.customerNumber IS NULL;

-- -----------------------------------------------------------------------------------------------------------------------
-- Q7 Create a view (vwEmployeeManager) to display all information of employees and the name and the last name of 
--    their managers if there is any manager that the employee reports to. 
CREATE VIEW vwEmployeeManager AS
	SELECT e.employeeNumber, 
        e.lastname, 
        e.firstname, 
        e.extension, 
        e.email, 
        e.officeCode, 
        e.reportsTo, 
        e.jobTitle,
		em.firstname AS managerFirst, 
        em.lastname AS managerLast
	FROM employees e INNER JOIN employees em ON e.reportsTo = em.employeeNumber;
    
SELECT * FROM vwEmployeeManager;

-- Q8 Modify the employee_manager view so the view returns employee information for ALL employees who have a manager or not. 
--    Do not DROP and recreate the view - modify it. (Google is your friend).
CREATE OR REPLACE VIEW vwEmployeeManager AS
	SELECT 	e.employeeNumber, e.lastname, e.firstname, e.extension, e.email, e.officeCode, e.reportsTo, e.jobTitle,
			em.firstname AS managerFirst, em.lastname AS managerLast
		FROM employees e LEFT JOIN employees em ON e.reportsTo = em.employeeNumber;
SELECT * FROM vwEmployeeManager;

-- -----------------------------------------------------------------------------------------------------------------------
-- Q9 	Drop both the 2 new views just created in the previous questions
DROP VIEW vwEmployeeManager;
DROP VIEW vwCustomerOrder
