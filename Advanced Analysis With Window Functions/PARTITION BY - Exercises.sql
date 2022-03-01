USE [AdventureWorks2019]
GO


-- Exercise 1
-- Create a query with the following columns:
-- “Name” from the Production.Product table, which can be alised as “ProductName”
SELECT [Production].[Product].[Name] AS ProductName
FROM [Production].[Product]

-- “ListPrice” from the Production.Product table
SELECT ListPrice
FROM [Production].[Product]

-- “Name” from the Production.ProductSubcategory table, which can be alised as “ProductSubcategory”.
-- Join Production.ProductSubcategory to Production.Product on “ProductSubcategoryID”
SELECT Production.ProductSubcategory.[Name] AS ProductSubcategory
FROM [Production].[ProductSubcategory]
JOIN [Production].[Product] ON
[Production].[Product].ProductSubcategoryID = [ProductSubcategory].ProductSubcategoryID

-- “Name” from the Production.Category table, which can be alised as “ProductCategory”**
-- **Join Production.ProductCategory to ProductSubcategory on “ProductCategoryID”
SELECT [Production].[ProductCategory].[Name] AS ProductCategory
FROM [Production].[ProductCategory]
JOIN [Production].[ProductSubcategory] ON
[Production].[ProductSubcategory].ProductCategoryID = [Production].[ProductCategory].ProductCategoryID


-- Exercise 2
-- Enhance your query from Exercise 1 by adding a derived column called
-- "AvgPriceByCategory " that returns the average ListPrice for the product category in each given row.
SELECT [Production].[Product].[Name] AS ProductName,
[Production].[Product].ListPrice, 
[Production].[ProductSubcategory].[Name] AS ProductSubcategory,
[Production].[ProductCategory].[Name] AS ProductCategory,
AvgPriceByCategory = AVG([Production].[Product].ListPrice) OVER(PARTITION BY[Production].[ProductCategory].[Name])
FROM [Production].[Product]
JOIN [Production].[ProductSubcategory] ON
[Production].[ProductSubcategory].ProductSubcategoryID = [Production].[Product].ProductSubcategoryID
JOIN [Production].[ProductCategory] ON
[Production].[ProductCategory].ProductCategoryID = [Production].[ProductSubcategory].ProductCategoryID


-- Exercise 3
-- Enhance your query from Exercise 2 by adding a derived column called
-- "AvgPriceByCategoryAndSubcategory" that returns the average ListPrice for the product category AND subcategory in each given row.
SELECT [Production].[Product].[Name] AS ProductName,
[Production].[Product].ListPrice, 
[Production].[ProductSubcategory].[Name] AS ProductSubcategory,
[Production].[ProductCategory].[Name] AS ProductCategory,
AvgPriceByCategory = AVG([Production].[Product].ListPrice) OVER(PARTITION BY[Production].[ProductCategory].[Name]),
AvgPriceByCategoryAndSubcategory = AVG([Production].[Product].ListPrice)
OVER (PARTITION BY[Production].[ProductCategory].[Name], [Production].[ProductSubcategory].[Name])
FROM [Production].[Product]
JOIN [Production].[ProductSubcategory] ON
[Production].[ProductSubcategory].ProductSubcategoryID = [Production].[Product].ProductSubcategoryID
JOIN [Production].[ProductCategory] ON
[Production].[ProductCategory].ProductCategoryID = [Production].[ProductSubcategory].ProductCategoryID


-- Exercise 4:
-- Enhance your query from Exercise 3 by adding a derived column called
-- "ProductVsCategoryDelta" that returns the result of the following calculation:
-- A product's list price, MINUS the average ListPrice for that product’s category.
SELECT [Production].[Product].[Name] AS ProductName,
[Production].[Product].ListPrice, 
[Production].[ProductSubcategory].[Name] AS ProductSubcategory,
[Production].[ProductCategory].[Name] AS ProductCategory,
AvgPriceByCategory = AVG([Production].[Product].ListPrice) OVER(PARTITION BY[Production].[ProductCategory].[Name]),
AvgPriceByCategoryAndSubcategory = AVG([Production].[Product].ListPrice)
OVER (PARTITION BY[Production].[ProductCategory].[Name], [Production].[ProductSubcategory].[Name]),
ProductVsCategoryDelta = [Production].[Product].ListPrice - AVG([Production].[Product].ListPrice)
OVER(PARTITION BY [Production].[ProductCategory].[Name])
FROM [Production].[Product]
JOIN [Production].[ProductSubcategory] ON
[Production].[ProductSubcategory].ProductSubcategoryID = [Production].[Product].ProductSubcategoryID
JOIN [Production].[ProductCategory] ON
[Production].[ProductCategory].ProductCategoryID = [Production].[ProductSubcategory].ProductCategoryID

