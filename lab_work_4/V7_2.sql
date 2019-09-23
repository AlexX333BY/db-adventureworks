USE AdventureWorks2012;
GO

-- 1
CREATE VIEW
    Sales.CurrencyRateView
WITH
    SCHEMABINDING
AS
    SELECT
        CurrencyCode,
        Name,
        CurrencyRateID,
        CurrencyRateDate,
        FromCurrencyCode,
        AverageRate,
        EndOfDayRate
    FROM
        Sales.Currency
        INNER JOIN Sales.CurrencyRate
            ON (CurrencyCode = ToCurrencyCode);
GO
CREATE UNIQUE CLUSTERED INDEX
    IX_CurrencyCurrencyRateView_CurrencyRateID
ON
    Sales.CurrencyRateView (CurrencyRateID);
GO

-- 2
CREATE TRIGGER
    Sales.OnCurrencyCurrencyRateViewAction
ON
    Sales.CurrencyRateView
INSTEAD OF
    INSERT,
    UPDATE,
    DELETE
AS
BEGIN
    -- insert
    IF EXISTS (SELECT * FROM inserted) AND NOT EXISTS(SELECT * FROM deleted)
    BEGIN
        IF EXISTS (SELECT * FROM Currency, inserted WHERE Currency.CurrencyCode = inserted.CurrencyCode)
            UPDATE
                Sales.Currency
            SET
                Name = inserted.Name,
                ModifiedDate = GETDATE()
            FROM
                inserted
            WHERE
                Currency.CurrencyCode = inserted.CurrencyCode
        ELSE
            INSERT INTO
                Sales.Currency
                (
                    CurrencyCode,
                    Name
                )
            SELECT
                CurrencyCode,
                Name
            FROM
                inserted;

        INSERT INTO
            Sales.CurrencyRate
            (
                CurrencyRateDate,
                FromCurrencyCode,
                ToCurrencyCode,
                AverageRate,
                EndOfDayRate
            )
        SELECT
            CurrencyRateDate,
            FromCurrencyCode,
            CurrencyCode,
            AverageRate,
            EndOfDayRate
        FROM
            inserted;
    END;

    -- update
    IF EXISTS (SELECT * FROM inserted) AND EXISTS (SELECT * FROM deleted)
    BEGIN
        UPDATE
            CurrencyRate
        SET
            CurrencyRateDate = inserted.CurrencyRateDate,
            FromCurrencyCode = inserted.FromCurrencyCode,
            AverageRate = inserted.AverageRate,
            EndOfDayRate = inserted.EndOfDayRate,
            ModifiedDate = GETDATE()
        FROM
            inserted,
            deleted
        WHERE
            CurrencyRate.CurrencyRateID = deleted.CurrencyRateID;

        UPDATE
            Currency
        SET
            Name = inserted.Name,
            ModifiedDate = GETDATE()
        FROM
            inserted,
            deleted
        WHERE
            Currency.CurrencyCode = deleted.CurrencyCode;
    END;

    -- delete
    IF EXISTS (SELECT * FROM deleted) AND NOT EXISTS(SELECT * FROM inserted)
    BEGIN
        DELETE
            CurrencyRate
        FROM
            Sales.CurrencyRate CurrencyRate,
            deleted
        WHERE
            CurrencyRate.ToCurrencyCode = deleted.CurrencyCode;

        DELETE
            Currency
        FROM
            Sales.Currency Currency,
            deleted
        WHERE
            Currency.CurrencyCode = deleted.CurrencyCode;
    END;
END;
GO

-- 3
INSERT INTO
    Sales.CurrencyRateView
    (
        CurrencyCode,
        Name,
        CurrencyRateDate,
        FromCurrencyCode,
        AverageRate,
        EndOfDayRate
    )
VALUES
    (
        'BYN',
        'Belarusian Ruble',
        GETDATE(),
        'USD',
        2.0,
        2.0
    );
GO

UPDATE
    Sales.CurrencyRateView
SET
    CurrencyRateDate = GETDATE(),
    AverageRate = 2.2,
    EndOfDayRate = 2.2
WHERE
    CurrencyCode = 'BYN';
GO

DELETE
FROM
    Sales.CurrencyRateView
WHERE
    CurrencyCode = 'BYN';
GO
