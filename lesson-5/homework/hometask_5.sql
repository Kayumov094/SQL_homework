-- Easy-Level Tasks
--Write a query that uses an alias to rename the ProductName column as Name in the Products table.
SELECT ProductName AS [Name]
FROM Products; --Wrote a query that uses an alias to rename the ProductName column as Name in the Products table.

--Write a query that uses an alias to rename the Customers table as Client for easier reference.
SELECT * FROM Customers AS Client 
WHERE country = 'USA'; --Wrote a query that uses an alias to rename the Customers table as Client for easier reference.

--Use UNION to combine results from two queries that select ProductName from Products and ProductName from Products_Discounted.
SELECT ProductName 
FROM  Products
		UNION	
SELECT ProductName 
FROM Products_Discounted; --Used UNION to combine results from two queries that select ProductName from Products and ProductName from Products_Discounted.

--Write a query to find the intersection of Products and Products_Discounted tables using INTERSECT.
SELECT * FROM Products
INTERSECT
SELECT * FROM Products_Discounted; --Wrote a query to find the intersection of Products and Products_Discounted tables using INTERSECT.

--Write a query to select distinct customer names and their corresponding Country using SELECT DISTINCT.
SELECT DISTINCT FirstName, country from Customers; --Wrote a query to select distinct customer names and their corresponding Country using SELECT DISTINCT.

--Write a query that uses CASE to create a conditional column that displays 'High' if Price > 1000, and 'Low' if Price <= 1000 from Products table.
SELECT *,
	CASE 
		WHEN Price>1000 THEN 'High'
		WHEN Price<= 1000 THEN 'Low'
	ELSE 'Unknown' END AS status_price 
FROM Products
ORDER BY status_price; --Wrote a query that uses CASE to create a conditional column that displays 'High' if Price > 1000, and 'Low' if Price <= 1000 from Products table.

--Use IIF to create a column that shows 'Yes' if Stock > 100, and 'No' otherwise (Products_Discounted table, StockQuantity column).
SELECT *,
		IIF(StockQuantity>100, 'Yes',  'No') 
AS StockQuantity_status
FROM Products_Discounted
ORDER BY StockQuantity_status;  --Used IIF to create a column that shows 'Yes' if Stock > 100, and 'No' otherwise (Products_Discounted table, StockQuantity column).


--Medium-Level Tasks

--Use UNION to combine results from two queries that select ProductName from Products and ProductName from Products_Discounted tables.
SELECT ProductName FROM Products 
UNION
SELECT ProductName FROM Products_Discounted; --Use UNION to combine results from two queries that select ProductName from Products and ProductName from Products_Discounted tables.

--Write a query that returns the difference between the Products and Products_Discounted tables using EXCEPT.
SELECT * FROM Products 
EXCEPT 
SELECT * FROM Products_Discounted; --Wrote a query that returns the difference between the Products and Products_Discounted tables using EXCEPT

--Create a conditional column using IIF that shows 'Expensive' if the Price is greater than 1000, and 'Affordable' if less, from Products table.
SELECT *,
IIF(Price>1000, 'Expensive', 'Affordable') AS Price_status
FROM Products; --Created a conditional column using IIF that shows 'Expensive' if the Price is greater than 1000, and 'Affordable' if less, from Products table.

--Write a query to find employees in the Employees table who have either Age < 25 or Salary > 60000.
SELECT * FROM Employees
WHERE Age<25 or Salary > 60000; --Wrote a query to find employees in the Employees table who have either Age < 25 or Salary > 60000.

--Update the salary of an employee based on their department,  increase by 10% if they work in 'HR' or EmployeeID = 5
 UPDATE Employees
 SET salary = salary*1.1 
 WHERE EmployeeID = 5 or DepartmentName = 'HR'; --Updated the salary of an employee based on their department,  increase by 10% if they work in 'HR' or EmployeeID = 5

-- Hard-Level Tasks
--Write a query that uses CASE to assign 'Top Tier' if SaleAmount > 500, 'Mid Tier' if SaleAmount BETWEEN 200 AND 500, and 'Low Tier' otherwise. (From Sales table)
SELECT *,
CASE 
WHEN SaleAmount > 500 THEN 'Top Tier'
WHEN SaleAmount BETWEEN 200 AND 500 THEN 'Mid Tier'
ELSE 'Low Tier' END AS SaleAmount_status
FROM Sales; --Wrote a query that uses CASE to assign 'Top Tier' if SaleAmount > 500, 'Mid Tier' if SaleAmount BETWEEN 200 AND 500, and 'Low Tier' otherwise.

--Use EXCEPT to find customers' ID who have placed orders but do not have a corresponding record in the Sales table.
SELECT CustomerID 
FROM Orders
EXCEPT
SELECT CustomerID 
FROM Sales ; --Used EXCEPT to find customers' ID who have placed orders but do not have a corresponding record in the Sales table

--Write a query that uses a CASE statement to determine the discount percentage based on the quantity purchased. Use orders table. Result set should show customerid, quantity and discount percentage. The discount should be applied as follows: 1 item: 3% Between 1 and 3 items : 5% Otherwise: 7%
 
SELECT *,
	CASE 
		WHEN Quantity =1 THEN '3%'
		WHEN Quantity between 2 and 3 THEN '5%'
		ELSE '7%' END AS dicount_percentage 
FROM Orders; --Wrote a query that uses a CASE statement