CREATE OR ALTER TRIGGER LastNameUp
ON Person.Person
AFTER INSERT 
AS
BEGIN
	UPDATE Person.Person
		SET LastName = UPPER(Person.LastName)
		FROM inserted
		WHERE Person.BusinessEntityID = inserted.BusinessEntityID
END;