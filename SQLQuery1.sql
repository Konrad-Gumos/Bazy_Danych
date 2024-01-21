USE AdventureWorks2022;

--  1)
BEGIN TRANSACTION;
UPDATE Production.Product
SET StandardCost = 1.1 * StandardCost WHERE ProductID = 680;
COMMIT;

-- 2)
BEGIN TRANSACTION;
INSERT INTO Production.Product (
  ProductID, Name, ProductNumber, MakeFlag, FinishedGoodsFlag, Color, SafetyStockLevel,
  ReorderPoint, StandardCost, ListPrice, "Size", SizeUnitMeasureCode, WeightUnitMeasureCode, Weight,
  DaysToManufacture, ProductLine, Class, Style, ProductSubcategoryID, ProductModelID, SellStartDate,
  SellEndDate, DiscontinuedDate, rowguid, ModifiedDate )
  VALUES ( 4566, 'Temp', 'TE-3242', '0', '1', 'Blue', '1000', '250', '34.65', '345.4',
           '37', 'CM', 'KG', '3.43', '10', 'R', 'H', 'U', 2, '5', '2024-04-31',
           '2025-04-31', '2027-04-31', '43AST4D6-34MKF-4623-9069-523MKTN5H137', '2024-01-09' );
COMMIT;

-- 3)
BEGIN TRANSACTION;
DELETE FROM Production.Product WHERE ProductID = '4566';
ROLLBACK;

-- 4)
BEGIN TRANSACTION;
UPDATE Production.Product
SET StandardCost = StandardCost * 1.1;
IF (SELECT SUM(StandardCost) FROM Production.Product) <= 50000
    COMMIT;
ELSE
    ROLLBACK;

-- 5)
BEGIN TRANSACTION;
BEGIN TRY
  INSERT INTO Production.Product (
    ProductID, Name, ProductNumber, MakeFlag, FinishedGoodsFlag, Color, SafetyStockLevel,
    ReorderPoint, StandardCost, ListPrice, "Size", SizeUnitMeasureCode, WeightUnitMeasureCode, Weight,
    DaysToManufacture, ProductLine, Class, Style, ProductSubcategoryID, ProductModelID, SellStartDate,
    SellEndDate, DiscontinuedDate, rowguid, ModifiedDate
  )
  VALUES ( 4566, 'Temp', 'TE-3242', '0', '1', 'Blue', '1000', '250', '34.65', '345.4',
           '37', 'CM', 'KG', '3.43', '10', 'R', 'H', 'U', 2, '5', '2024-04-31',
           '2025-04-31', '2027-04-31', '43AST4D6-34MKF-4623-9069-523MKTN5H137', '2024-01-09' );
  COMMIT;
END TRY
BEGIN CATCH
  ROLLBACK;
END CATCH;

-- 6)
BEGIN TRANSACTION;
UPDATE Sales.SalesOrderDetail
SET OrderQty = 4
IF EXISTS (SELECT 1 FROM Sales.SalesOrderDetail WHERE OrderQty = 0)
BEGIN
    ROLLBACK;
END
ELSE
BEGIN
    COMMIT;
END

-- 7)
BEGIN TRANSACTION;
DELETE FROM Production.Product WHERE StandardCost > (SELECT AVG(StandardCost) FROM Production.Product);
DECLARE @Deleted INT;
SET @Deleted = @@ROWCOUNT;
IF @Deleted > 10
BEGIN
    ROLLBACK;
END
ELSE
BEGIN
    COMMIT;
END