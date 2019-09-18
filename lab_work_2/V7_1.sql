USE AdventureWorks2012
GO

-- 1
SELECT
    EmployeePayHistory.BusinessEntityID,
    JobTitle,
    MAX(RateChangeDate) AS LastChangeDate
FROM
    HumanResources.Employee
    INNER JOIN HumanResources.EmployeePayHistory
        ON (Employee.BusinessEntityId = EmployeePayHistory.BusinessEntityId)
GROUP BY
    EmployeePayHistory.BusinessEntityID,
    JobTitle
GO

-- 2
SELECT
    Employee.BusinessEntityID,
    JobTitle,
    Department.Name AS DepName,
    StartDate,
    EndDate,
    DATEDIFF(year, StartDate, ISNULL(EndDate, GETDATE())) AS Years
FROM
    HumanResources.Employee
    INNER JOIN HumanResources.EmployeeDepartmentHistory
        ON (Employee.BusinessEntityID = EmployeeDepartmentHistory.BusinessEntityID)
    INNER JOIN HumanResources.Department
        ON (EmployeeDepartmentHistory.DepartmentID = Department.DepartmentID)
GO

-- 3
SELECT
    Employee.BusinessEntityID,
    JobTitle,
    Department.Name AS DepName,
    GroupName,
    CASE
        WHEN CHARINDEX(' ', GroupName) = 0 THEN GroupName
        ELSE SUBSTRING(GroupName, 1, CHARINDEX(' ', GroupName))
    END AS DepGroup
FROM
    HumanResources.Employee
    INNER JOIN HumanResources.EmployeeDepartmentHistory
        ON (Employee.BusinessEntityID = EmployeeDepartmentHistory.BusinessEntityID)
    INNER JOIN HumanResources.Department
        ON (EmployeeDepartmentHistory.DepartmentID = Department.DepartmentID)
WHERE EndDate IS NULL
