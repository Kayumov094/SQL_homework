--1. Create a temporary table named MonthlySales to store the total quantity sold and total revenue for each product in the current month.
--Return: ProductID, TotalQuantity, TotalRevenue
 ;with cte as ( 

						select  ProductID,
								  count(Quantity) as soni,
								  
month(SaleDate) as oylar
						 from Sales
						 group by ProductID, month(Saledate)
 )
 SELECT 
		 c.ProductID as ProductID,
		 soni as TotalQuantity,
		 sum(price) as TotalRevenue
 FROM cte as c
	JOIN Products as p
		 on c.ProductID = p.ProductID
 GROUP BY 
		  c.ProductID,
		 soni


 --2. Mahsulot ma'lumotlarini va barcha vaqt davomida umumiy savdo miqdorini qaytaradigan vw_ProductSalesSummary nomli ko'rinish yarating.
--Qaytish: ProductID, ProductName, Category, TotalQuantitySold
 CREATE VIEW vw_ProductSalesSummary
 AS 
		 WITH cte as (
									SELECT 
									 ProductID,
									 sum(Quantity) as TotalSoldQuantity
									 FROM Sales 
									 GROUP BY ProductID
 )
 SELECT 
			 p.ProductID,
			 TotalSoldQuantity,
			 Category,
			 PRoductName
 FROM cte as c
	 JOIN products as p
		ON c.ProductID = p.ProductID

 SELECT * FROM vw_ProductSalesSummary

-- 3. fn_GetTotalRevenueForProduct(@ProductID INT) nomli funksiya yarating.
--Qaytish: berilgan mahsulot identifikatori uchun jami daromad

select * from Products 
select * from Sales;

 create function fn_GetTotalRevenueForProduct(@ProductID INT)
 returns int
 as 
 BEGIN
				declare @TotalRevenueForProducts INT
				 select   @TotalRevenueForProducts = sum(s.quantity *   p.price )
				  from Sales as s 
				  join Products as p
				on s.ProductID = p.ProductID
				 where s.ProductID = @ProductID

				 return @TotalRevenueForProducts
end

select dbo.fn_GetTotalRevenueForProduct(2) as TotalRevenue
 


-- 4. fn_GetSalesByCategory(@Category VARCHAR(50)) funksiyasini yarating
--Qaytish: ushbu turkumdagi barcha mahsulotlar uchun mahsulot nomi, umumiy miqdor, umumiy tushum.

select * from Products
select * from Sales

create function fn_GetSalesByCategory(@Category VARCHAR(50))
returns table 
as 
return (
						select 
						p.ProductID,
						p.ProductName,
						s.Quantity,
						p.price,
						p.Category,
						sum(s.Quantity) as TotalQuantity,
						s.quantity * p.Price as TotalRevenue
						from Sales as s
						join Products as p
						on s.ProductID = p.ProductID
						group by p.ProductID,
						p.ProductName, 
						s.Quantity,
						p.price,
						p.Category
);
select * from dbo.fn_GetSalesByCategory('Clothing')



 --5. Siz foydalanuvchidan kirish sifatida bitta argument oladigan funksiya yaratishingiz kerak 
 --va agar kiritilgan raqam tub son boʻlsa, funksiya “Ha” va aks holda “Yoʻq” ni qaytarishi kerak. Siz buni quyidagicha boshlashingiz mumkin:
 
 
 create function dbo.fn_IsPrime (@Number INT)
returns varchar(50)
AS
BEGIN
    DECLARE @i INT = 2;
    DECLARE @IsPrime BIT = 1;  

    IF @Number <= 1
        RETURN 'Yo‘q';

    while @i <= @Number / 2
    begin
        if @Number % @i = 0
        begin
            set @IsPrime = 0;
            break;
        end
        set @i = @i + 1;
    end

 
    RETURN CASE WHEN @IsPrime = 1 THEN 'Ha' ELSE 'Yo‘q' END;
END;
select dbo.fn_IsPrime (5) as Check_Prime


--6. Kirish sifatida ikkita butun sonni qabul qiluvchi fn_GetNumbersBetween nomli jadval qiymatli funksiya yarating:

create function fn_GetNumberBetweens(@start int, @end int)
returns @Result table (number int)
as 
begin 
	declare @son int = @start
	while @son <= @end
		begin
		insert into @Result (Number) Values(@son)

		set @son = @son +1
		end
	return;
end;

select * from fn_GetNumberBetweens(5,10)


create function fn_GetNumbersBetween (@start int, @end int)
returns @Result table (Number int)
 
as
	begin
	declare @son int = @start

	while @son   < = @end
	begin 
		INSERT INTO @Result (Number)
		VALUES (@son)

		set @son = @son +1
	end
	REturn;
	end;

select * from dbo.fn_GetNumbersBetween(5, 20)	 


--7. Write a SQL query to return the Nth highest distinct salary from the Employee table. If there are fewer than N distinct salaries, return NULL.
--7. Xodimlar jadvalidan N-chi eng yuqori aniq maoshni qaytarish uchun SQL so'rovini yozing. Agar N dan kam ish haqi bo'lsa, NULLni qaytaring.
create table Employees(id int, Salary int)
insert into Employees (id, Salary ) Values (1, 100), (2, 200), (3, 300)
select * from Employees 

CREATE FUNCTION getNthHighestSalary(@N INT)
RETURNS INT
AS
BEGIN
    DECLARE @result INT;

  
    IF (@N <= 0 OR @N > (SELECT COUNT(*) FROM Employees))
        RETURN NULL;

 
    SELECT @result = Salary
    FROM Employees
    ORDER BY Salary DESC
    OFFSET (@N - 1) ROWS FETCH NEXT 1 ROWS ONLY;

    RETURN @result;
END;


select dbo.getNthHighestSalary(4)
	


--8. Eng ko'p do'stlari bo'lgan odamni topish uchun SQL so'rovini yozing.

SELECT requester_id AS person_id, accepter_id AS friend_id
FROM Friendship
UNION ALL
SELECT accepter_id AS person_id, requester_id AS friend_id
FROM Friendship

SELECT person_id, COUNT(friend_id) AS friend_count
FROM (
    SELECT requester_id AS person_id, accepter_id AS friend_id
    FROM Friendship
    UNION ALL
    SELECT accepter_id AS person_id, requester_id AS friend_id
    FROM Friendship
) AS all_friends
GROUP BY person_id

SELECT TOP 1 person_id, COUNT(friend_id) AS friend_count
FROM (
    SELECT requester_id AS person_id, accepter_id AS friend_id
    FROM Friendship
    UNION ALL
    SELECT accepter_id AS person_id, requester_id AS friend_id
    FROM Friendship
) AS all_friends
GROUP BY person_id
ORDER BY friend_count DESC;

--9. Create a View for Customer Order Summary.
 select * from Customers 
 select * from Orders
 create view vw_CustomerOrderSummary AS
select 
    c.customer_id,
    c.name AS nomi,
    count(o.order_id) AS jami_buyurtmalar,
    sum(o.amount) AS jami_summa,
    max(o.order_date) AS oxirgi_buyurtma_sanasi
from Customers AS c
left join Orders AS o
    on c.customer_id = o.customer_id
group by 
    c.customer_id, 
    c.name;

select * from vw_CustomerOrderSummary


DROP TABLE IF EXISTS Gaps;

 --10. Write an SQL statement to fill in the missing gaps. You have to write only select statement, no need to modify the table.
 SELECT 
    RowNumber,
    FIRST_VALUE(TestCase) OVER (
        PARTITION BY grp 
        ORDER BY RowNumber
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS Workflow
FROM (
    SELECT *,
        SUM(CASE WHEN TestCase IS NOT NULL THEN 1 ELSE 0 END)
        OVER (ORDER BY RowNumber ROWS UNBOUNDED PRECEDING) AS grp
    FROM Gaps
) AS t
ORDER BY RowNumber;
