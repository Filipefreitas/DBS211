/*
Name: Filipe da Cunha de Freitas
Student ID: 155737190
User ID: dbs211_203c09
Purpose: DBS211NCC - Lab03
*/

SET AUTOCOMMIT ON;

--#1.   Display the data for all offices.
SELECT * FROM offices

--#2.   Display the employee number for all employees whose office code is 1.
SELECT * FROM employees
WHERE officecode = 1

--#3.   Display customer number, customer name, contact first name and contact last name, and phone for all customers in Paris. (hint: be wary of case sensitivity)
SELECT customernumber, customername, contactfirstname, contactlastname, phone
FROM customers
WHERE upper(city) = 'PARIS'

--4.	Repeat the previous Query with a couple small changes:
--a.	The contact’s first and last name should be in a single column in the format “lastname, firstname”.
SELECT customernumber
	, customername
	, CONCAT(contactFirstName, ' ', contactLastName) AS name
	, phone
FROM customers
WHERE upper(city) = 'PARIS'

--b.	Show customers who are in Canada
SELECT customernumber, customername, contactfirstname, contactlastname, phone
FROM customers
-WHERE upper(country) = 'CANADA'

--5.	Display customer number for customers who have payments.  Do not included any repeated values. (hints: how do you know a customer has made a payment? You will need to access only one table for this query)
SELECT customernumber
-FROM payments
-WHERE paymentDate is not null
GROUP BY customernumber

--6.	List customer numbers, check number, and amount for customers whose payment amount is not in the range of $30,000 to $65,000. Sort the output by top payments amount first.
SELECT customernumber, checknumber, amount
FROM payments
WHERE amount NOT BETWEEN 30000.00 AND 65000.00
ORDER BY amount DESC

--7.	Display the order information for all orders that are cancelled. 
SELECT *
FROM orders
WHERE status = 'Cancelled'

--8.	The company needs to know the percentage markup for each product sold.  Produce a query that outputs the ProductCode, ProductName, BuyPrice, MSRP in addition to
--a.	The difference between MSRP and BuyPrice (i.e. MSRP-BuyPrice) called markup
SELECT productCode
	, productName
	, buyPrice
	, MSRP
	, (MSRP - buyPrice) as markup
FROM products

--b.	The percentage markup (100 * calculated by difference / BuyPrice) called percmarkup rounded to 1 decimal place.
SELECT productCode
	, productName
	, buyPrice
	, MSRP
	, (MSRP - buyPrice) as markup
	, convert(decimal(10, 1), 100 * (MSRP - buyPrice)/buyPrice) as percmarkup
FROM products

--9.	Display the information of all products with string ‘co’ in their product name. (c and o can be lower or upper case).
SELECT *
FROM products
WHERE upper(productName) like '%CO%'

--10.	Display all customers whose contact first name starts with letter s (both lowercase and uppercase) and includes letter e (both lowercase and uppercase).
SELECT *
FROM customers
WHERE upper(contactFirstName) like ('S%') AND upper(contactFirstName) like ('%E%')

--11.	Create a statement that will insert yourself as an employee of the company.  
--a.	Use a unique employee number of your choice
--b.	Use your school email address
--c.	Your job title will be “Cashier”
--d.	Office code will be 4
--e.	You will report to employee 1088
INSERT INTO employees
VALUES
(1000,'Freitas', 'Filipe', 'x3427', 'fda-cunha-de-freitas@myseneca.ca', '4', 1088, 'Cashier')

--12.	Create a query that displays your, and only your, employee data
SELECT * 
FROM employees
WHERE employeeNumber = 1000

--13.	Create a statement to update your job title to “Head Cashier”
UPDATE employees
SET jobTitle = 'Head Cashier'
WHERE employeeNumber = 1000

--14.	Create a statement to insert another fictional employee into the database.  This employee will be a “Cashier” and will report to you.  Make up fake data for the other fields.
INSERT INTO employees
VALUES
(1001,'Silva', 'Bruno', 'x4679', 'bruno.silva@myseneca.ca', '4', 1000, 'Cashier')

--15.	Create a statement to Delete yourself from the database.  Did it work?  If not, why?
DELETE FROM employees
WHERE employeeNumber = 1000
/*
--It didn't work. As per the error message, there is a conflict with a constraint emp_rtEmp_fk. I assume I will have to delete tha fake employee first.
The DELETE statement conflicted with the SAME TABLE REFERENCE constraint "emp_rtEmp_fk". The conflict occurred in database "DBS211", table "dbo.employees", column 'reportsTo'.
*/

--16.	Create a statement to delete the fake employee from the database and then rerun the statement to delete yourself.  Did it work?
DELETE FROM employees
WHERE employeeNumber = 1001 
WHERE employeeNumber = 1000 
--Yes it worked.

--17.	Create a single statement that will insert both yourself and the fake employee at the same time.  This time the fake employee will report to 1088 as well.
INSERT INTO employees
VALUES
1000,'Freitas', 'Filipe', 'x3427', 'fda-cunha-de-freitas@myseneca.ca', '4', 1088, 'Head cashier')
, (1001,'Silva', 'Bruno', 'x4679', 'bruno.silva@myseneca.ca', '4', 1088, 'Cashier')

--18.	Create a single statement to delete both yourself and the fake employee.
DELETE FROM employees
WHERE employeeNumber = 1000 or employeeNumber = 1001 