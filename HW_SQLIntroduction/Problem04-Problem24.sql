
-- highlight the current query ,hit F5 ,enjoy :P


--Problem04
SELECT * FROM Departments 

--Problem05
SELECT Name as [Department Name]  FROM Departments

--Problem06
SELECT FirstName+' '+LastName as FullName,Salary FROM Employees

--Problem07
SELECT FirstName+' '+LastName as FullName FROM Employees

--Problem08
SELECT FirstName+' '+LastName as FullName,FirstName +'.'+LastName+'@softuni.bg' as [Full Email Addresses] FROM Employees

--Problem09
SELECT DISTINCT Salary FROM Employees

--Probem10
SELECT FirstName,LastName FROM Employees
WHERE JobTitle='Sales Representative'

--Problem11
SELECT FirstName,LastName FROM Employees
WHERE FirstName LIKE 'SA%'

--Problem12
SELECT FirstName,LastName FROM Employees
WHERE LastName LIKE '%ei%'

--Problem13
SELECT FirstName,LastName,Salary from Employees
WHERE Salary BETWEEN 20000 AND 30000

--Problem14
SELECT FirstName,LastName,Salary from Employees
WHERE Salary IN (25000,14000,12500,23600)

--Problem15
SELECT FirstName,LastName from Employees
WHERE ManagerID is NULL

--Problem16
SELECT FirstName,LastName,Salary from Employees 
WHERE Salary>50000
ORDER BY Salary DESC

--Problem17
SELECT TOP 5 FirstName, LastName, Salary from Employees
ORDER BY Salary DESC

--Problem18
SELECT e.FirstName, e.LastName , a.AddressText as [Current Address], t.Name as [Town] from	Employees e
JOIN Addresses a
ON e.AddressID=a.AddressID
JOIN Towns t
ON a.TownID=t.TownID

--Problem19
SELECT e.FirstName, e.LastName , a.AddressText as [Current Address], t.Name as [Town]
FROM Employees e,Addresses a, Towns t
WHERE e.AddressID=a.AddressID AND a.TownID=t.TownID

--Problem20
SELECT e.FirstName,e.LastName , m.Firstname +' '+ m.LastName as [Manager] From Employees e
JOIN Employees m
ON e.ManagerID=m.EmployeeID

--Problem21
SELECT e.FirstName,e.LastName , m.Firstname +' '+ m.LastName as [Manager],a.AddressText as [Address] From Employees e
JOIN Employees m
ON e.ManagerID=m.EmployeeID
JOIN Addresses a
ON e.AddressID=a.AddressID

--Problem22
SELECT Name FROM Departments
UNION
SELECT Name FROM Towns

--Problem23
SELECT e.FirstName,e.LastName , m.Firstname +' '+ m.LastName as [Manager] From Employees e
LEFT OUTER JOIN Employees m
ON e.ManagerID=m.EmployeeID 

--Problem24
SELECT e.FirstName , e.LastName ,d.Name as [Department],e.HireDate FROM Employees e
JOIN Departments d
ON e.DepartmentID=d.DepartmentID
WHERE d.Name IN ('Sales','Finance') AND (e.HireDate BETWEEN '1995' AND '2005')
   

