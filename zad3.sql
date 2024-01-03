WITH Products AS (
  SELECT ProductID, ps.Name as CategoryName FROM
  Production.Product p JOIN Production.ProductSubcategory ps
  ON P.PRODUCTSUBCATEGORYID = PS.PRODUCTSUBCATEGORYID
)
SELECT CategoryName as Category, SUM(OrderQty * (UnitPrice - UnitPriceDiscount)) AS SalesValue
  FROM ProductCategories pc JOIN Sales.SalesOrderDetail s1
    ON s1.ProductID = pc.ProductID JOIN Sales.SalesOrderHeader s2
    ON s1.SalesOrderID = s2.SalesOrderID
GROUP BY CategoryName
ORDER BY CategoryName