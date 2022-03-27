--Correlated Subquery Example:

SELECT
	  SalesOrderID,
      OrderDate,
      DueDate,
      ShipDate,
	  ElapsedBusinessDays = (
		SELECT
		COUNT(*)
		FROM AdventureWorks2019.dbo.Calendar B
		WHERE B.DateValue BETWEEN A.OrderDate AND A.ShipDate
			AND B.WeekendFlag = 0
			AND B.HolidayFlag = 0
	  )

FROM AdventureWorks2019.Sales.SalesOrderHeader A

WHERE YEAR(A.OrderDate) = 2011



--Rewriting as a function, with variables:

CREATE FUNCTION dbo.ufnElapsedBusinessDays(@StartDate DATE, @EndDate DATE)

RETURNS INT

AS  

BEGIN

	RETURN 
		(
			SELECT
				COUNT(*)
			FROM AdventureWorks2019.dbo.Calendar

			WHERE DateValue BETWEEN @StartDate AND @EndDate
				AND WeekendFlag = 0
				AND HolidayFlag = 0
		)	

END


--Using the function in a query

SELECT
	  SalesOrderID,
      OrderDate,
      DueDate,
      ShipDate,
	  ElapsedBusinessDays = dbo.ufnElapsedBusinessDays(OrderDate,ShipDate)
FROM AdventureWorks2019.Sales.SalesOrderHeader
WHERE YEAR(OrderDate) = 2011

