USE [AdventureWorks2019]
GO

-- Exercise 1
-- FirstName and LastName, from the Person.Person table**
SELECT FirstName, LastName
FROM [Person].[Person];

-- JobTitle, from the HumanResources.Employee table**
SELECT JobTitle
FROM [HumanResources].[Employee];

-- Rate, from the HumanResources.EmployeePayHistory table**
SELECT Rate
FROM [HumanResources].[EmployeePayHistory];

-- A derived column called "AverageRate" that returns the average of all values in the "Rate" column, in each row
SELECT AverageRate = AVG(Rate) OVER()
FROM [HumanResources].[EmployeePayHistory];

-- All the above tables can be joined on BusinessEntityID
SELECT FirstName, LastName, JobTitle, Rate, AverageRate = AVG(Rate) OVER()
FROM [Person].[Person]
JOIN [HumanResources].[Employee] ON
[Person].[Person].BusinessEntityID = [HumanResources].[Employee].BusinessEntityID
JOIN [HumanResources].[EmployeePayHistory] ON
[HumanResources].[Employee].BusinessEntityID = [HumanResources].[EmployeePayHistory].BusinessEntityID;


-- Exercise 2
-- Enhance your query from Exercise 1 by adding a derived column called 
-- "MaximumRate" that returns the largest of all values in the "Rate" column, in each row
SELECT FirstName, LastName, JobTitle, Rate, AverageRate = AVG(Rate) OVER(), MaximumRate = MAX(Rate) OVER()
FROM [Person].[Person]
JOIN [HumanResources].[Employee] ON
[Person].[Person].BusinessEntityID = [HumanResources].[Employee].BusinessEntityID
JOIN [HumanResources].[EmployeePayHistory] ON 
[HumanResources].[Employee].BusinessEntityID = [HumanResources].[EmployeePayHistory].BusinessEntityID;


-- Exercise 3
-- Enhance your query from Exercise 2 by adding a derived column called
-- "DiffFromAvgRate" that returns the result of the following calculation:
-- An employees's pay rate, MINUS the average of all values in the "Rate" column.
SELECT FirstName, LastName, JobTitle, Rate, AverageRate = AVG(Rate) OVER(), MaximumRate = MAX(Rate) OVER(),
DiffFromAvgRate = Rate - AVG(Rate) OVER()
FROM [Person].[Person]
JOIN [HumanResources].[Employee] ON
[Person].[Person].BusinessEntityID = [HumanResources].[Employee].BusinessEntityID
JOIN [HumanResources].[EmployeePayHistory] ON 
[HumanResources].[Employee].BusinessEntityID = [HumanResources].[EmployeePayHistory].BusinessEntityID;


-- Exercise 4
-- Enhance your query from Exercise 3 by adding a derived column called
-- "PercentofMaxRate" that returns the result of the following calculation:
-- An employees's pay rate, DIVIDED BY the maximum of all values in the "Rate" column, times 100.
SELECT FirstName, LastName, JobTitle, Rate, AverageRate = AVG(Rate) OVER(), MaximumRate = MAX(Rate) OVER(),
DiffFromAvgRate = Rate - AVG(Rate) OVER(),
PercentofMaxRate = (Rate / MAX(Rate) OVER()) * 100
FROM [Person].[Person]
JOIN [HumanResources].[Employee] ON
[Person].[Person].BusinessEntityID = [HumanResources].[Employee].BusinessEntityID
JOIN [HumanResources].[EmployeePayHistory] ON 
[HumanResources].[Employee].BusinessEntityID = [HumanResources].[EmployeePayHistory].BusinessEntityID;

