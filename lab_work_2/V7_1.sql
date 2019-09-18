USE AdventureWorks2012

-- 1
SELECT HumanResources.EmployeePayHistory.BusinessEntityID, JobTitle, MAX(RateChangeDate) AS LastChangeDate 
    FROM HumanResources.Employee INNER JOIN HumanResources.EmployeePayHistory 
        ON (HumanResources.Employee.BusinessEntityId = HumanResources.EmployeePayHistory.BusinessEntityId) 
GROUP BY HumanResources.EmployeePayHistory.BusinessEntityID, JobTitle
