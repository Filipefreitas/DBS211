/*
SELECT e.employeenumber as "Employee ID"
    , e.firstname as "First Name"
    , e.firstname as "Last Name"
    , o.phone as "Phone"
    , e.extension as "Extension"
FROM employees e LEFT JOIN offices o
ON e.officecode = o.officecode
WHERE lower(o.city) = 'san francisco'
ORDER BY e.employeenumber
*/

SELECT e.employeenumber as "Employee ID"
    , e.firstname as "First Name"
    , e.firstname as "Last Name"
    , o.phone as "Phone"
    , e.extension as "Extension"
FROM employees e LEFT JOIN offices o
ON e.officecode = o.officecode
WHERE e.reportsto = 1056
ORDER BY e.employeenumber