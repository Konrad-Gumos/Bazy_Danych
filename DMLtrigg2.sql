CREATE OR ALTER TRIGGER taxRateMonitoring
ON Sales.SalesTaxRate
AFTER UPDATE 
AS
BEGIN
	IF UPDATE(TaxRate)
	BEGIN 
		DECLARE @taxrate1 SMALLMONEY;
		DECLARE @taxrate2 SMALLMONEY;

		SELECT @taxrate1 = TaxRate FROM deleted;
		SELECT @taxrate2 =  TaxRate FROM inserted;

		IF @taxrate2 > taxrate1 * 1.3
		BEGIN
			RAISERROR('Za duża zmiana w polu TaxRate');
			ROLLBACK;
			RETURN;
		END;
	END;
END;