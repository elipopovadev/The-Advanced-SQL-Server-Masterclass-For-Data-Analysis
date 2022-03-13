USE [AdventureWorks2019]
GO

-- Exercise
-- Refactor your solution to the exercise from the section on CTEs (average sales/purchases minus top 10) using temp tables in place of CTEs.
-- Code with CTE
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


-- Code with Temp Tables
SELECT 
OrderDate,
OrderMonth = DATEFROMPARTS(YEAR(OrderDate),MONTH(OrderDate),1),
TotalDue,
OrderRank = ROW_NUMBER() OVER(PARTITION BY DATEFROMPARTS(YEAR(OrderDate),MONTH(OrderDate),1) ORDER BY TotalDue DESC)
INTO #SALES
FROM AdventureWorks2019.Sales.SalesOrderHeader

SELECT
OrderMonth,
TotalSales = SUM(TotalDue)
INTO #AvgSalesMinusTop10
FROM #SALES
WHERE OrderRank > 10
GROUP BY OrderMonth

SELECT 
OrderDate,
OrderMonth = DATEFROMPARTS(YEAR(OrderDate),MONTH(OrderDate),1),
TotalDue,
OrderRank = ROW_NUMBER() OVER(PARTITION BY DATEFROMPARTS(YEAR(OrderDate),MONTH(OrderDate),1) ORDER BY TotalDue DESC)
INTO #Purchases
FROM AdventureWorks2019.Purchasing.PurchaseOrderHeader

SELECT
OrderMonth,
TotalPurchases = SUM(TotalDue)
INTO #AvgPurchasesMinusTop10
FROM #Purchases
WHERE OrderRank > 10
GROUP BY OrderMonth

SELECT
A.OrderMonth,
A.TotalSales,
B.TotalPurchases
FROM #AvgSalesMinusTop10 A
JOIN #AvgPurchasesMinusTop10 B ON A.OrderMonth = B.OrderMonth
ORDER BY 1

DROP TABLE #Sales
DROP TABLE #AvgSalesMinusTop10
DROP TABLE #Purchases
DROP TABLE #AvgPurchasesMinusTop10
