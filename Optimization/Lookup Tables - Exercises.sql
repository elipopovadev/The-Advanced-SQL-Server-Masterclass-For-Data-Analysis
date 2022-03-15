USE AdventureWorks2019
GO


-- Exercise 1
-- Update your calendar lookup table with a few holidays of your choice that always fall on the same day of the year - for example,
-- New Year's.
UPDATE AdventureWorks2019.dbo.Calendar
SET
HolidayFlag =
    CASE
        WHEN DayOfMonthNumber = 31 AND MonthNumber = 12 THEN 1
		WHEN DayOfMonthNumber = 3 AND MonthNumber = 3 THEN 1
		WHEN DayOfMonthNumber = 24 AND MonthNumber = 5 THEN 1
        ELSE 0
    END
 
SELECT * FROM AdventureWorks2019.dbo.Calendar
 

-- Exercise 2
-- Using your updated calendar table, pull all purchasing orders that were made on a holiday. 
-- It's fine to simply select all columns via SELECT *.
SELECT *
FROM [Purchasing].[PurchaseOrderHeader] A
JOIN AdventureWorks2019.dbo.Calendar B
ON A.OrderDate = B.DateValue
WHERE B.HolidayFlag = 1


-- Exercise 3
-- Again using your updated calendar table, now pull all purchasing orders that were made on a holiday that also fell on a weekend.
SELECT *
FROM [Purchasing].[PurchaseOrderHeader] A
JOIN AdventureWorks2019.dbo.Calendar B
ON A.OrderDate = B.DateValue
WHERE B.WeekendFlag = 1 AND B.HolidayFlag = 1

