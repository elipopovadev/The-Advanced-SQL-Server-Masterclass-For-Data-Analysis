USE [AdventureWorks2019]
GO

--Exercise 1
--Create a user-defined function that returns the percent that one number is of another.
--For example, if the first argument is 8 and the second argument is 10, the function should return the string "80.00%".
--The function should solve the "integer division" problem by allowing you to divide an integer by another integer,
--and yet get an accurate decimal result.
CREATE FUNCTION dbo.ufnReturnPercentOfNumber(@FirstNumber INT, @SecondNumber INT)
RETURNS NVARCHAR(8)
AS  
BEGIN
    DECLARE @Result DECIMAL(8,2) = (@FirstNumber * 1.0) / (@SecondNumber * 1.0) * 100.0
    DECLARE @FinalResult NVARCHAR(8) = Cast(@Result AS NVARCHAR) + '%' 
	RETURN @FinalResult
END


SELECT dbo.ufnReturnPercentOfNumber(8 , 10)


--Exercise 2
--Store the maximum amount of vacation time for any individual employee in a variable.
--Then create a query that displays all rows and the following columns from the AdventureWorks2019.HumanResources.Employee table:
--BusinessEntityID
--JobTitle
--VacationHours
--Then add a derived field called "PercentOfMaxVacation", which returns the percent an individual employees'
--vacation hours are of the maximum vacation hours for any employee.
--For example, the record for the employee with the most vacation hours should have a value of 100.00%, in this column.
--The derived field should make use of your user-defined function from the previous exercise, as well as your variable that stored
--the maximum vacation hours for any employee.

DECLARE @MaxVacationHours INT = (SELECT MAX(VacationHours) FROM AdventureWorks2019.HumanResources.Employee)

SELECT 
BusinessEntityID,
JobTitle,
VacationHours,
PercentOfMaxVacation = dbo.ufnReturnPercentOfNumber(VacationHours,  @MaxVacationHours)
FROM AdventureWorks2019.HumanResources.Employee

