--Update NULL fields in Calendar table

UPDATE AdventureWorks2019.dbo.Calendar
SET
DayOfWeekNumber = DATEPART(WEEKDAY,DateValue),
DayOfWeekName = FORMAT(DateValue,'dddd'),
DayOfMonthNumber = DAY(DateValue),
MonthNumber = MONTH(DateValue),
YearNumber = YEAR(DateValue)


SELECT * FROM AdventureWorks2019.dbo.Calendar



UPDATE AdventureWorks2019.dbo.Calendar
SET
WeekendFlag = 
	CASE
		WHEN DayOfWeekNumber IN(1,7) THEN 1
		ELSE 0
	END


SELECT * FROM AdventureWorks2019.dbo.Calendar



UPDATE AdventureWorks2019.dbo.Calendar
SET
HolidayFlag =
	CASE
		WHEN DayOfMonthNumber = 1 AND MonthNumber = 1 THEN 1
		ELSE 0
	END


SELECT * FROM AdventureWorks2019.dbo.Calendar


--Use Calendar table in a query


SELECT
A.*

FROM AdventureWorks2019.Sales.SalesOrderHeader A
	JOIN AdventureWorks2019.dbo.Calendar B
		ON A.OrderDate = B.DateValue

WHERE B.WeekendFlag = 1

