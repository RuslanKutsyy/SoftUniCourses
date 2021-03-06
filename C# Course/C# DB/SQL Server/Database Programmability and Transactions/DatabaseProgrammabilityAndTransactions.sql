-- Problem 1 - Employees with Salary Above 35000

CREATE PROCEDURE usp_GetEmployeesSalaryAbove35000
AS (SELECT e.FirstName, e.LastName
FROM Employees AS e
WHERE e.Salary > 35000)
GO

EXEC usp_GetEmployeesSalaryAbove35000
GO

-- Problem 2 - Employees with Salary Above Number

CREATE PROCEDURE usp_GetEmployeesSalaryAboveNumber(@SalaryLevel DECIMAL(18,4))
AS
	SELECT e.FirstName, e.LastName
	FROM Employees AS e
	WHERE e.Salary >= @SalaryLevel

GO

-- Problem 3 - Town Names Starting With

CREATE PROCEDURE usp_GetTownsStartingWith @StartPhrase VARCHAR(MAX)
AS
	SELECT t.Name
	FROM Towns AS t
	WHERE LEFT(t.Name, LEN(@StartPhrase)) LIKE @StartPhrase

GO

-- Problem 4 - Employees from Town

CREATE PROCEDURE usp_GetEmployeesFromTown @townName VARCHAR(50)
AS
	SELECT e.FirstName AS [First Name], e.LastName AS [Last Name]
	FROM Employees AS e
	JOIN Addresses AS ad
		ON e.AddressID = ad.AddressID
	JOIN Towns AS t
		ON ad.TownID = t.TownID
	WHERE t.Name = @townName

GO

EXEC usp_GetEmployeesFromTown @townName = 'Sofia'

GO

-- Problem 5 - Salary Level Function

CREATE OR ALTER FUNCTION ufn_GetSalaryLevel (@salary MONEY)
RETURNS NVARCHAR(10)
AS
BEGIN
	DECLARE @result VARCHAR(10)
	IF (@salary < 30000) SET @result = 'Low'
	ELSE IF (@salary >= 30000 AND @salary <= 50000) SET @result = 'Average'
	ELSE SET @result = 'High'
RETURN @result
END;

GO

-- Problem 6 - Employees by Salary Level

CREATE PROCEDURE usp_EmployeesBySalaryLevel @level VARCHAR(10)
AS
	SELECT e.FirstName, e.LastName
	FROM Employees AS e
	WHERE dbo.ufn_GetSalaryLevel(e.Salary) = @level

GO

-- Problem 7 - Define Function

CREATE FUNCTION ufn_IsWordComprised(@setOfLetters VARCHAR(MAX), @word VARCHAR(MAX))
RETURNS BIT
AS
BEGIN
	DECLARE @isComprised BIT = 0;
	DECLARE @counter INT = 1;
	DECLARE @letter CHAR = '';

	WHILE (@counter <= LEN(@word))
	BEGIN
		SET @letter = SUBSTRING(@word, @counter, 1);
		IF (CHARINDEX(@letter, @setOfLetters) = 0)
			RETURN @isComprised;
		SET @counter +=1;
	END
	RETURN @isComprised + 1;
END;