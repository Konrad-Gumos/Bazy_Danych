CREATE OR ALTER FUNCTION dbo.Fib
( 
	@n INT 
)
RETURNS @table TABLE
(
	nFib INT
)
AS
BEGIN
	DECLARE @f1 INT = 0, @f2 INT = 1, @p INT = 0;

	WHILE @p <  @n
	BEGIN
		INSERT INTO @table (nFib) VALUES (@f1);
		SET @f1 = @f1 + @f2;
		SET @f2 = @f1 - @f2;
		SET @p = @p + 1;
	END
	RETURN;
END;
