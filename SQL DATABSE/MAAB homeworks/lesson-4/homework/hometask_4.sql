--Easy-Level Tasks (10)
--Write a query to select the top 5 employees from the Employees table.
 SELECT TOP 5 * FROM [HumanResources].[Employee] --selected the top 5 employees from the Employees

--Use SELECT DISTINCT to select unique Category values from the Products table.
SELECT DISTINCT Category 
FROM Products;--Used SELECT DISTINCT to select unique Category values from the Products table

--Write a query that filters the Products table to show products with Price > 100.
SELECT * FROM Products 
WHERE Price> 100;--Writed a query that filters the Products table to show products with Price > 100.

--Write a query to select all Customers whose FirstName start with 'A' using the LIKE operator.
SELECT * FROM Customers 
WHERE firstname like 'A%';--Wrote a query to select all Customers whose FirstName start with 'A' using the LIKE operator.

--Order the results of a Products table by Price in ascending order.
SELECT * 
FROM Products 
ORDER BY Price ASC;--Ordered the results of a Products table by Price in ascending order.

--Write a query that uses the WHERE clause to filter for employees with Salary >= 60000 and Department = 'HR'.
SELECT * FROM Employees 
WHERE Salary >=60000 and DepartmentName = 'HR';--Wrote a query that uses the WHERE clause to filter for employees with Salary >= 60000 and Department = 'HR'.

--Use ISNULL to replace NULL values in the Email column with the text "noemail@example.com".From Employees table
SELECT isnull(Email, 'nomail@example.com') AS Email_status FROM Employees; --Bu query Employees jadvalidan barcha email’larni chiqaradi, agar Email ustuni NULL bo‘lsa, uni "noemail@example.com" ga almashtiradi.

--Write a query that shows all products with Price BETWEEN 50 AND 100.
SELECT * FROM Products WHERE price between 50 and 100; -- Bu query Products jadvalidagi barcha satrlarni chiqaradi, faqat Price ustunidagi qiymat 50 va 100 oralig‘ida (ikkalasi ham kiritilgan holda) bo‘lsa.

--Use SELECT DISTINCT on two columns (Category and ProductName) in the Products table.
SELECT DISTINCT Category, ProductName FROM Products; --Used SELECT DISTINCT on two columns (Category and ProductName) in the Products table.

--After SELECT DISTINCT on two columns (Category and ProductName) Order the results by ProductName in descending order.
SELECT DISTINCT Category, ProductName FROM Products
ORDER BY ProductName DESC;

--Medium-Level Tasks 

--Write a query to select the top 10 products from the Products table, ordered by Price DESC.
SELECT TOP 10 * FROM Products ORDER BY Price DESC; --Wrote a query to select the top 10 products from the Products table, ordered by Price DESC.

--Use COALESCE to return the first non-NULL value from FirstName or LastName in the Employees table.
SELECT COALESCE(firstname, Lastname) AS Fullname FROM Employees; --Used COALESCE to return the first non-NULL value from FirstName or LastName in the Employees table.

--Write a query that selects distinct Category and Price from the Products table.
SELECT DISTINCT Category, Price FROM Products; --Wrote a query that selects distinct Category and Price from the Products table.

--Write a query that filters the Employees table to show employees whose Age is either between 30 and 40 or Department = 'Marketing'.
SELECT * FROM Employees 
WHERE age BETWEEN 30 AND 40 
		OR department ='Marketing'; --Wrote a query that filters the Employees table to show employees whose Age is either between 30 and 40 or Department = 'Marketing'.
 
--Use OFFSET-FETCH to select rows 11 to 20 from the Employees table, ordered by Salary DESC.
 
SELECT *  
FROM Employees 
ORDER BY Salary DESC
OFFSET 10 ROWS 
FETCH NEXT 10 ROWS ONLY; --Used OFFSET-FETCH to select rows 11 to 20 from the Employees table, ordered by Salary DESC.

--Write a query to display all products with Price <= 1000 and Stock > 50, sorted by Stock in ascending order.
SELECT * FROM Products 
WHERE Price <=1000 AND Stock >50 
ORDER BY Stock ASC; --Wrote a query to display all products with Price <= 1000 and Stock > 50, sorted by Stock in ascending order.

--Write a query that filters the Products table for ProductName values containing the letter 'e' using LIKE.
SELECT * FROM Products 
WHERE ProductName LIKE '%e%'; --Wrote a query that filters the Products table for ProductName values containing the letter 'e' using LIKE.

--Use IN operator to filter for employees who work in either 'HR', 'IT', or 'Finance'.
SELECT * FROM Employees WHERE Department IN ('HR', 'IT', 'FINANCE'); --Used IN operator to filter for employees who work in either 'HR', 'IT', or 'Finance'.

--Use ORDER BY to display a list of customers ordered by City in ascending and PostalCode in descending order.Use customers table
SELECT * FROM Customers 
ORDER BY CITY ASC, PostalCode DESC; --Used ORDER BY to display a list of customers ordered by City in ascending and PostalCode in descending order.Use customers table
 
 --Hard-Level Tasks

--Write a query that selects the top 5 products with the highest sales, using TOP(5) and ordered by SaleAmount DESC.
 
SELECT  TOP 5 * FROM Sales ORDER BY SaleAmount DESC; --Wrote a query that selects the top 5 products with the highest sales, using TOP(5) and ordered by SaleAmount DESC.
 
--Combine FirstName and LastName into one column named FullName in the Employees table. (only in select statement)
SELECT * ,
CASE WHEN firstname is not NULL and lastname is not null THEN  firstname + ' '+lastname
		 WHEN firstname is NULL and lastname is not null THEN  lastname 
		 WHEN firstname is not NULL and lastname is NULL THEN firstname
		 ELSE 'Unknown' END AS Fullname
FROM Employees; --Combined FirstName and LastName into one column named FullName in the Employees table.

SELECT *,
    COALESCE(CONCAT_WS(' ', firstname, lastname), 'Unknown') AS Fullname
FROM Employees; --Combined FirstName and LastName into one column named FullName in the Employees table.

--Write a query to select the distinct Category, ProductName, and Price for products that are priced above $50, using DISTINCT on three columns.
SELECT DISTINCT Category, ProductName, Price 
FROM Products 
WHERE price >50 
ORDER BY price DESC; --Wrote a query to select the distinct Category, ProductName, and Price for products that are priced above $50, using DISTINCT on three columns.

--Write a query that selects products whose Price is less than 10% of the average price in the Products table. (Do some research on how to find average price of all products)
SELECT * FROM Products 
SELECT ProductID
	,ProductName
	,Price
	,Category
	,StockQuantity
FROM Products
WHERE Price< (SELECT AVG(Price)*0.1 FROM Products); --Wrote a query that selects products whose Price is less than 10% of the average price in the Products table.
	
--Use WHERE clause to filter for employees whose Age is less than 30 and who work in either the 'HR' or 'IT' department.
SELECT * FROM Employees
WHERE age <30 and DepartmentName  in('HR', 'IT'); --Used WHERE clause to filter for employees whose Age is less than 30 and who work in either the 'HR' or 'IT' department.

--Use LIKE with wildcard to select all customers whose Email contains the domain '@gmail.com'.
SELECT * FROM Customers
WHERE Email like '%@gmail.com'; --Used LIKE with wildcard to select all customers whose Email contains the domain '@gmail.com'.

--Write a query that uses the ALL operator to find employees whose salary is greater than all employees in the 'Sales' department.
SELECT * FROM Employees 
WHERE Salary > ALL (SELECT Salary FROM Employees WHERE DepartmentName = 'Sales');--Wrote a query that uses the ALL operator to find employees whose salary is greater than all employees in the 'Sales' department.

--Write a query that filters the Orders table for orders placed in the last 180 days using BETWEEN and LATEST_DATE in the table. (Search how to get the current date and latest date)
SELECT * 
FROM Orders 
WHERE OrderDate 
between DATEADD(day, -180, getdate()) 
and (SELECT max(OrderDate) from ORDERS); --Wrote a query that filters the Orders table for orders placed in the last 180 days using BETWEEN and LATEST_DATE in the table
 
  
