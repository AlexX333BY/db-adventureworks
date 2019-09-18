USE AdventureWorks2012;
GO

-- 1
ALTER TABLE dbo.PersonPhone
    ADD
        OrdersCount INT,
        CardType NVARCHAR(50),
        IsSuperior AS IIF (CardType = 'SuperiorCard', 1, 0);
GO

-- 2
CREATE TABLE #PersonPhone
(
    BusinessEntityID INT NOT NULL PRIMARY KEY,
    PhoneNumber dbo.Phone NOT NULL,
    PhoneNumberTypeID BIGINT NULL,
    ModifiedDate DATETIME,
    PostalCode NVARCHAR(15) DEFAULT ('0'),
    City NVARCHAR(30),
    OrdersCount INT,
    CardType NVARCHAR(50)
);
GO
