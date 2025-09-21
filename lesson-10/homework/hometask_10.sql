-- Lesson-10 Easy-Level Tasks 
--1. Using the Employees and Departments tables, write a query to return the names and salaries of employees whose salary is greater than 50000, along with their department names. Expected Columns: EmployeeName, Salary, DepartmentName
SELECT e.[Name] as EmployeeName, 
	e.Salary,
	d.DepartmentName
FROM Employees e 
INNER JOIN Departments d
ON e.DepartmentID = d.DepartmentID
WHERE e.salary  >50000; --the names and salaries of employees whose salary is greater than 50000, along with their department names.

--2. Using the Customers and Orders tables, write a query to display customer names and order dates for orders placed in the year 2023.
SELECT 
	c.FirstName,
	c.LastName,
	o.OrderDate
FROM Customers c
INNER JOIN Orders o 
	ON c.CustomerID = o.CustomerID
WHERE year(o.OrderDate) = 2023; --query to display customer names and order dates for orders placed in the year 2023.

--3.Using the Employees and Departments tables, write a query to show all employees along with their department names. Include employees who do not belong to any department.--Expected Columns: EmployeeName, DepartmentName
 
 SELECT 
	e.[Name] as EmployeeName,
	d.DepartmentName as DepartmentName
FROM Employees e
LEFT JOIN Departments d
	on e.DepartmentID = d.DepartmentID; --a query to show all employees along with their department names.

--4.Using the Products and Suppliers tables, write a query to list all suppliers and the products they supply.  Show suppliers even if they don’t supply any product.
  
 SELECT 
	s.SupplierName as SupplierName,
	Coalesce(p.ProductName , 'No Product') as ProductName
FROM Suppliers s 
LEFT JOIN Products p
	on s.SupplierID = p.SupplierID; -- a query to list all suppliers and the products they supply.

 --5.Using the Orders and Payments tables, write a query to return all orders and their corresponding payments. Include orders without payments and payments not linked to any order.Expected Columns: OrderID, OrderDate, PaymentDate, Amount
 
 SELECT 
	o.OrderID as OrderID,
	o.OrderDate as OrderDate,
	p.PaymentDate as PaymentDate,
	p.Amount as Amount
FROM Orders o 
FULL Join Payments p
	on o.OrderID = p.OrderID; -- the query to return all orders and their corresponding payments. 
	
--6.Using the Employees table, write a query to show each employee's name along with the name of their manager. Expected Columns: EmployeeName, ManagerName
  
 SELECT 
	e.[Name] AS EmployeeName,
	m.[Name]  AS ManagerName
FROM Employees e
LEFT JOIN Employees m 
ON e.ManagerID = m.EmployeeID
 
 --7.Using the Students, Courses, and Enrollments tables, write a query to list the names of students who are enrolled in the course named 'Math 101'. Expected Columns: StudentName, CourseName
 
SELECT 
	Name as StudentName
	courseName as CourseName
FROM enrollments e
	inner join Students s
		ON e.StudentID = s.StudentID
	inner join Courses c
		ON e.CourseID = c.CourseID
WHERE courseName = 'Math 101'; -- query to list the names of students who are enrolled in the course named 'Math 101

--8.Using the Customers and Orders tables, write a query to find customers who have placed an order with more than 3 items. Return their name and the quantity they ordered. Expected Columns: FirstName, LastName, Quantity
 
SELECT 
	FirstName,
	Lastname, 
	sum(Quantity)
FROM Customers as c
inner join Orders as o
	on c.CustomerID = o.CustomerID
GROUP BY Firstname, LastName 
HAVING sum( Quantity) >3; -- write a query to find customers who have placed an order with more than 3 items.

 --9.Using the Employees and Departments tables, write a query to list employees working in the 'Human Resources' department. Expected Columns: EmployeeName, DepartmentName
 
SELECT 
		[name] as EmployeeName 
		departmentName,		
		 FROM Employees e
INNER JOIN Departments d
	on e.DepartmentID = d.DepartmentID
WHERE DepartmentName = 'Human Resources'; -- query to list employees working in the 'Human Resources' department

--MEDIUM-LEVEL TASKS 

--10.Using the Employees and Departments tables, write a query to return department names that have more than 5 employees. Expected Columns: DepartmentName, EmployeeCount

SELECT 
		DepartmentName,
		count(EmployeeID) as EmployeeCount
FROM departments d
	left join Employees e
		on d.DepartmentID = e.DepartmentID
GROUP BY DepartmentName
HAVING count(EmployeeID)>5

--11.Using the Products and Sales tables, write a query to find products that have never been sold. Expected Columns: ProductID, ProductName

SELECT 
	p.ProductID, 
	p.ProductName
FROM Products AS p
left join Sales AS s
ON p.ProductID = s.ProductID
WHERE s.ProductID is null ; --products that have never been sold. Expected Columns: ProductID, ProductName

--12.Using the Customers and Orders tables, write a query to return customer names who have placed at least one order.
 
SELECT 
	c.FirstName,
	c.LastName,
	count(orderID) as TotalOrders
FROM Customers as c
inner join Orders as o
	ON c.CustomerID = o.CustomerID
	GROUP BY c.FirstName, c.LastName
	HAVING  count(orderID)>=1; --query to return customer names who have placed at least one order.

--13.Using the Employees and Departments tables, write a query to show only those records where both employee and department exist (no NULLs). Expected Columns: EmployeeName, DepartmentName
 
SELECT 
		[name] as EmployeeName,
		DepartmentName
FROM Employees as e
	inner join Departments as d
		on e.departmentID = d.DepartmentID;

--14.Using the Employees table, write a query to find pairs of employees who report to the same manager. Expected Columns: Employee1, Employee2, ManagerID

 SELECT 
    e1.Name AS Employee1,
    e2.Name AS Employee2,
    e1.ManagerID
FROM Employees e1
INNER JOIN Employees e2
    ON e1.ManagerID = e2.ManagerID
    AND e1.EmployeeID < e2.EmployeeID; --chatGPT ishlab berdi
	
--15.Using the Orders and Customers tables, write a query to list all orders placed in 2022 along with the customer name. Expected Columns: OrderID, OrderDate, FirstName, LastName
 
SELECT 
	o.OrderID, 
	o.OrderDate,
	c.FirstName,
	c.LastName
FROM Orders as o
	inner join Customers as c
	on o.CustomerID = c.CustomerID
WHERE year(o.OrderDate) = 2022

--16.Using the Employees and Departments tables, write a query to return employees from the 'Sales' department whose salary is above 60000. Expected Columns: EmployeeName, Salary, DepartmentName
 
SELECT 
	[name] as EmployeeName,
	Salary,
	DepartmentName
FROM Employees as e
	inner join Departments as d
		on e.DepartmentID = d.departmentID
WHERE d.DepartmentName = 'Sales' and Salary>60000;

--17. Using the Orders and Payments tables, write a query to return only those orders that have a corresponding payment. Expected Columns: OrderID, OrderDate, PaymentDate, Amount
 
SELECT 
	o.OrderID,
	o.OrderDate,
	p.PaymentDate,
	p.Amount
FROM Orders as o
	INNER JOIN Payments as p
		ON o.OrderID = p.OrderID

--18.Using the Products and Orders tables, write a query to find products that were never ordered. Expected Columns: ProductID, ProductName
 
SELECT p.ProductID,
	ProductName 
FROM Products as p 
LEFT JOIN Orders as o
	ON p.ProductID = o.ProductID
WHERE o.orderID is null; --query to find products that were never ordered.

--Hard-Level Tasks
--19.Using the Employees table, write a query to find employees whose salary is greater than the average salary in their own departments.  Expected Columns: EmployeeName, Salary
  
SELECT 
		e1.name as employeename,
		e1.salary as salary
FROM Employees e1
WHERE e1.salary>(
		select avg(e2.salary)
		from Employees as e2
		where e1.DepartmentID = e2.DepartmentID); --employees whose salary is greater than the average salary in their own departments.

--20.Using the Orders and Payments tables, write a query to list all orders placed before 2020 that have no corresponding payment. Expected Columns: OrderID, OrderDate
 
SELECT 
	o.OrderID, 
	o.OrderDate
FROM Orders as o
LEFT JOIN Payments as p
	on o.OrderID = p.OrderID
WHERE p.OrderID is null and year(o.OrderDate) <2020; --list all orders placed before 2020 that have no corresponding payment.

--21.Using the Products and Categories tables, write a query to return products that do not have a matching category. Expected Columns: ProductID, ProductName
 SELECT 
		ProductID,
		ProductName
FROM Products as p
LEFT JOIN Categories as c
	ON p.Category = c.CategoryID
WHERE c.CategoryID is null; --query to return products that do not have a matching category

--22. Using the Employees table, write a query to find employees who report to the same manager and earn more than 60000. Expected Columns: Employee1, Employee2, ManagerID, Salary
 
SELECT
		e1.name as Employee1,
		e2.name Employee2,
		e1.ManagerID,
		e1.Salary
FROM Employees as e1
		join Employees as e2
		on e1.ManagerID = e2.ManagerID and e1.EmployeeId< e2.EmployeeID
WHERE e1.Salary> 60000 and e2.Salary>60000

--23 Using the Employees and Departments tables, write a query to return employees who work in departments which name starts with the letter 'M'.  Expected Columns: EmployeeName, DepartmentName

 SELECT 
	emp.name as EmployeeName,
	dep.DepartmentName
FROM Employees as emp
JOIN Departments as dep
	on emp.DepartmentID = Dep.DepartmentID
WHERE DepartmentName  LIKE 'M%'; --query to return employees who work in departments which name starts with the letter 'M'.

--24 Using the Products and Sales tables, write a query to list sales where the amount is greater than 500, including product names. Expected Columns: SaleID, ProductName, SaleAmount
 
SELECT 
	s.SaleID,
	p.ProductName,
	s.SaleAmount
FROM Products AS p
JOIN Sales AS s
	ON p.ProductID = s.ProductID
WHERE s.SaleAmount>500; --query to list sales where the amount is greater than 500, including product names.

--26 Using the Students, Courses, and Enrollments tables, write a query to find students who have not enrolled in the course 'Math 101'.  Expected Columns: StudentID, StudentName
 
SELECT
	s.StudentID,
	s.Name as StudentName,
	c.CourseName
FROM students as s
LEFT JOIN enrollments as e
	on s.StudentID = e.StudentID
LEFT JOIN  Courses as c
	on e.CourseID = c.CourseID
AND  CourseName = 'Math 101'
WHERE c.CourseId is null


--27  Using the Orders and Payments tables, write a query to return orders that are missing payment details. Expected Columns: OrderID, OrderDate, PaymentID
 
SELECT *
FROM Orders as o
LEFT JOIN Payments as p 
	on o.OrderID = p.OrderID
WHERE p.OrderID is NULL; --query to return orders that are missing payment details.

--28 Using the Products and Categories tables, write a query to list products that belong to either the 'Electronics' or 'Furniture' category. Expected Columns: ProductID, ProductName, CategoryName
 
SELECT  *
FROM Products as p
join Categories as c
	on p.Category = c.CategoryID
WHERE c.CategoryName in('Electronics', 'Furniture'); --products that belong to either the 'Electronics' or 'Furniture' category
 -----------------------------------------------------------------------------------------------------------------------------------------------------------------------


















