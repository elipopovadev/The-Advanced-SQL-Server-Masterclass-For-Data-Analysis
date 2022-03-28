USE [AdventureWorks2019]
GO


-- Exercise
--Modify your "dbo.OrdersAboveThreshold" stored procedure once again, such that if a user supplies a value of 3
--to the @OrderType parameter, the proc should return all sales AND purchase orders above the specified threshold, 
--with order dates between the specified years.

-- In this scenario, include an "OrderType" column to the procedure output.
-- This column should have a value of "Sales" for records from the SalesOrderHeader table,
-- and "Purchase" for records from the PurchaseOrderHeader table.

CREATE OR ALTER PROCEDURE dbo.OrdersAboveThreshold (@Threshold MONEY, @StartYear INT, @EndYear INT, @OrderType INT)
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

    ELSE IF @OrderType = 3
	      BEGIN
		     SELECT 
					OrderID = A.SalesOrderID,
					OrderType = 'Sales',
					A.OrderDate,
					A.TotalDue

				FROM  AdventureWorks2019.Sales.SalesOrderHeader A
					JOIN AdventureWorks2019.dbo.Calendar B
						ON A.OrderDate = B.DateValue

				WHERE A.TotalDue >= @Threshold
					AND B.YearNumber BETWEEN @StartYear AND @EndYear

           UNION ALL

			  SELECT 
					A.PurchaseOrderID,
					OrderType = 'Purchase',
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
EXEC dbo.OrdersAboveThreshold 10000, 2011, 2013, 3

