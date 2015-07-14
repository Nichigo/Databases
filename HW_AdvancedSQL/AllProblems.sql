--Problem 01

SELECT FirstName ,LastName , Salary FROM Employees 
WHERE Salary=(SELECT MIN(Salary) FROM Employees)

--Problem02
SELECT FirstName ,LastName , Salary FROM Employees 
WHERE Salary BETWEEN (SELECT MIN(Salary) FROM Employees) AND 1.1*(SELECT MIN(Salary) FROM Employees)

--Problem03
SELECT e.FirstName ,e.LastName , e.Salary ,(SELECT Name FROM Departments WHERE DepartmentID=e.DepartmentID )AS [Department] FROM Employees e
WHERE Salary=(SELECT MIN(Salary) FROM Employees WHERE DepartmentID=e.DepartmentID) 



--Problem04
SELECT AVG(Salary) as [AVG Salary] From Employees
WHERE DepartmentID=1

--Problem05
SELECT AVG(Salary) as[AVG Salary] FROM Employees
WHERE DepartmentID=(Select DepartmentID FROM Departments WHERE Name='Sales')

--Problem06
SELECT COUNT(EmployeeID) as [Number of employees in Sales] From Employees
WHERE DepartmentID=(Select DepartmentID FROM Departments WHERE Name='Sales')

--Problem07
SELECT COUNT(EmployeeID) as [Number of employees with managers] From Employees
WHERE ManagerID IS NOT NULL

--Problem08
SELECT COUNT(EmployeeID) as [Number of employees with managers] From Employees
WHERE ManagerID IS  NULL

--Problem09
SELECT Name as [Department Name],AVG(e.Salary) as [Average Salary]FROM Departments d
INNER JOIN Employees e 
ON  d.DepartmentID=e.DepartmentID
GROUP BY d.Name

--Problem10
SELECT t.Name as Town,d.Name as [Department Name],Count(e.EmployeeID) as [Workers]FROM Departments d
INNER JOIN Employees e 
ON  d.DepartmentID=e.DepartmentID
INNER JOIN Addresses a
ON  a.AddressID=e.AddressID
INNER JOIN Towns t
ON  a.TownID=a.TownID

GROUP BY d.Name,t.Name
ORDER by d.Name

--Problem11
SELECT FirstName,LastName FROM Employees a
WHERE (SELECT COUNT(*) FROM Employees e WHERE e.ManagerID=a.EmployeeID)=5

--Problem12
SELECT e.FirstName,e.LastName,
ISNULL(m.FirstName + ' '+ m.LastName,'no manager') AS [Manager]
FROM Employees e
	LEFT JOIN Employees m
	ON e.ManagerID=m.EmployeeID

--Problem13
SELECT FirstName,LastName FROM Employees
WHERE LEN(LastName)=5

--Problem14 
SELECT CONVERT(VARCHAR(10),GETDATE(),104)+' '+CONVERT(VARCHAR(12),GETDATE(),114) AS [Date and Time]

--Problem15
CREATE TABLE Users(
UserID int IDENTITY,
Username nvarchar(50) NOT NULL UNIQUE,
Password nvarchar(50) NULL,
FullName nvarchar(50) NOT NULL,
LastLoginTime smalldatetime,
CONSTRAINT PK_UserID PRIMARY KEY (UserID),
CONSTRAINT CHK_Password CHECK (LEN(Password)>5)
)
GO

--Problem16
CREATE VIEW [Users Today] AS
SELECT * FROM Users
WHERE DAY(LastLoginTime)=DAY(GETDATE())
GO

--Problem17
CREATE TABLE Groups(
GroupID int IDENTITY,
Name nvarchar(50) NOT NULL UNIQUE,
CONSTRAINT PK_Groups PRIMARY KEY(GroupID)
)
GO

--Problem18
ALTER TABLE Users
ADD GroupID int NOT NULL,
FOREIGN KEY(GroupID) REFERENCES Groups(GroupID)
GO

--Problem19
INSERT INTO Groups VALUES ('Guests')
INSERT INTO Groups VALUES ('Ninjas')
INSERT INTO Groups VALUES ('Hackers')
INSERT INTO Groups VALUES ('Sys Admins')
INSERT INTO Users VALUES ('Goshko','taina123','Georgi Georgiev',GETDATE(),2)
INSERT INTO Users VALUES ('Dori','misipisi','Donka Bonkova',GETDATE(),1)

--Problem20
UPDATE Users SET Username='GogataPower'
WHERE UserID=1
UPDATE Groups SET Name='BananasInPijamas'
WHERE GroupID=2

--Problem21
DELETE FROM Groups
WHERE GroupID=3
GO

--Problem22
INSERT INTO Users
SELECT LEFT(FirstName,1)+LOWER(LastName)+ISNULL(LEFT(MiddleName,1),''),LEFT(FirstName,1)+LOWER(LastName)+'abcd',FirstName +' '+LastName,NULL,1 FROM Employees
GO


--Problem23
UPDATE  Users
SET Password=NULL
WHERE CAST(LastLoginTime AS smalldatetime) <= CAST('2010-03-10' AS smalldatetime) OR LastLoginTime IS NULL

--Problem24
DELETE FROM USERS
WHERE Password IS NULL 

--Problem25
SELECT d.Name, e.JobTitle,AVG(Salary) as [Average Department Salary] From Employees e
JOIN Departments d ON d.DepartmentID=e.DepartmentID
GROUP BY d.Name,e.JobTitle

--Problem26
SELECT d.Name, e.JobTitle,e.FirstName,Salary From Employees e
JOIN Departments d ON d.DepartmentID=e.DepartmentID
WHERE Salary=(SELECT MIN(Salary) FROM Employees WHERE DepartmentID=e.DepartmentID)
GROUP BY d.Name,e.JobTitle,e.FirstName,Salary


--Problem27
SELECT TOP 1 * FROM (SELECT t.Name ,COUNT(a.TownID) as [Workers] FROM Employees e
JOIN Addresses a ON a.AddressID=e.AddressID
JOIN Towns t ON t.TownID=a.TownID
GROUP BY t.Name
) c
ORDER BY c.Workers DESC

--Problem28
SELECT e.Name,COUNT(e.EmployeeID) as [Managers] FROM (SELECT DISTINCT z.EmployeeID,z.FirstName ,z.LastName,t.Name FROM Employees z
						JOIN Employees b ON b.ManagerID=z.EmployeeID
						JOIN Addresses a ON z.AddressID=a.AddressID
						JOIN Towns t ON t.TownID=a.TownID
						) e
GROUP BY e.Name
ORDER BY Managers DESC

--Problem29
CREATE TABLE WorkHours(
WorkHoursID	int PRIMARY KEY IDENTITY NOT NULL,
EmployeeID	int FOREIGN KEY REFERENCES Employees(EmployeeID) NOT NULL,
Date datetime NULL,
Task nvarchar(50) NOT NULL,
Hours int NOT NULL,
Comments ntext NULL)
GO

--Problem30
INSERT INTO WorkHours VALUES ('3',GETDATE(),'Piene',10,'Keep walking') 
INSERT INTO WorkHours VALUES ('33',GETDATE(),'Spane',10,'Recharging') 
INSERT INTO WorkHours VALUES ('18',GETDATE(),'Coding',10,'Gotta earn your living ') 



--Problem31
CREATE TABLE WorkHoursLogs(
WorkHoursLogsId int PRIMARY KEY IDENTITY NOT NULL,
Message nvarchar(200) NOT NULL,
ChangeDate datetime NOT NULL
)
GO

CREATE TRIGGER TR_WorkHoursInsert
ON WorkHours
FOR INSERT AS
INSERT INTO WorkHoursLogs VALUES ('A row was added',GETDATE())
GO

CREATE TRIGGER TR_WorkHoursDelete
ON WorkHours
FOR DELETE AS
INSERT INTO WorkHoursLogs VALUES ('A row was deleted',GETDATE())
GO

CREATE TRIGGER TR_WorkHoursUpdated
ON WorkHours
FOR UPDATE AS
INSERT INTO WorkHoursLogs VALUES ('A row was updated',GETDATE())
GO

--Problem 32
BEGIN TRAN
DELETE Employees
WHERE DepartmentID =(SELECT DepartmentID FROM Departments WHERE Name='Sales')
SELECT * FROM Employees e
JOIN Departments d
on e.DepartmentID=d.DepartmentID
WHERE d.Name='Sales'
ROLLBACK TRAN

--Problem 33
BEGIN TRAN
DROP TABLE EmployeesProjects
ROLLBACK TRAN

--Problem34
SELECT * INTO ##TempTableProjects
FROM EmployeesProjects
 
 DROP TABLE EmployeesProjects
 
 CREATE TABLE EmployeesProjects
  (
   EmployeeID INT FOREIGN KEY REFERENCES Employees(EmployeeID) NOT NULL,
   ProjectID INT FOREIGN KEY REFERENCES Projects(ProjectID) NOT NULL,
  )
 
 INSERT INTO EmployeesProjects
 SELECT * FROM  ##TempTableProjects

