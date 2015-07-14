--Problem01

CREATE TABLE Persons(
PersonID  int IDENTITY PRIMARY KEY  NOT NULL,
FirstName nvarchar(20) NULL,
LastName nvarchar(20) NULL,
SSN nvarchar(10) NULL)
GO
CREATE TABLE Accounts(
AccountID int IDENTITY PRIMARY KEY  NOT NULL,
PersonID int FOREIGN KEY REFERENCES Persons(PersonID) NOT NULL ,
Balance float NULL 
)
GO


INSERT INTO Persons VALUES ('Goshko','Geshev','3213137131')
INSERT INTO Persons VALUES ('Peshka','Gesheva','9803137131')
INSERT INTO Persons VALUES ('Pesho','Peshev','7653137131')
INSERT INTO Persons VALUES ('Ganka','Pesheva','5433137131')
INSERT INTO Persons VALUES ('Petko','Karabadjiev','1233137131')

SELECT * FROM Persons

INSERT INTO Accounts VALUES (1,250.00)
INSERT INTO Accounts VALUES (4,-250.00)
INSERT INTO Accounts VALUES (2,3876)
INSERT INTO Accounts VALUES (3,765)
INSERT INTO Accounts VALUES (5,2313)

SELECT * FROM Accounts
GO
CREATE PROC usp_PersonsFullName AS
SELECT FirstName + ' '+ LastName as [FullName] From Persons
GO

EXEC usp_PersonsFullName

GO
--Problem02
CREATE PROC  usp_SalaryCheck(@money float) AS
SELECT FirstName + ' ' + LastName as [Full Name] , a.Balance as [Balance] FROM Persons p
JOIN Accounts a ON p.PersonID=a.PersonID
WHERE a.Balance>=@money
GO
EXEC usp_SalaryCheck 500

--Probem03
CREATE FUNCTION ufn_CalcSum(@sum float, @interest float, @months int) RETURNS float
AS
	BEGIN
		DECLARE @monthlyInterest float
		SET @monthlyInterest = @interest / 12
		RETURN @sum * (1 + @months * @monthlyInterest / 100)
	END
GO

SELECT
	FirstName + ' ' + LastName AS [Full Name],
	dbo.ufn_CalcSum	(a.Balance, 3, 12) AS FutereSum
FROM Persons p
	JOIN Accounts a ON p.PersonID=a.PersonID

--Problem04

CREATE PROC usp_OneMonthInterest(@id int ,@interest float ) AS
DECLARE @oldBalance float
SELECT @oldBalance=Balance FROM Accounts a
WHERE PersonID=@id
DECLARE @newBalance float
SET @newBalance=dbo.ufn_CalcSum(@oldBalance,@interest,1)
UPDATE Accounts
SET Balance=@newBalance
WHERE PersonID=@id
GO

SELECT * FROM Accounts
EXEC usp_OneMonthInterest 1,20
SELECT * FROM Accounts

--Problem05
CREATE PROC usp_WithDrawMoney(@id int ,@amount float ) AS
BEGIN TRAN
DECLARE @oldBalance float
SELECT @oldBalance=Balance FROM Accounts a
WHERE PersonID=@id
DECLARE @newBalance float
if(@amount<0)
	BEGIN
	RAISERROR ('You can''t withdraw negative money!', 16, 1)
	END
IF(@oldBalance<@amount)
	BEGIN
	RAISERROR ('The amount should be less than the balance!', 16, 1)
	END
SET @newBalance=@oldBalance-@amount
UPDATE Accounts
SET Balance=@newBalance
WHERE PersonID=@id
COMMIT

GO

CREATE PROC usp_DepositMoney(@id int ,@amount float ) AS
BEGIN TRAN
DECLARE @oldBalance float
SELECT @oldBalance=Balance FROM Accounts a
WHERE PersonID=@id
DECLARE @newBalance float
if(@amount<0)
	BEGIN
	RAISERROR ('You can''t deposit negative money!', 16, 1)
	END
SET @newBalance=@oldBalance+@amount
UPDATE Accounts
SET Balance=@newBalance
WHERE PersonID=@id
COMMIT

GO

SELECT * FROM Accounts
EXEC usp_WithDrawMoney 1,35
SELECT * FROM Accounts

SELECT * FROM Accounts
EXEC usp_DepositMoney 3,70
SELECT * FROM Accounts



--Problem06
CREATE TABLE Logs(
	LogId int PRIMARY KEY IDENTITY(1,1) NOT NULL,
	AccountId int NOT NULL FOREIGN KEY REFERENCES Accounts(AccountID),
	OldValue float NULL,
	NewValue money NULL)

GO

CREATE TRIGGER tr_BankAccountsChange ON Accounts
FOR UPDATE
AS
INSERT INTO dbo.Logs (AccountId, NewValue, OldValue)
	SELECT
		d.PersonID,
		i.Balance,
		d.Balance
	FROM INSERTED i
		JOIN DELETED d
			ON d.PersonID = i.PersonID
GO

EXEC usp_DepositMoney 3,70
EXEC usp_DepositMoney 3,70
EXEC usp_WithDrawMoney 1,35
SELECT * FROM Logs


