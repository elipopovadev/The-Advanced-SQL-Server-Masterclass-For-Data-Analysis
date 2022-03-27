--Code to create user defined function:

CREATE FUNCTION dbo.ufnCurrentDate()

RETURNS DATE

AS

BEGIN

	RETURN CAST(GETDATE() AS DATE)

END


--Query that calls user defined function

SELECT
	   SalesOrderID
      ,OrderDate
      ,DueDate
      ,ShipDate
	  ,Today = dbo.ufnCurrentDate()

FROM AdventureWorks2019.Sales.SalesOrderHeader A

WHERE YEAR(A.OrderDate) = 2011

