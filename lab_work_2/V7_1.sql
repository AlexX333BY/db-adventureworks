USE AdventureWorks2012
GO

-- 1
SELECT HumanResources.EmployeePayHistory.BusinessEntityID, JobTitle, MAX(RateChangeDate) AS LastChangeDate 
    FROM HumanResources.Employee INNER JOIN HumanResources.EmployeePayHistory 
        ON (HumanResources.Employee.BusinessEntityId = HumanResources.EmployeePayHistory.BusinessEntityId) 
GROUP BY HumanResources.EmployeePayHistory.BusinessEntityID, JobTitle
GO

-- 2
SELECT Employee.BusinessEntityID, JobTitle, Department.Name AS DepName, StartDate, EndDate, 
    DATEDIFF(year, StartDate, ISNULL(EndDate, GETDATE())) AS Years FROM HumanResources.Employee 
        INNER JOIN HumanResources.EmployeeDepartmentHistory 
            ON (Employee.BusinessEntityID = EmployeeDepartmentHistory.BusinessEntityID) 
        INNER JOIN HumanResources.Department 
            ON (EmployeeDepartmentHistory.DepartmentID = Department.DepartmentID)
GO
