USE AdventureWorks2012;
GO

-- 1
SELECT COUNT(*) AS DepartmentCount from HumanResources.Department 
    where GroupName = 'Executive General and Administration';
GO

--2
SELECT TOP 5 BusinessEntityID, JobTitle, Gender, BirthDate FROM HumanResources.Employee ORDER BY BirthDate DESC;
GO
