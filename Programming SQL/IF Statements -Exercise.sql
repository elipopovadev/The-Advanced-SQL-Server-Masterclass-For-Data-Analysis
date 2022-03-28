USE [AdventureWorks2019]
GO

-- Exercise
-- Modify the stored procedure you created for the stored procedures exercise (dbo.OrdersAboveThreshold) to include
-- an additional parameter called "@OrderType" (data type INT).
-- If the user supplies a value of 1 to this parameter, your modified proc should return the same output as previously.
-- If however the user supplies a value of 2, your proc should return purchase orders instead of sales orders. 

ALTER PROCEDURE dbo.OrdersAboveThreshold (@Threshold MONEY, @StartYear INT, @EndYear INT, @OrderType INT)
AS
BEGIN
   IF @OrderType = 1
		  BEGIN
				SELECT 
					A.SalesOrderID,
					A.OrderDate,
					A.TotalDue

				FROM  AdventureWorks2019.Sales.SalesOrderHeader A
					JOIN AdventureWorks2019.dbo.Calendar B
						ON A.OrderDate = B.DateValue

				WHERE A.TotalDue >= @Threshold
					AND B.YearNumber BETWEEN @StartYear AND @EndYear
		  END
   ELSE IF @OrderType = 2
	      BEGIN
			    SELECT 
					A.PurchaseOrderID,
					A.OrderDate,
					A.TotalDue

				FROM  AdventureWorks2019.Purchasing.PurchaseOrderHeader A
					JOIN AdventureWorks2019.dbo.Calendar B
						ON A.OrderDate = B.DateValue

				WHERE A.TotalDue >= @Threshold
					AND B.YearNumber BETWEEN @StartYear AND @EndYear
		   END
END
GO


EXEC dbo.OrdersAboveThreshold 10000, 2011, 2013, 1
EXEC dbo.OrdersAboveThreshold 10000, 2011, 2013, 2

