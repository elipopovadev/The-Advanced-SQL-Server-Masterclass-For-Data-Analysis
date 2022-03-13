USE AdventureWorks2019
GO


--Exercise
-- Leverage TRUNCATE to re-use temp tables in your solution to "CREATE and INSERT" exercise.
CREATE TABLE #Orders
(
OrderDate DATE,
OrderMonth DATE,
TotalDue MONEY,
OrderRank INT
)


--Insert sales data:
INSERT INTO #Orders
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
FROM AdventureWorks2019.Sales.SalesOrderHeader --sales data


CREATE TABLE #AvgOrdersMinusTop10
(
OrderMonth DATE,
OrderType VARCHAR(32),
TotalDue MONEY
)

--Insert sales data:
INSERT INTO #AvgOrdersMinusTop10
(
OrderMonth,
OrderType,
TotalDue
)
SELECT
OrderMonth,
OrderType = 'Sales',
TotalDue = SUM(TotalDue)
FROM #Orders
WHERE OrderRank > 10
GROUP BY OrderMonth


--Empty out #Orders table
TRUNCATE TABLE #Orders


--Insert purchase data:
INSERT INTO #Orders
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
FROM AdventureWorks2019.Purchasing.PurchaseOrderHeader --purchase data


--Insert purchase data:
INSERT INTO #AvgOrdersMinusTop10
(
OrderMonth,
OrderType,
TotalDue
)
SELECT
OrderMonth,
OrderType = 'Purchase',
TotalDue = SUM(TotalDue)
FROM #Orders
WHERE OrderRank > 10
GROUP BY OrderMonth

SELECT
A.OrderMonth,
TotalSales = A.TotalDue,
TotalPurchases = B.TotalDue

FROM #AvgOrdersMinusTop10 A
JOIN #AvgOrdersMinusTop10 B
ON A.OrderMonth = B.OrderMonth
AND B.OrderType = 'Purchase'
WHERE A.OrderType = 'Sales'
ORDER BY 1

DROP TABLE #ORDERS
DROP TABLE #AvgOrdersMinusTop10

