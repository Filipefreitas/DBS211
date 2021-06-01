SET AUTOCOMMIT ON;

--Question 1 - Table 1:
CREATE TABLE movies(
mid INT PRIMARY KEY 
, title VARCHAR(35) not null
, releaseYear INT not null
, director INT not null
, score DECIMAL(3,2)

, CONSTRAINT scoreRange CHECK (score between 0 and 5)); 

--Question 1 - Table 2:
CREATE TABLE actors(
Aid INT PRIMARY KEY
, firstName VARCHAR(20) not null
, lastName VARCHAR(30) not null);


--Question 1 - Table 3:
CREATE TABLE casting(
movieid INT 
, actorid INT 
, PRIMARY KEY (movieid, actorid)
, CONSTRAINT movieid_fk FOREIGN KEY (movieid) REFERENCES movies(mid)
, CONSTRAINT actorid_fk FOREIGN KEY (actorid) REFERENCES actors(aid));

--Question 1 - Table 4:
CREATE TABLE directors(
directorid INT PRIMARY KEY
, firstname VARCHAR(20) not null
, lastname VARCHAR(30) not null);

--Question 2:
ALTER TABLE movies
ADD CONSTRAINT director_fk FOREIGN KEY (director) REFERENCES directors(directorid)

--Question 3:
ALTER TABLE movies
ADD CONSTRAINT uniqueTitle
UNIQUE (title)

--Question 4 - Table directors:
INSERT INTO directors(directorid, firstname, lastname)
VALUES 
(1010, 'Rob', 'Minkoff')
, (1020, 'Bill', 'Condon')
, (1050, 'Josh', 'Cooley')
, (2010, 'Brad', 'Bird')
, (3020, 'Lake', 'Bell')

--Question 4 - Table movies:
INSERT INTO movies(mid, title, releaseYear, director, score)
VALUES
(100, 'The Lion King', 2019, 3020, 3.50)
, (200, 'Beauty and the Beast', 2017, 1050, 4.20)
, (300, 'Toy Story 4', 2019, 1020, 4.50)
, (400,	'Mission Impossible', 2018, 2010, 5.00)
, (500, 'The Secret Life of Pets', 2016, 1010, 3.90)

--Question 5 
DROP TABLE casting;
DROP TABLE movies;
DROP TABLE actors;
DROP TABLE directors;
--The order is revelant. In order to prevent conflicts with foreign keys, child tables have to be deleted first.  

--Question 6
CREATE TABLE employee2 AS
(SELECT * FROM employees);

--Question 7
ALTER TABLE employee2
ADD username varchar(20);

--Question 8
DELETE FROM employee2

--Question 9
INSERT INTO employee2 (employeeNumber, lastName, firstName, extension, email, officeCode, reportsTo, jobTitle) 
SELECT 
	employeeNumber
	, lastName
	, firstName
	, extension
	, email
	, officeCode
	, reportsTo
	, jobTitle
FROM employees

--Question 10
UPDATE employee2
SET [firstName] = 'Filipe' WHERE employeeNumber = 1002

UPDATE employee2
SET [lastName] = 'Freitas' WHERE employeeNumber = 1002

--Question 11
UPDATE employee2
SET [username] = LOWER(CONCAT(LEFT(firstName, 1), lastName))

--Question 12
DELETE FROM employee2
WHERE officeCode = 4

--Question 13
DROP TABLE employee2;