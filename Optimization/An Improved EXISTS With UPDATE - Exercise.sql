USE AdventureWorks2019
GO


-- Exercise
-- Re-write the query in the "An Improved EXISTS With UPDATE - Exercise Starter Code.sql" file
-- (you can find the file in the Resources for this section), using temp tables and UPDATEs instead of EXISTS.
-- In addition to the three columns in the original query, you should also include a fourth column called "RejectedQty",
-- which has one value for rejected quantity from the Purchasing.PurchaseOrderDetail table.

SELECT
       A.PurchaseOrderID,
	   A.OrderDate,
	   A.TotalDue

FROM AdventureWorks2019.Purchasing.PurchaseOrderHeader A

WHERE EXISTS (
	SELECT
	1
	FROM AdventureWorks2019.Purchasing.PurchaseOrderDetail B
	WHERE A.PurchaseOrderID = B.PurchaseOrderID
		AND B.RejectedQty > 5
)

ORDER BY 1

-- Your code:
CREATE TABLE #Purchases
(
PurchaseOrderID INT,
OrderDate DATE,
TotalDue MONEY,
RejectedQty INT
)
INSERT INTO #Purchases
(
PurchaseOrderID,
OrderDate,
TotalDue
)
SELECT
PurchaseOrderID,
OrderDate,
TotalDue
FROM AdventureWorks2019.Purchasing.PurchaseOrderHeader

UPDATE A
SET A.RejectedQty = B.RejectedQty
FROM #Purchases A
JOIN AdventureWorks2019.Purchasing.PurchaseOrderDetail B ON
A.PurchaseOrderID = B.PurchaseOrderID
WHERE B.RejectedQty > 5


SELECT * FROM #Purchases
WHERE RejectedQty IS NOT NULL


DROP TABLE #Purchases

