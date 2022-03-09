-- Exercise 1
-- Use a recursive CTE to generate a list of all odd numbers between 1 and 100.
-- Hint: You should be able to do this with just a couple slight tweaks to the code from our first example in the video.
WITH NumberSeries AS
(
SELECT 1 AS MyNumber
 
UNION ALL
 
SELECT
MyNumber + 2
FROM NumberSeries
WHERE MyNumber < 99
)
 
SELECT
MyNumber
FROM NumberSeries


-- Exercise 2
-- Use a recursive CTE to generate a date series of all FIRST days of the month (1/1/2021, 2/1/2021, etc.) from 1/1/2020 to 12/1/2029.
-- Hints: Use the DATEADD function strategically in your recursive member. You may also have to modify MAXRECURSION.
WITH DataSeries AS
(
SELECT CAST('01-01-2020' AS DATE) AS MyDate
 
UNION ALL
 
SELECT
DATEADD(MONTH,1,MyDate)
FROM DataSeries
WHERE MyDate < CAST('12-01-2029' AS DATE)
)
 
SELECT
MyDate
FROM DataSeries
OPTION(MAXRECURSION 120)

