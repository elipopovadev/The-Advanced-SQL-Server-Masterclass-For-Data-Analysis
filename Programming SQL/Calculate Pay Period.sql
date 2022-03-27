-- Variables - Exercise 2
-- Let's say your company pays once per month, on the 15th.
-- If it's already the 15th of the current month (or later), the previous pay period will run from the 15th of the previous month,
-- to the 14th of the current month.
-- If on the other hand it's not yet the 15th of the current month, the previous pay period will run from the
-- 15th two months ago to the 14th on the previous month.
-- Set up variables defining the beginning and end of the previous pay period in this scenario.
-- Select the variables to ensure they are working properly.
DECLARE @Today DATE = CAST(GETDATE() AS DATE)
SELECT @Today
DECLARE @BeginningPayPeriod DATE
DECLARE @EndPayPeriod DATE
DECLARE @Current14 DATE = DATEFROMPARTS(YEAR(@Today),MONTH(@Today),14)
DECLARE @Current15 DATE = DATEFROMPARTS(YEAR(@Today),MONTH(@Today),15)

SELECT @BeginningPayPeriod =
CASE
WHEN DAY(@Today) < 15
THEN DATEADD(MONTH,-2, @Current15)
ELSE DATEADD(MONTH,-1, @Current15)
END

SELECT @EndPayPeriod =
CASE
WHEN DAY(@Today) >= 15
THEN @Current14
ELSE DATEADD(MONTH, - 1, @Current14)
END


SELECT
*
FROM AdventureWorks2019.dbo.Calendar
WHERE DateValue BETWEEN @BeginningPayPeriod AND  @EndPayPeriod

