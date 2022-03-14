USE AdventureWorks2019
GO

--Exercise
-- Making use of temp tables and UPDATE statements, re-write an optimized version of the query in the "Optimizing With UPDATE - Exercise Starter Code.sql"
-- file, which you'll find in the resources for this section.
SELECT 
	   A.BusinessEntityID
      ,A.Title
      ,A.FirstName
      ,A.MiddleName
      ,A.LastName
	  ,B.PhoneNumber
	  ,PhoneNumberType = C.Name	
	  ,D.EmailAddress

FROM AdventureWorks2019.Person.Person A
	LEFT JOIN AdventureWorks2019.Person.PersonPhone B 
		ON A.BusinessEntityID = B.BusinessEntityID -- BusinessEntityID
	LEFT JOIN AdventureWorks2019.Person.PhoneNumberType C
		ON B.PhoneNumberTypeID = C.PhoneNumberTypeID -- PhoneNumberTypeID	
	LEFT JOIN AdventureWorks2019.Person.EmailAddress D
		ON A.BusinessEntityID = D.BusinessEntityID


-- Your Code
-- a) Create Core Temp Table:
CREATE TABLE #Names
(
BusinessEntityID int,
Title nvarchar(8),
FirstName nvarchar(50),
MiddleName nvarchar(50),
LastName nvarchar(50)
)
INSERT INTO #Names
(
BusinessEntityID,
Title,
FirstName,
MiddleName,
LastName
)
SELECT 
BusinessEntityID,
Title,
FirstName,
MiddleName,
LastName
FROM AdventureWorks2019.Person.Person

-- b) Create Master Total Temp Table:
CREATE TABLE #Master
(
BusinessEntityID int,
Title nvarchar(8),
FirstName nvarchar(50),
MiddleName nvarchar(50),
LastName nvarchar(50),
PhoneNumber nvarchar(25),
PhoneNumberTypeID int,
PhoneNumberType nvarchar(50),
EmailAddress nvarchar(50)
)
INSERT INTO #Master
(
BusinessEntityID,
Title,
FirstName,
MiddleName,
LastName,
PhoneNumber,
PhoneNumberTypeID
)
SELECT 
A.BusinessEntityID,
A.Title,
A.FirstName,
A.MiddleName,
A.LastName,
B.PhoneNumber,
B.PhoneNumberTypeID
FROM #Names A
LEFT JOIN AdventureWorks2019.Person.PersonPhone B ON
A.BusinessEntityID = B.BusinessEntityID

--b) Add values with Update and Join:
UPDATE #Master
SET PhoneNumberType = B.Name
FROM #Master A
LEFT JOIN AdventureWorks2019.Person.PhoneNumberType B ON
A.PhoneNumberTypeID = B.PhoneNumberTypeID

UPDATE #Master
SET EmailAddress = B.EmailAddress
FROM #Master A
LEFT JOIN AdventureWorks2019.Person.EmailAddress B ON
A.BusinessEntityID = B.BusinessEntityID

SELECT * FROM #Master
ORDER BY #Master.BusinessEntityID

DROP TABLE #Names
DROP TABLE #Master

