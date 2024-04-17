CREATE DATABASE Restoran
USE Restoran

CREATE TABLE Meals
(
Id INT PRIMARY KEY IDENTITY,
[Name] NVARCHAR(255),
Price DECIMAL(3,1)
)

CREATE TABLE Tables
(
Id INT PRIMARY KEY IDENTITY,
[No] NVARCHAR(15)
)

CREATE TABLE Orders
(
Id INT PRIMARY KEY IDENTITY,
MealId INT FOREIGN KEY REFERENCES Meals(Id),
TableId INT FOREIGN KEY REFERENCES Tables(Id),
CreatedDate DATETIME
)


----1----
SELECT t.*, (SELECT COUNT(*) FROM Orders o WHERE o.TableId=t.Id) FROM Tables t 


----2----
SELECT m.*, (SELECT COUNT(*) FROM Orders o WHERE o.MealId=m.Id) FROM Meals m


----3----
SELECT o.*, m.Name  FROM Orders o
JOIN Meals m ON m.Id=o.MealId


----4----
SELECT o.*, m.Name, t.No  FROM Orders o
JOIN Meals m ON m.Id=o.MealId
JOIN Tables t ON t.Id=o.TableId


----5----
SELECT t.[No], SUM(m.Price) FROM Tables t
JOIN Orders o ON o.TableId=t.Id
JOIN Meals m ON m.Id=t.Id
GROUP BY t.[No]


----6----
SELECT DATEDIFF(hour, MIN(CreatedDate), MAX(CreatedDate)) FROM Orders o WHERE o.TableId=1


----7----
SELECT * FROM Orders o WHERE CreatedDate >=DATEADD(minute, -30, GETDATE())


----8----
SELECT * FROM Tables t
WHERE NOT EXISTS
(SELECT * FROM Orders o WHERE o.TableId=t.Id)


----9----
SELECT * FROM Tables t
WHERE NOT EXISTS
(SELECT * FROM Orders o WHERE o.TableId=t.Id AND CreatedDate>=DATEADD(minute, -60, GETDATE()))















