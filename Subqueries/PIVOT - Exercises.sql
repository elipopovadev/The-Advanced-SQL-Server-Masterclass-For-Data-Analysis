USE [AdventureWorks2019]
GO
 

-- Exercise 1
-- Using PIVOT, write a query against the HumanResources.Employee table
-- that summarizes the average amount of vacation time for Sales Representatives, Buyers, and Janitors.
SELECT
[Sales Representative],
[Buyer],
[Janitor]
FROM
( 
SELECT 
JobTitle,
VacationHours
FROM HumanResources.Employee
) AS A

PIVOT(
AVG(VacationHours)
FOR JobTitle IN([Sales Representative], [Buyer], [Janitor])
) AS B


-- Exercise 2
-- Modify your query from Exercise 1 such that the results are broken out by Gender. Alias the Gender field as "Employee Gender" in your output.
SELECT
[Employee Gender] = Gender,
[Sales Representative],
[Buyer],
[Janitor]
FROM
( 
SELECT 
JobTitle,
VacationHours,
Gender
FROM HumanResources.Employee
) AS A

PIVOT(
AVG(VacationHours)
FOR JobTitle IN([Sales Representative], [Buyer], [Janitor])
) AS B

