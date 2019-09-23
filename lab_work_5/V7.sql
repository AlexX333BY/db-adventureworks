USE AdventureWorks2012;
GO

-- 1
CREATE FUNCTION
    dbo.FN_GetLastUsdRate(@CurrencyCode nchar(3))
RETURNS
    MONEY
AS
BEGIN
    RETURN
    (
        SELECT TOP 1
            AverageRate
        FROM
            Sales.CurrencyRate
        WHERE
            ToCurrencyCode = @CurrencyCode
            AND FromCurrencyCode = 'USD'
        ORDER BY
            CurrencyRateDate DESC
    )
END;
GO
