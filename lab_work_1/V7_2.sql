USE AdventureWorks2012;
GO

-- 1
SELECT COUNT(*) AS DepartmentCount from HumanResources.Department 
    where GroupName = 'Executive General and Administration';
GO
