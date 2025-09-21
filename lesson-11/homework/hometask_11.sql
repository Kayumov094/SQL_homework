 sp_tables
--  Easy-Level Tasks (7)
--1. Return: OrderID, CustomerName, OrderDate
--Task: Show all orders placed after 2022 along with the names of the customers who placed them.
--Tables Used: Orders, Customers
 SELECT
	OrderID,
	FirstName as CustomerName,
	OrderDate
FROM Orders as o
JOIN Customers as c
	ON o.CustomerID = c.CustomerID
WHERE Year(OrderDate) > 2022;

--2. Return: EmployeeName, DepartmentName
--Task: Display the names of employees who work in either the Sales or Marketing department.
--Tables Used: Employees, Departments
 SELECT 
	e.Name as EmployeeName,
	d.DepartmentName
FROM Employees as e
JOIN Departments as d
	on e.DepartmentID = d.DepartmentID
WHERE d.DepartmentName in ('Sales', 'Marketing');

--3. Return: DepartmentName, MaxSalary
--Task: Show the highest salary for each department.
--Tables Used: Departments, Employees
SELECT 
	d.DepartmentName,
	MAX(e.Salary) as MaxSalary
FROM Departments as d
JOIN Employees as e
	on d.DepartmentID = e.DepartmentID
GROUP By d.DepartmentName;

--4. Return: CustomerName, OrderID, OrderDate
--Task: List all customers from the USA who placed orders in the year 2023.
--Tables Used: Customers, Orders
SELECT
	c.FirstName as CustomerName,
	o.OrderID,
	o.OrderDate
FROM Customers as c
JOIN Orders as o
	on c.CustomerID = o.CustomerID
WHERE c.Country = 'USA' and Year(o.OrderDate) = 2023

--5. Return: CustomerName, TotalOrders
--Task: Show how many orders each customer has placed.
--Tables Used: Orders , Customers
SELECT 
	c.FirstName as CustomerName,
	count(o.OrderID) as TotalOrders
FROM Orders as o
JOIN Customers as c
	on o.CustomerID = c.CustomerID
GROUP BY c.FirstName;

--6. Return: ProductName, SupplierName
--Task: Display the names of products that are supplied by either Gadget Supplies or Clothing Mart.
--Tables Used: Products, Suppliers
SELECT 
	p.ProductName,
	s.SupplierName
FROM Products as p 
JOIN Suppliers as s
	on p.SupplierID = s.SupplierID
WHERE SupplierName = 'Gadget Supplies' or SupplierName  = 'Clothing Mart';

--7. Return: CustomerName, MostRecentOrderDate
--Task: For each customer, show their most recent order. Include customers who haven't placed any orders.
--Tables Used: Customers, Orders

 SELECT 
	c.FirstName as CustomerName,
	max(OrderDate) as MostRecentOrderDate
FROM Customers as c
LEFT JOIN Orders as o
	on c.CustomerID = o.CustomerID
GROUP BY c.Firstname

--Medium-Level Tasks
--8. Return: CustomerName, OrderTotal
--Task: Show the customers who have placed an order where the total amount is greater than 500.
--Tables Used: Orders, Customers
 SELECT 
	c.FirstName as CustomerName, 
	o.TotalAmount as TotalOrder
FROM Customers as c
JOIN Orders as o
	on c.CustomerID = o.CustomerID
WHERE o.TotalAmount > 500;

--9. Return: ProductName, SaleDate, SaleAmount
--Task: List product sales where the sale was made in 2022 or the sale amount exceeded 400.
--Tables Used: Products, Sales
SELECT 
	p.ProductName,
	s.SaleDate,
	s.SaleAmount
FROM Products as p
inner join Sales as s
	on p.ProductID = s.ProductID
WHERE Year(s.SaleDate) = 2022 or s.SaleAmount>400; 

--10. Return: ProductName, TotalSalesAmount
--Task: Display each product along with the total amount it has been sold for.
--Tables Used: Sales, Products
 SELECT 
	p.ProductName,
	Sum(SaleAmount) as TotalSaleAmount
FROM Products as p 
join Sales as s
	on p.ProductID = s.ProductID
GROUP BY p.ProductName;

--11. Return: EmployeeName, DepartmentName, Salary
--Task: Show the employees who work in the HR department and earn a salary greater than 60000.
--Tables Used: Employees, Departments
 SELECT 
	e.[Name] as EmployeeName,
	d.DepartmentName,
	e.Salary
FROM Employees as e
JOIN Departments as d
	on e.DepartmentID = d.DepartmentID
WHERE d.DepartmentName = 'Human Resources' and e.Salary > 60000;

--12. Return: ProductName, SaleDate, StockQuantity
--Task: List the products that were sold in 2023 and had more than 100 units in stock at the time.
--Tables Used: Products, Sales
 
SELECT
	p.ProductName,
	s.SaleDate,
	p.StockQuantity
FROM Products as p
JOIN Sales as s
	on p.ProductID = s.ProductID
WHERE YEAR(s.SaleDate) =2023 and p.StockQuantity >100;

--13. Return: EmployeeName, DepartmentName, HireDate
--Task: Show employees who either work in the Sales department or were hired after 2020.
--Tables Used: Employees, Departments
 SELECT 
	e.[Name] as EmployeeName,
	d.DepartmentName,
	e.HireDate 
FROM Employees as e
JOIN departments as d
	on e.DepartmentID = d.DepartmentID
WHERE d.DepartmentName = 'Sales' or year(e.HireDate )> 2020;

--Hard-Level Tasks 
--14. Return: CustomerName, OrderID, Address, OrderDate
--Task: List all orders made by customers in the USA whose address starts with 4 digits.
--Tables Used: Customers, Orders
 SELECT
	c.FirstName,
	o.OrderID as OrderCustomer,
	c.Address as AddressCustomer
FROM Orders as o
JOIN Customers as c
	on o.CustomerID = c.CustomerID
WHERE c.Country = 'USA' and c.Address like '[0-9][0-9][0-9][0-9]%';

--Return: ProductName, Category, SaleAmount
--Task: Display product sales for items in the Electronics category or where the sale amount exceeded 350.
--Tables Used: Products, Sales
 SELECT 
	p.ProductName,
	c.CategoryName,
	s.SaleAmount
FROM Products as p
JOIN Sales as s
	on p.ProductID = s.ProductID
JOIN Categories as c
	on p.Category = c.CategoryID
WHERE c.CategoryName = 'Electronics' or s.SaleAmount > 350;


--15. Return: CategoryName, ProductCount
--Task: Show the number of products available in each category.
--Tables Used: Products, Categories
 SELECT 
	c.CategoryName,
	count(p.ProductID) as ProductCount
FROM Products as p
JOIN Categories as c
	on p.Category = c.CategoryID
GROUP BY c.CategoryName;

--16. Return: CustomerName, City, OrderID, Amount
--Task: List orders where the customer is from Los Angeles and the order amount is greater than 300.
--Tables Used: Customers, Orders
 SELECT 
	c.FirstName as CustomerName,
	c.City as City,
	o.OrderID,
	o.TotalAmount as Amount
FROM Orders as o
JOIN Customers as c
	on o.CustomerID = c.CustomerID
WHERE c.City = 'Los Angeles' and o.TotalAmount > 300;

--17.Return: EmployeeName, DepartmentName
--Task: Display employees who are in the HR or Finance department,or whose name contains at least 4 vowels.
--Tables Used: Employees, Departments
 
SELECT 
	e.Name as EmployeeName,
	d.DepartmentName
FROM Employees as e
JOIN Departments as d
	on e.DepartmentID = d.DepartmentID
WHERE d.DepartmentName in ('Human Resources', 'Finance') 
or  (Len(e.name) - len(replace(lower(e.name), 'a', '')))+
	  (Len(e.name) - len(replace(lower(e.name), 'e', '')))+
	  (Len(e.name) - len(replace(lower(e.name), 'u', '')))+
	  (Len(e.name) - len(replace(lower(e.name), 'o', '')))+
	  (Len(e.name) - len(replace(lower(e.name), 'i', '')))>=4;
		
--18. Return: EmployeeName, DepartmentName, Salary
--Task: Show employees who are in the Sales or Marketing department  and have a salary above 60000.
--Tables Used: Employees, Departments
SELECT 
	e.Name as EmployeeName,
	d.DepartmentName,
	e.Salary
FROM Employees as e
JOIN Departments as d
	on e.DepartmentID = d.DepartmentID
WHERE d.DepartmentName in ('Sales', 'Marketing')
	AND e.salary > 60000;

