use DBS211
--SELECT COUNT(employeeNumber) FROM employees

SELECT count(officecode)
FROM offices
WHERE lower(CITY) = 'paris'

SELECT customerNumber, MIN(amount) as 'amount'
FROM payments
GROUP BY customerNumber
ORDER BY amount ASC

SELECT COUNT(*)
FROM products
WHERE upper(productName) like ('%S%') AND upper(productName) like ('%E%')

SELECT *
FROM orders
WHERE lower(status) = 'cancelled'