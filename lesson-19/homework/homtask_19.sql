 -- Part 1: Stored Procedure Tasks
--  Task 1:
--Create a stored procedure that:

--Creates a temp table #EmployeeBonus
--Inserts EmployeeID, FullName (FirstName + LastName), Department, Salary, and BonusAmount into it
--(BonusAmount = Salary * BonusPercentage / 100)
--Then, selects all data from the temp table.

 
select * from Employees 
select * from DepartmentBonus
create procedure EmployeeBonus 
as 
begin 
select 
e.EmployeeID,
e.FirstName,
e.LastName,
d.Department,
e.Salary * d.BonusPercentage as bonus 
from Employees as e
join Departmentbonus as d
on e.Department = d.Department
end 
exec EmployeeBonus

--Task 2:
--Create a stored procedure that:

--Accepts a department name and an increase percentage as parameters
--Update salary of all employees in the given department by the given percentage
--Returns updated employees from that department.

 
select * from Employees 
select * from Departmentbonus
 
create proc IncreaseByDepartment
	 @Department VARCHAR(50),
	 @BonusPercentage float
as
		begin
				select 
				e.EmployeeID,
				e.Firstname,
				e.LastName,
				d.Department,
				e.Salary + (e.Salary * d.BonusPercentage/100)  as TotalSalary
				from Employees as e
				join Departmentbonus as d
				on e.Department = d.Department
				where e.department = @Department 
				and     d.BonusPercentage = @BonusPercentage
		end;

exec IncreaseByDepartment
	@Department = 'IT',
	@BonusPercentage = 15;

 --Part 2: MERGE Tasks

select * from Products_Current 

select * from  Products_New 
--  Task 3:
--Perform a MERGE operation that:

--Updates ProductName and Price if ProductID matches
--Inserts new products if ProductID does not exist
--Deletes products from Products_Current if they are missing in Products_New
--Return the final state of Products_Current after the MERGE.

 
 CREATE PROC SyncProducts 
 as 
 begin
		 merge into Products_Current as Target
		 Using Products_New as Source 
		 on Target.ProductID = Source.ProductID

		 when matched then 
			update set
			Target.ProductName = Source.ProductName,
			Target.Price = Source.Price 

		when not matched by Target then 
			INSERT (ProductID, ProductName, Price)
			Values (Source.ProductID, Source.ProductName, Source.Price);
			 end;
			 
EXEC SyncProducts

SELECT * FROM Products_Current

4-topshiriq:
--Daraxt tugunlari

--Daraxtdagi har bir tugun uchta turdan biri bo'lishi mumkin:

--"Yaproq" : agar tugun barg tugun bo'lsa.
--"Ildiz" : agar tugun daraxtning ildizi bo'lsa.
--"Ichki" : Agar tugun barg tugunlari ham, ildiz tugunlari ham bo'lmasa.
--Daraxtdagi har bir tugunning turini xabar qilish uchun yechim yozing.

 select * from Tree
 select 
    id,
    case
    when p_id is null then 'ildiz'
    when id not in (select distinct p_id from tree where p_id is not null) then 'yaproq'
    else 'ichki'
    end as tugun_turi
from tree;

--5-topshiriq:
--Tasdiqlash darajasi

--Har bir foydalanuvchi uchun tasdiqlash tezligini toping. Agar foydalanuvchida tasdiqlash so'rovlari bo'lmasa, tarif 0 bo'lishi kerak.

--Kirish:
 

select * from Signups 
select * from Confirmations
select 
    s.user_id as [foydalanuvchi idsi],
    format(
        isnull(
            cast(sum(case when c.action = 'confirmed' then 1 else 0 end) as float) 
            / nullif(count(c.action), 0),
        0),
    'n2') as [tasdiqlash_stavkasi]
from signups as s
left join confirmations as c
    on s.user_id = c.user_id
group by s.user_id
order by s.user_id;

-- 6-topshiriq:
--Eng kam maoshli xodimlarni toping
select * from Employees 
select * from Employees as e1
where salary  = (select min(salary) from employees )

select id, name, salary
from (
    select *,
           min(salary) over () as min_salary
    from employees
) as t
where salary = min_salary;

-- 7-topshiriq:
--Mahsulotni sotish bo'yicha xulosani oling
select * from Products 
select * from Sales 

--Saqlangan protsedura yarating GetProductSalesSummary:

--@ProductIDKirishni qabul qiladi
--Qaytaradi:
--Mahsulot nomi
--Jami sotilgan miqdori
--Umumiy savdo summasi (miqdori × narxi)
--Birinchi sotilgan sana
--Oxirgi sotuv sanasi
--Agar mahsulot sotuvi bo'lmasa, NULLmiqdori, umumiy miqdori, birinchi sanasi va oxirgi sanasini qaytaring, lekin baribir mahsulot nomini qaytaring.

create procedure getproductsalessummary
    @productid int
as
begin
    select 
        p.productid,
        p.productname,
        sum(s.quantity) as totalsales,
        sum(s.quantity * p.price) as salesamount,
        min(s.saledate) as firstsaledate,
        max(s.saledate) as latestsaledate
    from products as p
    left join sales as s
        on p.productid = s.productid
    where p.productid = @productid
    group by p.productid, p.productname;
end;

 
 exec GetProductSalesSummary 
	@ProductID = 5

  