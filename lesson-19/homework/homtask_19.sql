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

-- 2-topshiriq:
--Saqlangan protsedura yarating:

--Parametr sifatida bo'lim nomini va o'sish foizini qabul qiladi
--Ushbu bo'limdagi barcha xodimlarning ish haqini berilgan foizda yangilang
--Ushbu bo'limdan yangilangan xodimlarni qaytaradi.
select 
*
from Employees as e
join Departmentbonus as d
on e.Department = d.Department

create proc IncreaseByDepartment
	 @

 

END
