--Easy-Level Tasks 
--Write a query to find the minimum (MIN) price of a product in the Products table.
SELECT min(Price) AS MinPrice 
FROM Products; --Wrote a query to find the minimum (MIN) price of a product in the Products table.

--Write a query to find the maximum (MAX) Salary from the Employees table.
SELECT max(Salary) AS MaxSalary
FROM Employees; --Wrote a query to find the maximum (MAX) Salary from the Employees table

--Write a query to count the number of rows in the Customers table.
SELECT count(*)  AS row_cnt 
FROM Customers; --Wrote a query to count the number of rows in the Customers table

--Write a query to count the number of unique product categories from the Products table.
SELECT count(DISTINCT category) AS DiscCntCategory 
FROM Products; --Wrote a query to count the number of unique product categories from the Products table

--Write a query to find the total sales amount for the product with id 7 in the Sales table.
SELECT sum(SaleAmount) as TotalSales
FROM Sales
WHERE ProductID = 7; --Wrote a query to find the total sales amount for the product with id 7 in the Sales table.

--Write a query to calculate the average age of employees in the Employees table.
 SELECT avg(age) 
 FROM Employees; --Wrote a query to calculate the average age of employees in the Employees table.

--Write a query to count the number of employees in each department.
 SELECT DepartmentName, 
       COUNT(EmployeeID) AS EmployeeCount
FROM Employees 
GROUP BY DepartmentName;--Wrote a query to count the number of employees in each department.


--Write a query to show the minimum and maximum Price of products grouped by Category. Use products table.
SELECT Category, 
			min(Price) AS MinPrice, 
			max(Price) AS MaxPrice 
FROM Products
GROUP BY Category; --Write a query to show the minimum and maximum Price of products grouped by Category

--Write a query to calculate the total sales per Customer in the Sales table.
 SELECT CustomerID, sum(SaleAmount) AS Total_Amount
FROM Sales GROUP BY CustomerID; --Wrote a query to calculate the total sales per Customer in the Sales table.

--Write a query to filter departments having more than 5 employees from the Employees table. (DeptID is enough, if you don't have DeptName).
SELECT DepartmentName, count(EmployeeID) AS DepartBoySoni
FROM Employees
GROUP BY DepartmentName
HAVING count(EmployeeID)>5; --Wrote a query to filter departments having more than 5 employees from the Employees table

--Medium-Level Tasks
 
--Write a query to calculate the total sales and average sales for each product category from the Sales table.
 SELECT 
    p.Category, 
    SUM(s.SaleAmount) AS TotalSales,
    AVG(s.SaleAmount) AS AvgSales
FROM Sales s
JOIN Products p 
    ON s.ProductID = p.ProductID
GROUP BY p.Category; --Wrote a query to calculate the total sales and average sales for each product category from the Sales table

--Write a query to count the number of employees from the Department HR.
SELECT DepartmentName, count(EmployeeID) AS NumberEmp
FROM Employees
WHERE DepartmentName = 'HR'
GROUP BY DepartmentName 
 
 SELECT COUNT(*) AS NumberEmp 
 FROM Employees 
 WHERE DepartmentName = 'HR';

--Write a query that finds the highest and lowest Salary by department in the Employees table.(DeptID is enough, if you don't have DeptName).
SELECT DepartmentName
		, min(Salary) AS MinSalary
		, max(salary) AS MaxSalary
FROM Employees
GROUP BY DepartmentName

--Write a query to calculate the average salary per Department.(DeptID is enough, if you don't have DeptName).
 
SELECT DepartmentName, avg(Salary) AS avg_Salary_Dprt 
FROM Employees
GROUP BY DepartmentName;--Wrote a query to calculate the average salary per Department.
select * from Employees
--Write a query to show the AVG salary and COUNT(*) of employees working in each department.(DeptID is enough, if you don't have DeptName).
SELECT DepartmentName, 
		count(EmployeeID) as Cnt_Emp, 
		avg(Salary) AS avg_Salary_Dprt 
FROM Employees
GROUP BY DepartmentName; --Wrote a query to show the AVG salary and COUNT(*) of employees working in each department.

--Write a query to filter product categories with an average price greater than 400.
 
SELECT 
	Category
	,avg(price) as avg_price
FROM Products
GROUP BY Category
HAVING avg(price)>400; --Wrote a query to filter product categories with an average price greater than 400.

--Write a query that calculates the total sales for each year in the Sales table.
SELECT 
	year(SaleDate) AS YearSale,
	sum (SaleAmount) AS SumSale
FROM Sales
GROUP BY year(SaleDate)
 
--Write a query to show the list of customers who placed at least 3 orders.

SELECT CustomerID
				, count(OrderID) as SumOrders
FROM Orders
GROUP BY CustomerID
HAVING count(OrderID)>=3;

--Write a query to filter out Departments with average salary expenses greater than 60000.
--(DeptID is enough, if you don't have DeptName).
 
SELECT
		DepartmentName,
		avg(salary) as AvgSalary
FROM Employees
GROUP BY DepartmentName
HAVING avg(salary)>60000; --Wrote a query to filter out Departments with average salary expenses greater than 60000.

--Hard-Level Tasks 
--Write a query that shows the average price for each product category, 
--and then filter categories with an average price greater than 150.
SELECT 
	Category
	,avg(Price)  AS avg_Price
FROM Products
GROUP BY Category
HAVING avg(price)>150;

--Write a query to calculate the total sales for each Customer, then filter the results to include only Customers with total sales over 1500.
SELECT CustomerID
				, sum(SaleAmount) as Total_Sales
FROM Sales
GROUP BY CustomerID
HAVING sum(SaleAmount)>1500--Wrote a query to calculate the total sales for each Customer, then filter the results to include only Customers with total sales over 1500.

--Write a query to find the total and average salary of employees in each department, and filter the output to include only departments with an average salary greater than 65000.
 SELECT DepartmentName
			,sum(salary) as total_salary
			,avg(salary) as avg_salary
FROM Employees
GROUP BY DepartmentName
HAVING avg(salary) >65000; --Wrote a query to find the total and average salary of employees in each department, and filter the output to include only departments with an average salary greater than 65000.

--Write a query to find total amount for the orders which weights more than $50 for each customer 
--along with their least purchases.
--(least amount might be lower than 50, use tsql2012.sales.orders table,
--freight col, ask ur assistant to give the TSQL2012 database).
 
SELECT 
    custid,
    SUM(CASE WHEN freight > 50 THEN freight ELSE 0 END) AS Total_Over50,
    MIN(freight) AS Least_Purchase
FROM Sales.Orders
GROUP BY custid;--Write a query to find total amount for the orders which weights more than $50 for each customer along with their least purchases.


--Write a query that calculates the total sales and counts unique products sold in each month of each year, 
--and then filter the months with at least 2 products sold.(Orders)
 
-- Calculate total sales and count of unique products per month and year
SELECT 
    YEAR(OrderDate) AS SaleYear,
    MONTH(OrderDate) AS SaleMonth,
    SUM(TotalAmount) AS TotalSales,
    COUNT(DISTINCT ProductID) AS DistinctProducts
FROM Orders
GROUP BY YEAR(OrderDate), MONTH(OrderDate)
HAVING COUNT(DISTINCT ProductID) >= 2
ORDER BY SaleYear, SaleMonth; -- Calculated total sales and count of unique products per month and year

--Write a query to find the MIN and MAX order quantity per Year. From orders table.
SELECT 
	year(Orderdate)
	,min(quantity) as min_quantity
	,max(quantity) as max_quantity
FROM Orders
GROUP BY year(OrderDate); --Wrote a query to find the MIN and MAX order quantity per Year.