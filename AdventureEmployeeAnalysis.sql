-- Analysing employee data:

-- Emplyee table
SELECT *
FROM DimEmployee

-- How many active employees did we have on November 13th, 2013?
SELECT Count(1)
FROM DimEmployee emp
WHERE StartDate <= '2013-11-13'
AND (
		EndDate > '2013-11-13'
		OR
		EndDate IS NULL)

-- Using the above calculation for every single day we can analyse an employee trend. 
-- We will need to use another table that has just every day in it.

-- In this case we check the Date table (also called date dimension):
SELECT top 100 * 
FROM DimDate

-- Here we can see the trend of active employees by month

-- We start by getting the Daily count
SELECT
		dt.FullDateALternateKey as 'Date'
	,	count(1) as ActiveCount
FROM DimDate dt
LEFT JOIN	(SELECT 'Active' as 'EmpStatus', * FROM DimEmployee) emp -- Subquery
	-- regular active employees
	ON (dt.FullDateAlternateKey between emp.StartDate and ISNULL (emp.EndDate, '9999-12-31'))
GROUP BY
		dt.FullDateAlternateKey
ORDER BY 
		1
-- To analyse the monthly trend, we need to use the end of month fuction (Specific to SQL Server) with the above query.

-- Show End of Month function
SELECT Distinct Top 20 EOMONTH(FullDateAlternateKey)
FROM DimDate d
ORDER BY 1


-- Here the counts are cumulative, so for monthly totals take the last day of the month
SELECT
		dt.FullDateALternateKey as 'Date'
	,	count(1) as ActiveCount
FROM DimDate dt
LEFT JOIN	(SELECT 'Active' as 'EmpStatus', * FROM DimEmployee) emp -- Subquery
	-- regular active employees
	ON (dt.FullDateAlternateKey between emp.StartDate and ISNULL (emp.EndDate, '9999-12-31'))
	WHERE
		dt.FullDateAlternateKey = EOMONTH(dt.FullDateAlternateKey)
	GROUP BY
			dt.FullDateAlternateKey
	ORDER BY
			1
-- Working with Commom Table Expressions (CTEs)

-- Use CTE to Navigate employee hierarchy
WITH DirectReports (ManagerID, EmployeeID, Title, DeptID, Level)
AS
(
-- Anchor member definition
	SELECT e.ParentEmployeeKey, e.EmployeeKey, e.Title, e.DepartmentName,
		0 AS Level 
	FROM DimEmployee AS e
	WHERE e.ParentEmployeeKey IS NULL
	UNION ALL
--Recursive member definition
	SELECT e.ParentEmployeeKey, e.EmployeeKey, e.Title, e.DepartmentName,
		Level + 1
	FROM DimEmployee AS e
	INNER JOIN DirectReports AS d
		ON e.ParentEmployeeKey = d.EmployeeID
	)
-- Statement that excutes the CTE
SELECT ManagerID, EmployeeID, Title, DeptID, Level
FROM DirectReports
WHERE DeptID = 'Information Services' OR Level = 0
