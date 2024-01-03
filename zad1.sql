WITH EmployeeInfo AS (
  SELECT FirstName, LastName, Rate
  FROM Person.Person AS p
  JOIN HumanResources.EmployeePayHistory as PayHist ON p.BusinessEntityID = PayHist.BusinessEntityID
     WHERE PersonType = 'EM' AND
      PayHist.ModifiedDate = (
        SELECT MAX(PayHist.ModifiedDate)
        FROM HumanResources.EmployeePayHistory as PayHist
        WHERE p.BusinessEntityID = PayHist.BusinessEntityID
    )
)

SELECT * INTO #TempEmployeeInfo FROM EmployeeInfo;

SELECT * FROM #TempEmployeeInfo;