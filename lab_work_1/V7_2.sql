USE AdventureWorks2012;
GO

-- 1
SELECT
    COUNT(*) AS DepartmentCount
FROM
    HumanResources.Department
WHERE
    GroupName = 'Executive General and Administration';
GO

-- 2
SELECT TOP 5
    BusinessEntityID,
    JobTitle,
    Gender,
    BirthDate
FROM
    HumanResources.Employee
ORDER BY
    BirthDate DESC;
GO

-- 3
SELECT
    BusinessEntityID,
    JobTitle,
    Gender,
    HireDate,
    REPLACE(LoginID, 'adventure-works', 'adventure-works2012') AS LoginID
FROM
    HumanResources.Employee
WHERE
    Gender = 'F'
    AND DATENAME(weekday, HireDate) = 'Tuesday';
GO
