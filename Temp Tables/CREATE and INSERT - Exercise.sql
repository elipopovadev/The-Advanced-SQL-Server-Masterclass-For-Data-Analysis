USE [AdventureWorks2019]
GO


-- Exercise
-- Rewrite your solution from last video's exercise using CREATE and INSERT instead of SELECT INTO.
-- Code with Temp Tables
CREATE TABLE #SALES
(
OrderDate DATE,
OrderMonth DATE,
TotalDue MONEY,
OrderRank INT
)
INSERT INTO #SALES
(
OrderDate,
OrderMonth,
TotalDue,
OrderRank
)
SELECT 
OrderDate,
OrderMonth = DATEFROMPARTS(YEAR(OrderDate),MONTH(OrderDate),1),
TotalDue,
OrderRank = ROW_NUMBER() OVER(PARTITION BY DATEFROMPARTS(YEAR(OrderDate),MONTH(OrderDate),1) ORDER BY TotalDue DESC)
FROM AdventureWorks2019.Sales.SalesOrderHeader

SELECT * FROM #SALES


CREATE TABLE #AvgSalesMinusTop10
(
OrderMonth DATE,
TotalSales MONEY
)
INSERT INTO #AvgSalesMinusTop10
(
OrderMonth,
TotalSales
)
SELECT
OrderMonth,
TotalSales = SUM(TotalDue)
FROM #SALES
WHERE OrderRank > 10
GROUP BY OrderMonth

SELECT * FROM #AvgSalesMinusTop10


CREATE TABLE #Purchases
(
OrderDate DATE,
OrderMonth DATE,
TotalDue MONEY,
OrderRank INT
)
INSERT INTO #Purchases
(
OrderDate,
OrderMonth,
TotalDue,
OrderRank
)
SELECT 
OrderDate,
OrderMonth = DATEFROMPARTS(YEAR(OrderDate),MONTH(OrderDate),1),
TotalDue,
OrderRank = ROW_NUMBER() OVER(PARTITION BY DATEFROMPARTS(YEAR(OrderDate),MONTH(OrderDate),1) ORDER BY TotalDue DESC)
FROM AdventureWorks2019.Purchasing.PurchaseOrderHeader

SELECT * FROM #Purchases


CREATE TABLE #AvgPurchasesMinusTop10
(
OrderMonth DATE,
TotalPurchases MONEY
)
INSERT INTO  #AvgPurchasesMinusTop10
(
OrderMonth,
TotalPurchases
)
SELECT
OrderMonth,
TotalPurchases = SUM(TotalDue)
FROM #Purchases
WHERE OrderRank > 10
GROUP BY OrderMonth

SELECT * FROM #AvgPurchasesMinusTop10


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

