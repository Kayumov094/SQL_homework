-- Easy Tasks
--1. Create a numbers table using a recursive query from 1 to 1000.
--1 dan 1000 gacha bo'lgan rekursiv so'rov yordamida raqamlar jadvalini yarating.
;WITH cte AS (
SELECT 1 as number, 1 as position
UNION ALL 
SELECT number +1 as number, position +1 as position 
FROM cte 
WHERE position <1000)

SELECT * 
FROM cte 
OPTION (maxrecursion  1000) -- 1 dan 1000 gacha bolgan recursive query 
 
--2. Write a query to find the total sales per employee using a derived table.(Sales, Employees)
  
; WITH cte AS ( 
		SELECT 
		EmployeeID,
		sum(SalesAmount) as TotalAmount
FROM Sales 
GROUP BY EmployeeID)
SELECT 
		FirstName,
		LastName,
		Salary,
		TotalAmount
FROM cte 
	JOIN Employees as e
		ON cte.EmployeeID = e.EmployeeID; --bir xodimga to'g'ri keladigan jami sotishni topish so'rovi

--Create a CTE to find the average salary of employees.(Employees)
  
;WITH cte AS (
SELECT 
	avg(Salary) as AvgSalary
FROM Employees )

SELECT * FROM cte

--Write a query using a derived table to find the highest sales for each product.(Sales, Products)
  
;WITH cte AS (
SELECT 
	ProductID,
	max(SalesAmount) as MaxSalesProduct
FROM Sales 
GROUP BY ProductID)

SELECT 
	p.ProductID,
	ProductName,
	Price,
	MaxSalesProduct
FROM cte c
	JOIN Products p
		ON c.ProductID = p.ProductID

--Beginning at 1, write a statement to double the number for each record, the max value you get should be less than 1000000.
 
;WITH cte AS (
SELECT 1 AS number, 2 AS position 
UNION ALL 
SELECT (number *2 ) as number, position +1 as position 
FROM cte 
WHERE number  <1000000 )

SELECT * FROM cte 
OPTION (maxrecursion 5000)

--Use a CTE to get the names of employees who have made more than 5 sales.(Sales, Employees)
  
;WITH cte AS (
SELECT 
	EmployeeID,
	count(SalesID) AS cntSales
FROM Sales 
GROUP BY EmployeeID
HAVING count(SalesID) >5 )
SELECT 
	FirstName,
	LastName,
	cntSales
FROM cte c
	JOIN Employees e 
		ON c.EmployeeID = e.EmployeeID

--Write a query using a CTE to find all products with sales greater than $500.(Sales, Products)
  
; WITH cte AS (
SELECT 
	ProductID,
	sum(SalesAmount) AS TotalSales
FROM Sales 
GROUP BY ProductID
HAVING  sum(SalesAmount) > 500)
SELECT 
	ProductName,
	Price,
	TotalSales
FROM cte c 
	JOIN Products p
		ON c.ProductID = p.ProductID; --all products with sales greater than $500


--Create a CTE to find employees with salaries above the average salary.(Employees)
 
;WITH cte AS(
SELECT 
		EmployeeID,
		FirstName,
		LastName,
		Salary
FROM employees
WHERE salary >(
								SELECT avg(Salary) FROM Employees))
select * from cte;

;WITH cte AS (
    SELECT AVG(Salary) AS AvgSalary
    FROM Employees
)
SELECT 
    e.EmployeeID,
    e.FirstName,
    e.LastName,
    e.Salary
FROM Employees e
 CROSS JOIN cte
WHERE e.Salary > cte.AvgSalary; --employees with salaries above the average salary.

--Medium Tasks
--1. Write a query using a derived table to find the top 5 employees by the number of orders made.(Employees, Sales)
  
;WITH cte AS (
							SELECT 
							EmployeeID,
							count(SalesID) as CountSales,
							sum(SalesAmount) as SumSales,
							dense_rank() over(order by 	count(SalesID)DESC ) as Rank_sales
							FROM Sales 
							GROUP BY EmployeeID)
SELECT TOP 5
	FirstName,
	LastName,
	Salary,
	CountSales,
	SumSales,
	rank_sales
FROM cte c 
	JOIN employees AS e 
		ON c.EmployeeID = e.EmployeeID; --the top 5 employees by the number of orders made

--2 .Write a query using a derived table to find the sales per product category.(Sales, Products)
--Mahsulot toifasi bo'yicha sotishni topish uchun olingan jadvaldan foydalanib so'rov yozing.(Sotish, Mahsulotlar)

 ;WITH cte AS (
							 SELECT s.SalesID,
							 p.ProductID,
							 p.CategoryID,
							 s.SalesAmount
							 FROM Sales AS s
								 JOIN Products AS p
									ON s.ProductID = p.ProductID)
 
SELECT CategoryID,
	sum(SalesAmount) AS TotalAmount 
FROM cte
GROUP BY CategoryID; --the sales per product category

--Write a script to return the factorial of each value next to it.(Numbers1)
--Uning yonidagi har bir qiymatning faktorialini qaytarish uchun skript yozing.(1-raqam)

;WITH FactorialCTE AS (
    											SELECT 
											Number AS Num,
											CAST(1 AS BIGINT) AS Factorial,
											1 AS Counter
											FROM Numbers1
											UNION ALL
											SELECT 
											f.Num,
											(f.Factorial * (f.Counter + 1)) AS Factorial,
											f.Counter + 1
											FROM FactorialCTE f
											WHERE f.Counter < f.Num)
SELECT 
    Num,
    MAX(Factorial) AS Factorial
FROM FactorialCTE
GROUP BY Num
ORDER BY Num;

 --This script uses recursion to split a string into rows of substrings for each character in the string.(Example)
--Ushbu skript satrni satrdagi har bir belgi uchun pastki qatorlar qatoriga boʻlish uchun rekursiyadan foydalanadi.(Misol)
 
 ;WITH cte as (
						 SELECT id, 
						 cast(substring(string, 1, 1) as VARCHAR(1)) as Character,
						 1 as position,
						 len(string) as stringLength,
						 string
						 FROM example
						 UNION ALL 
						 SELECT 
						 id, 
						 cast(substring(string, position + 1, 1) as VARCHAR(1)) as Character,
						 position +1 as position,
						 StringLength,
						 String
						 FROM cte
						 WHERE position < stringLength)
 SELECT 
	 id, Character, Position 
 FROM cte
 ORDER BY position 
 OPTION (maxrecursion 0)

--Use a CTE to calculate the sales difference between the current month and the previous month.(Sales)
--Joriy oy va oldingi oy o'rtasidagi savdo farqini hisoblash uchun CTE dan foydalaning.(Sotish)
 
;WITH CurrentMonth AS (
												SELECT 
												sum(SalesAmount) as total
												FROM Sales
												WHERE month(SaleDate) = 08),

				PreviousMonth AS (
									SELECT 
									sum(SalesAmount) as PreviousTotal
									FROM Sales 
									WHERE month(SaleDate) = 07)
SELECT 
c.Total - p.PreviousTotal AS differance
FROM CurrentMonth c, PreviousMonth p; --sales difference between the current month and the previous month
 


--Create a derived table to find employees with sales over $45000 in each quarter.(Sales, Employees)
 --Har chorakda $45 000 dan ortiq savdoga ega bo'lgan xodimlarni topish uchun olingan jadval yarating.(Sotuvlar, Xodimlar)
 
;WITH cte AS (
							SELECT 
									EmployeeID,
									YEAR(SaleDate) AS SaleYear,
									DATEPART(QUARTER, SaleDate) AS SaleQuarter,
									SUM(SalesAmount) AS TotalQuarterSales
							FROM Sales
							GROUP BY EmployeeID, YEAR(SaleDate), DATEPART(QUARTER, SaleDate)
)
SELECT 
			EmployeeID,
			SaleYear,
			SaleQuarter,
			TotalQuarterSales
FROM cte
WHERE TotalQuarterSales > 45000;


-- Difficult Tasks
--This script uses recursion to calculate Fibonacci numbers
 

; with cte as 
(
select 0 as fibbonaci_num, 1 as incr
UNION ALL
select fibbonaci_num + incr as num, fibbonaci_num as incr from cte
where fibbonaci_num < 100
)
select * from cte
where fibbonaci_num >=5

--Find a string where all characters are the same and the length is greater than 1.(FindSameCharacters)
--Barcha belgilar bir xil va uzunligi 1 dan katta boʻlgan qatorni toping.(FindSameCharacters)
SELECT * FROM  FindSameCharacters
WHERE len(Vals) > 1 
				and Replicate(left(vals, 1), len(vals)) = vals

--Create a numbers table that shows all numbers 1 through n and their order gradually increasing by the next number in the sequence.(Example:n=5 | 1, 12, 123, 1234, 12345)
--1 dan n gacha bo'lgan barcha raqamlar va ularning tartibi ketma-ketlikdagi keyingi songa asta-sekin ortib boruvchi raqamlar jadvalini tuzing. (Misol: n=5 | 1, 12, 123, 1234, 12345)

;with cte as(
select 1 as my_num, cast('1' as varchar(20)) as my_char
union all
select my_num + 1 as my_num, cast((my_char + cast((my_num + 1) as varchar(20))) as varchar(20)) as my_char from cte
where my_num < 5
)
select * from cte



--Write a query using a derived table to find the employees who have made the most sales in the last 6 months.(Employees,Sales)
--Oxirgi 6 oy ichida eng koʻp savdo qilgan xodimlarni topish uchun olingan jadvaldan foydalanib soʻrov yozing.(Xodimlar,Sotuvlar)
SELECT 
    e.EmployeeID,
    e.FirstName,
    e.LastName,
    t.SaleCount
FROM Employees e
JOIN (
				SELECT 
					EmployeeID,
					COUNT(*) AS SaleCount
				FROM Sales
				WHERE SaleDate >= DATEADD(MONTH, -6, GETDATE())    
				GROUP BY EmployeeID
) t
    ON e.EmployeeID = t.EmployeeID
WHERE t.SaleCount = (
    SELECT MAX(SaleCount)
    FROM (
        SELECT 
            EmployeeID,
            COUNT(*) AS SaleCount
        FROM Sales
        WHERE SaleDate >= DATEADD(MONTH, -6, GETDATE())
        GROUP BY EmployeeID) x
		) 



--Write a T-SQL query to remove the duplicate integer values present in the string column. 
--Additionally, remove the single integer character that appears in the string.(RemoveDuplicateIntsFromNames)
 

select * from RemoveDuplicateIntsFromNames
 ;WITH SplitData AS
(
    SELECT 
        PawanName,
        value,
        ROW_NUMBER() OVER(PARTITION BY PawanName, value ORDER BY (SELECT NULL)) AS rn
    FROM RemoveDuplicateIntsFromNames
    CROSS APPLY STRING_SPLIT(Pawan_slug_name, '-') 
)
, Filtered AS
(
    SELECT 
        PawanName,
        value
    FROM SplitData
    WHERE ISNUMERIC(value) = 0    
       OR (ISNUMERIC(value) = 1 
           AND LEN(value) > 1               
           AND rn = 1)          
)
SELECT 
    PawanName,
    STRING_AGG(value, '-') AS CleanedValue
FROM Filtered
GROUP BY PawanName
ORDER BY PawanName;

