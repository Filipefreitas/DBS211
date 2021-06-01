--*1.	Create a query that shows employee number, first name, last name, city, phone number and postal code for all employees in France
--a.	Answer this question using an ANSI-89 Join
SELECT employees.employeeNumber, employees.firstName, employees.lastName, offices.city, offices.phone, offices.postalCode
FROM employees, offices
WHERE employees.officeCode = offices.officeCode AND offices.country = upper('FRANCE')

--b.	Answer this question using an ANSI-92 Join
SELECT employees.employeeNumber, employees.firstName, employees.lastName, offices.city, offices.phone, offices.postalCode
FROM employees INNER JOIN offices
ON employees.officeCode = offices.officeCode
WHERE offices.country = upper('FRANCE')

--2.	Create a query that displays all payments made by customers from Canada.
SELECT customers.customerNumber, customers.customerName, payments.paymentDate, payments.amount
FROM customers INNER JOIN payments
ON customers.country = UPPER('CANADA')
WHERE payments.paymentDate is NOT NULL
ORDER BY customers.customerNumber

--3.	Create a query that shows all USA customers who have not made a payment.  
--		Display only the customer number and customer name sorted by customer number.
SELECT customers.customerNumber, customers.customerName
FROM customers LEFT JOIN payments
ON customers.country = UPPER('USA')
WHERE payments.paymentDate is NULL
ORDER BY customers.customerNumber

--4.	a) Create a view (vwCustomerOrder) to list all orders with the following data for all customers:  
--		Customer Number, Order number, order date, product name, quantity ordered, and price for each product in every order. 
CREATE VIEW vwCustomerOrder AS 
(SELECT o.customerNumber,o.orderNumber, o.orderDate, products.productName, od.quantityOrdered, od.priceEach
FROM orders o, orderdetails od, products
WHERE o.orderNumber = od.orderNumber)

--5.	Using the vwCustomerOrder view, display the order information for customer number 124. 
--		Sort the output based on order number and then order line number. (Yes, I know orderLineNumber is not in the view)
SELECT *FROM vwcustomerorder v INNER JOIN orderdetails od
ON od.ordernumber = v.ordernumber
WHERE customernumber = 124
ORDER BY v.orderNumber, od.orderLineNumber;

--6.	Create a query that displays the customer number, first name, last name, phone, and credit limits for 
--		all customers who do not have any orders.
SELECT c.customerNumber, c.contactFirstName, c.contactLastName, c.phone, c.creditLimit
FROM customers c LEFT JOIN orders o
ON c.customerNumber = o.customerNumber
WHERE o.orderNumber is NULL

--7.	Create a view (vwEmployeeManager) to display all information of all employees 
--		and the name and the last name of their managers if there is any manager that the employee reports to.  
--		Include all employees, including those who do not report to anyone.
CREATE VIEW vwEmployeeManager AS
SELECT e.employeeNumber
	, e.lastName
	, e.firstName
	, e.extension
	, e.email
	, e.officeCode
	, e.reportsTo
	, e.jobTitle
	, e.username
	, m.lastName AS 'managerFirstName'
	, m.firstName AS 'managerLastName'
FROM employees e LEFT JOIN employees m
ON e.reportsTo = m.employeeNumber

--8.	Modify the employee_manager view so the view returns only employee information for employees who have a manager. 
--		Do not DROP and recreate the view – modify it. (Google is your friend). 
CREATE OR REPLACE VIEW vwEmployeeManager AS
SELECT e.employeeNumber
	, e.lastName
	, e.firstName
	, e.extension
	, e.email
	, e.officeCode
	, e.reportsTo
	, e.jobTitle
	, e.username
	, m.lastName AS 'managerFirstName'
	, m.firstName AS 'managerLastName'
FROM employees e INNER JOIN employees m
ON e.reportsTo = m.employeeNumber

--9.	Drop both customer_order and employee_manager views. 
DROP VIEW vwCustomerOrder, vwEmployeeManager