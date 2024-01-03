CREATE OR ALTER PROCEDURE dbo.PrintFib
(
	@n INT
)
AS
BEGIN
    DECLARE @table TABLE 
    (
        nFib INT
    )

    INSERT INTO @table
    SELECT nFib FROM dbo.Fib(@n);

    DECLARE @nFib INT;

    DECLARE Fibcursor CURSOR FOR
    SELECT nFib FROM @table;

    OPEN Fibcursor;

    FETCH NEXT FROM Fibcursor INTO @nFib;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        PRINT @nFib;
        FETCH NEXT FROM Fibcursor INTO @nFib;
    END

    CLOSE Fibcursor;
    DEALLOCATE Fibcursor;
END;

EXEC dbo.PrintFib @n = 5;