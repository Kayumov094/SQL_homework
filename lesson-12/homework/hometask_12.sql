--1. Combine Two Tables
--Write a solution to report the first name, last name, city, and state of each person in the Person table. 
--If the address of a personId is not present in the Address table, report null instead.
   
SELECT 
	p.FirstName,
	p.Lastname,
	a.city,
	a.state
FROM Person as p
LEFT JOIN Address as a
	on p.personID = a.Personid;

 --2. Employees Earning More Than Their Managers
 --Write a solution to find the employees who earn more than their managers.
 SELECT 
	 e1.name as Employee
FROM Employee as e1
JOIN Employee as e2
	on e1.managerID = e2.id
WHERE e1.Salary > e2.salary

--3. Duplicate Emails
--Write a solution to report all the duplicate emails. Note that it''s guaranteed that the email field is not NULL.
 
SELECT  email 
FROM Persons 
GROUP BY email
HAVING count(email) > 1;

--4. Delete Duplicate Emails
--Write a solution to delete all duplicate emails, keeping only one unique email with the smallest id.
  
DELETE FROM Person
WHERE id NOT IN (
										SELECT MIN(id)
										FROM Person
										GROUP BY email
);

--5. Find those parents who has only girls.
 
SELECT 
	girls.id,
	girls.name,
	girls.Parentname 
FROM girls  
LEFT JOIN boys  
	on girls.ParentName = boys.Parentname 
WHERE boys.id is NULL;

--6. Total over 50 and least
--Find total Sales amount for the orders which weights more than 50 for each customer along with their least weight.
  
select * from [Sales].[Orders]
select * from [Sales].[Customers]
select * from [Sales].[OrderDetails]
SELECT 
	c.CustID,
	sum(od.unitprice * od.qty) as TotalSales,
	min( o.freight) as Minfreight
FROM Sales.Orders as o
JOIN Sales.Customers as c
	on o.custID = c.custID
JOIN Sales.OrderDetails as od
	on o.orderID = od.orderID
WHERE o.freight > 50
GROUP BY c.CustID;

 --7. Carts
 
SELECT * 
FROM Cart1
INNER JOIN Cart2
	on  Cart1.Item = Cart2.Item
UNION ALL
SELECT * 
FROM Cart1
LEFT JOIN Cart2
	on  Cart1.Item = Cart2.Item
WHERE  Cart2.Item is null
 UNION ALL
SELECT *
FROM Cart1
RIGHT JOIN Cart2
	on Cart1.Item = Cart2.Item
WHERE  Cart1.Item is null
 
 --8. Customers Who Never Order
 --Write a solution to find all customers who never order anything.
 
 SELECT
	Customers.Name
 FROM Customers 
 LEFT JOIN orders 
	on Customers.id = Orders.Customerid
 WHERE orders.Customerid is null;

 --9. Students and Examinations
 --Write a solution to find the number of times each student attended each exam.
 --Har bir talaba har bir imtihonga necha marta kelganini topish uchun yechim yozing.
 select * from students
 select * from Subjects
 select * from Examinations
  
	SELECT 
    s.Student_id,
    s.Student_name,
    sub.subject_name,
    COUNT(e.student_id) AS exam_count
FROM Students s
CROSS JOIN Subjects sub
LEFT JOIN Examinations e
    ON s.student_id = e.student_id
   AND sub.subject_name = e.subject_name
GROUP BY 
    s.Student_id,
    s.Student_name,
    sub.subject_name
ORDER BY s.Student_id, sub.subject_name; --ChatGPT ishlab berdi 
