USE [AdventureWorks2019]
GO


-- Exercise 1
-- Create a query that displays all rows from the Production.ProductSubcategory table, and includes the following fields:
-- The "Name" field from Production.ProductSubcategory, which should be aliased as "SubcategoryName"
-- A derived field called "Products" which displays, for each Subcategory in Production.ProductSubcategory,
-- a semicolon-separated list of all products from Production.Product contained within the given subcategory
-- Hint: Production.ProductSubcategory and Production.Product are related by the "ProductSubcategoryID" field.
SELECT SubcategoryName = A.NAME,
Products = 
STUFF(
(
SELECT ', ' + B.Name
FROM Production.Product AS B
WHERE A.ProductSubcategoryID = B.ProductSubcategoryID
FOR XML PATH('')
),
1, 1, '')
FROM Production.ProductSubcategory AS A


-- Exercise 2
-- Modify the query from Exercise 1 such that only products with a ListPrice value greater than $50 are included in the "Products" field.
-- Hint: Assuming you used a correlated subquery in Exercise 1, keep in mind that you can apply additional criteria to it,
-- just as with any other correlated subquery.
SELECT SubcategoryName = A.NAME,
Products = 
STUFF(
(
SELECT ', ' + B.Name
FROM Production.Product AS B
WHERE A.ProductSubcategoryID = B.ProductSubcategoryID
AND B.ListPrice > 50
FOR XML PATH('')
),
1, 1, '')
FROM Production.ProductSubcategory AS A


