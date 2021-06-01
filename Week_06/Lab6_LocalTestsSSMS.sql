USE DBS211

/*
BEGIN TRANSACTION criaessamerda;

CREATE TABLE [dbo].[testedocaralho](
	[employeeNumber] [int] NOT NULL,
	[lastName] [varchar](50) NOT NULL,
	[firstName] [varchar](50) NOT NULL,
	[extension] [varchar](10) NOT NULL,
	[email] [varchar](100) NOT NULL,
	[officeCode] [varchar](10) NOT NULL,
	[reportsTo] [int] NULL,
	[jobTitle] [varchar](50) NOT NULL,
	[username] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[employeeNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

COMMIT TRANSACTION criaessamerda
*/


--DELETE FROM testedocaralho  
--SELECT * FROM testedocaralho  

/* #11
BEGIN
    DELETE FROM testedocaralho;
END;
*/

/* #12
CREATE VIEW vwNewEmps AS
SELECT * FROM testedocaralho
*/

--#13
ROLLBACK;

/* #14-15
BEGIN TRANSACTION insertion
	INSERT INTO testedocaralho  
	VALUES 
	(100, 'Patel', 'Ralph', '22333', 'rpatel@mail.com', '1', NULL, 'Sales Rep')
	, (101, 'Denis', 'Betty', '33444', 'bdenis@mail.com', '4', NULL, 'Sales Rep')
	, (102, 'Biri', 'Ben', '44555', 'bbirir@mail.com', '2', NULL, 'Sales Rep')
	, (103, 'Newman', 'Chad', '66777', 'cnewman@mail.com', '3', NULL,  'Sales Rep')
	, (104, 'Ropeburn', 'Audrey', '77888', 'aropebur@mail.com', '1', NULL,  'Sales Rep')

	SAVE TRANSACTION insertion
*/

/* jobtitle = SalesRep
SELECT * FROM testedocaralho
*/

/* #16 - update. Jobtitle = unknown
UPDATE testedocaralho SET jobtitle = 'unknown';
SELECT * FROM testedocaralho
*/

/* #17 Jobtitle = SalesRep
--ROLLBACK TRANSACTION insertion;
SELECT * FROM testedocaralho
*/

/* #18 
--ROLLBACK;
--SELECT * FROM testedocaralho
*/
