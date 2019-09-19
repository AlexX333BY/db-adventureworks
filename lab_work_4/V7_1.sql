USE AdventureWorks2012;
GO

-- 1
CREATE TABLE Sales.CurrencyHst
(
    ID INT IDENTITY(1, 1),
    Action NVARCHAR(6) NOT NULL CHECK (Action IN('insert', 'update', 'delete')),
    ModifiedDate DATETIME NOT NULL DEFAULT GETDATE(),
    SourceID nchar(3) NOT NULL,
    UserName Name NOT NULL
);
GO

-- 2
CREATE TRIGGER
    Sales.OnCurrencyInsert
ON
    Sales.Currency
AFTER
    INSERT
AS
    INSERT INTO
        Sales.CurrencyHst
        (
            Action,
            SourceID,
            UserName,
            ModifiedDate
        )
    SELECT
        'insert',
        CurrencyCode,
        CURRENT_USER,
        INSERTED.ModifiedDate
    FROM
        INSERTED;
GO
CREATE TRIGGER
    Sales.OnCurrencyUpdate
ON
    Sales.Currency
AFTER
    UPDATE
AS
    INSERT INTO
        Sales.CurrencyHst
        (
            Action,
            SourceID,
            UserName,
            ModifiedDate
        )
    SELECT
        'update',
        CurrencyCode,
        CURRENT_USER,
        INSERTED.ModifiedDate
    FROM
        INSERTED;
GO
CREATE TRIGGER
    Sales.OnCurrencyDelete
ON
    Sales.Currency
AFTER
    DELETE
AS
    INSERT INTO
        Sales.CurrencyHst
        (
            Action,
            SourceID,
            UserName,
            ModifiedDate
        )
    SELECT
        'delete',
        CurrencyCode,
        CURRENT_USER,
        DELETED.ModifiedDate
    FROM
        DELETED;
GO

-- 3
CREATE VIEW
    Sales.CurrencyView
    WITH ENCRYPTION
AS
    SELECT
        CurrencyCode,
        Name,
        ModifiedDate
    FROM
        Sales.Currency;
GO

-- 4
INSERT INTO
    Sales.CurrencyView
    (
        CurrencyCode, Name
    )
VALUES
(
    'BYR',
    'Belarusian Ruble'
);
GO
UPDATE
    Sales.CurrencyView
SET
    CurrencyCode = 'BYN',
    Name = 'New Belarusian Ruble'
WHERE
    CurrencyCode = 'BYR';
GO
DELETE
FROM
    Sales.CurrencyView
WHERE
    CurrencyCode = 'BYN';
GO
SELECT * FROM Sales.CurrencyHst;
GO
