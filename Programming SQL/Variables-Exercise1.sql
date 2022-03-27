USE [AdventureWorks2019]
GO


-- Variables - Exercise 1
-- Refactor the provided code (see the "Variables Part 1 - Exercise Starter Code.sql" in the Resources for this section)
-- to utilize variables instead of embedded scalar subqueries.
DECLARE @MaxVacationHours INT
SELECT @MaxVacationHours = (SELECT MAX(VacationHours) FROM AdventureWorks2019.HumanResources.Employee)

SELECT
      BusinessEntityID,
      JobTitle,
      VacationHours,
      MaxVacationHours = @MaxVacationHours,
      PercentOfMaxVacationHours = (VacationHours * 1.0) / @MaxVacationHours

FROM AdventureWorks2019.HumanResources.Employee

WHERE (VacationHours * 1.0) / @MaxVacationHours >= 0.8

