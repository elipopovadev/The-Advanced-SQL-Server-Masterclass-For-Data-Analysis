USE [AdventureWorks2019]
GO


-- For this exercise, assume the CEO of our fictional company decided that the top 10 orders per month
-- are actually outliers that need to be clipped out of our data before doing meaningful analysis.
-- Further, she would like the sum of sales AND purchases (minus these "outliers") listed side by side, by month.
-- We've got a query that already does this (see the file "CTEs - Exercise Starter Code.sql" in the resources for this section),
-- but it's messy and hard to read. Re-write it using a CTE so other analysts can read and understand the code.
-- Hint: You are comparing data from two different sources (sales vs purchases), so you may not be able to re-use a CTE like we did in the video.


-- Starter Code
SELECT
A.OrderMonth,
A.TotalSales,
B.TotalPurchases

FROM (
	SELECT
	OrderMonth,
	TotalSales = SUM(TotalDue)
	FROM (
		SELECT 
		   OrderDate
		  ,OrderMonth = DATEFROMPARTS(YEAR(OrderDate),MONTH(OrderDate),1)
		  ,TotalDue
		  ,OrderRank = ROW_NUMBER() OVER(PARTITION BY DATEFROMPARTS(YEAR(OrderDate),MONTH(OrderDate),1) ORDER BY TotalDue DESC)
		FROM AdventureWorks2019.Sales.SalesOrderHeader
		) S
	WHERE OrderRank > 10
	GROUP BY OrderMonth
) A

JOIN (
	SELECT
	OrderMonth,
	TotalPurchases = SUM(TotalDue)
	FROM (
		SELECT 
		   OrderDate
		  ,OrderMonth = DATEFROMPARTS(YEAR(OrderDate),MONTH(OrderDate),1)
		  ,TotalDue
		  ,OrderRank = ROW_NUMBER() OVER(PARTITION BY DATEFROMPARTS(YEAR(OrderDate),MONTH(OrderDate),1) ORDER BY TotalDue DESC)
		FROM AdventureWorks2019.Purchasing.PurchaseOrderHeader
		) P
	WHERE OrderRank > 10
	GROUP BY OrderMonth
) B	ON A.OrderMonth = B.OrderMonth

ORDER BY 1


-- Re-writed code with CTEs
WITH SALES AS
(
SELECT 
OrderDate,
OrderMonth = DATEFROMPARTS(YEAR(OrderDate),MONTH(OrderDate),1),
TotalDue,
OrderRank = ROW_NUMBER() OVER(PARTITION BY DATEFROMPARTS(YEAR(OrderDate),MONTH(OrderDate),1) ORDER BY TotalDue DESC)
FROM AdventureWorks2019.Sales.SalesOrderHeader
),
AvgSalesMinusTop10 AS
(
SELECT
OrderMonth,
TotalSales = SUM(TotalDue)
FROM SALES
WHERE OrderRank > 10
GROUP BY OrderMonth
),
Purchases AS
(
SELECT 
OrderDate,
OrderMonth = DATEFROMPARTS(YEAR(OrderDate),MONTH(OrderDate),1),
TotalDue,
OrderRank = ROW_NUMBER() OVER(PARTITION BY DATEFROMPARTS(YEAR(OrderDate),MONTH(OrderDate),1) ORDER BY TotalDue DESC)
FROM AdventureWorks2019.Purchasing.PurchaseOrderHeader
),
AvgPurchasesMinusTop10  AS
(
SELECT
OrderMonth,
TotalPurchases = SUM(TotalDue)
FROM Purchases
WHERE OrderRank > 10
GROUP BY OrderMonth
)

SELECT
A.OrderMonth,
A.TotalSales,
B.TotalPurchases
FROM AvgSalesMinusTop10 A
JOIN AvgPurchasesMinusTop10 B ON A.OrderMonth = B.OrderMonth
ORDER BY 1


