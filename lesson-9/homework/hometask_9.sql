--Easy-Level Tasks 
--Using Products, Suppliers table List all combinations of product names and supplier names.
SELECT 
   		 ProductName
		,SupplierName 
FROM Products p  CROSS JOIN Suppliers s; --List all combinations of product names and supplier names.
  
--Using Departments, Employees table Get all combinations of departments and employees.
SELECT * 
FROM Departments  CROSS JOIN Employees ; --all combinations of departments and employees.

--Using Products, Suppliers table List only the combinations where the supplier actually supplies the product. Return supplier name and product name 
SELECT
	SupplierName AS YetkazibBeruchiNomi,
	ProductName AS YetkazilganMahsulotNomi
FROM Products p
INNER JOIN Suppliers s
	ON p.SupplierID = s.SupplierID; --List only the combinations where the supplier actually supplies the product. 

--Using Orders, Customers table List customer names and their orders ID. 
SELECT 
	c.Firstname, 
	o.orderID
FROM Orders o  
INNER JOIN Customers c
	ON o.customerID=c.customerID; --List customer names and their orders ID

--Using Courses, Students table Get all combinations of students and courses.
SELECT * 
FROM Courses cross join Students; -- all combinations of students and courses.

--Using Products, Orders table Get product names and orders where product IDs match.
SELECT
	ProductName, 
	orderID 
FROM Products p 
INNER JOIN Orders o
ON p.ProductID = o.ProductID; --product names and orders where product IDs match

--Using Departments, Employees table List employees whose DepartmentID matches the department.  
SELECT * 
FROM Departments d 
INNER JOIN Employees e
	ON d.DepartmentID = e.DepartmentID; --List employees whose DepartmentID matches the department.

--Using Students, Enrollments table List student names and their enrolled course IDs.
SELECT 
	[Name] AS TalabalarIsmi,
	EnrollmentID AS  [RoyhatdanO''tganKursi]
FROM Students s 
INNER JOIN Enrollments e
ON s.StudentID = e.StudentID

--Using Payments, Orders table List all orders that have matching payments.
SELECT * 
FROM Payments p 
INNER JOIN Orders o 
	ON p.OrderID=o.OrderID

--Using Orders, Products table Show orders where product price is more than 100.
 SELECT 
	orderID AS Buyurtma, 
	ProductName AS Mahsulot,
	Price AS MahsulotNarxi
FROM Orders o 
INNER JOIN Products p
	ON o.ProductID = p.ProductID
WHERE p.price>100; --orders where product price is more than 100.

--Medium
--Using Employees, Departments table List employee names and department names where department IDs are not equal. It means: Show all mismatched employee-department combinations.
  
SELECT 
	[Name] AS UnmatchingName,
	DepartmentName,
	e.DepartmentID
FROM Employees e 
LEFT JOIN Departments d
	ON e.DEpartmentID = d.DepartmentID
WHERE d.DepartmentID is null -- use case Anti-left join. 
 

--Using Orders, Products table Show orders where ordered quantity is greater than stock quantity.
 
SELECT 
	o.OrderID, 
	p.ProductName,
	o.Quantity,
	p.StockQuantity
FROM Orders o 
JOIN Products p
	ON o.ProductID = p.ProductID
WHERE o.quantity>p.Stockquantity

--Using Customers, Sales table List customer names and product IDs where sale amount is 500 or more.
SELECT
	c.CustomerID,
	FirstName,
	ProductID, 
	SaleAmount
FROM Customers c
INNER JOIN Sales s
	ON c.CustomerID = s.CustomerID
WHERE s.SaleAmount>500; --List customer names and product IDs where sale amount is 500 or more.

--Using Courses, Enrollments, Students table List student names and course names they’re enrolled in.
 SELECT 
	[name],
	CourseName 
FROM Enrollments e
INNER JOIN Courses c
	ON e.courseID = c.courseID 
INNER JOIN Students s
 	ON e.studentID = s.studentID; --List student names and course names they’re enrolled in.

--Using Products, Suppliers table List product and supplier names where supplier name contains “Tech”.
select 
	ProductName,
	SupplierName
from Products p
inner join Suppliers s
on p.SupplierID = s.SupplierID
where lower(SupplierName) like '%tech%'; --List product and supplier names where supplier name contains “Tech”

--Using Orders, Payments table Show orders where payment amount is less than total amount.
 SELECT * FROM Orders
SELECT * FROM Payments
 
SELECT 
    p.OrderID,
    p.Amount AS PaymentAmount,
    o.TotalAmount AS TotalAmount
FROM Orders o
INNER JOIN Payments p
    ON o.OrderID = p.OrderID
WHERE p.Amount < o.TotalAmount; --that orders where payment amount is less than total amount.

--Using Employees and Departments tables, get the Department Name for each employee.
 select * from Employees
select * from Departments
select 
	e.Name, 
	d.DepartmentName
from Employees e
inner join Departments d
	on e.DepartmentID = d.DepartmentID; --Department Name for each employee

--Using Products, Categories table Show products where category is either 'Electronics' or 'Furniture'.
--Mahsulotlardan foydalanish, Kategoriyalar jadvali Kategoriyasi "Elektronika" yoki "Mebel" bo'lgan mahsulotlarni ko'rsating.
SELECT 
    p.ProductName,
    c.CategoryName
FROM Products p
INNER JOIN Categories c
    ON p.CategoryID = c.CategoryID
WHERE c.CategoryName IN ('Electronics', 'Furniture');

--Using Sales, Customers table Show all sales from customers who are from 'USA'.
SELECT c.CustomerID,
		SaleDate,
		SaleAmount,
		FirstName,
		City,
		Country
FROM Sales s 
INNER JOIN Customers c
ON s.CustomerID = c.CustomerID
WHERE country  = 'USA';--all sales from customers who are from 'USA'

--Using Orders, Customers table List orders made by customers from 'Germany' and order total > 100.
 SELECT 
	o.orderID,
	c.CustomerID,
	Firstname,
	city,
	country, 
	TotalAmount
FROM Orders o
INNER JOIN Customers c
	ON o.CustomerID = c.CustomerID
WHERE country = 'Germany' and o.TotalAmount>100;

--Hard 
--Using Employees table List all pairs of employees from different departments.
  SELECT e1.EmployeeID AS Emp1, e1.[name] AS EmpName1,
			e2.EmployeeID AS Emp2, e2.[name] AS EmpName2,
			e1.DepartmentID AS Dept1, e2.DepartmentID AS Dept2
FROM Employees e1
JOIN Employees e2
ON e1.EmployeeID < e2.employeeID 
AND e1.EmployeeID <> e2.EmployeeID;--List all pairs of employees from different departments.

--Using Payments, Orders, Products table 
--List payment details where the paid amount is not equal to (Quantity × Product Price).
--  To'langan summa teng bo'lmagan to'lov tafsilotlari ro'yxati (Miqdor × Mahsulot narxi).
 SELECT p.paymentID, o.orderID, pp.ProductName, o.quantity, pp.price,
       p.amount AS PaidAmount,
       (o.quantity * pp.price) AS ExpectedAmount
FROM Payments p
INNER JOIN Orders o ON p.orderID = o.orderID
JOIN Products pp ON o.ProductID = pp.ProductID
WHERE p.amount <> (o.quantity * pp.price);

--Using Students, Enrollments, Courses table Find students who are not enrolled in any course.
 
SELECT [name] 
FROM Students s
LEFT JOIN Enrollments e
ON s.studentID = e.studentID
WHERE e.studentID  is null

--Using Employees table List employees who are managers of someone, but their salary is less than or equal to the person they manage.
-- shunday  menejerki,  maoshi ular boshqaradigan odamning maoshidan kam
--yoki unga teng bo'lgan xodimlarni ro'yxati.
 
SELECT DISTINCT m.EmployeeID, m.Name, m.Salary AS ManagerSalary
FROM Employees m
JOIN Employees e
    ON e.ManagerID = m.EmployeeID
WHERE m.Salary <= e.Salary;
 
--Using Orders, Payments, Customers table List customers who have made an order, 
--but no payment has been recorded for it.
--Buyurtmalar, to'lovlar, mijozlar jadvalidan foydalanish 
--Buyurtma bergan, ammo buning uchun to'lov qayd etilmagan mijozlar ro'yxati.
 SELECT o.CustomerID, o.OrderID, p.Amount
FROM Orders o
LEFT JOIN Payments p
	ON o.OrderID = p.OrderID
WHERE p.orderID is NULL; --List customers who have made an order, 
--but no payment has been recorded for it.

