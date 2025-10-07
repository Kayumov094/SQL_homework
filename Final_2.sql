/*
Guidelines:
There are 5 puzzles in the practical part of the exam.
Provide your solution for each puzzle in the 
solution sections.

Before the start don't forget to create 
the "finalexam" database using the 
query below:
*/
-----------------------------------------------------------------------------------------------------------------------

--PUZZLE 1:
/*
Using Employees table List employees who are managers of someone, 
but their salary is less than or equal to the person they manage.

Employees jadvalidan shunday xodimlarni ro‘yxatlangki,
ular kimnidir boshqaradi (ya’ni, menejer hisoblanadi),
lekin ularning maoshi o‘zlari boshqarayotgan xodimning maoshidan kam yoki teng.
*/
 
select * from Employees

select * from Employees as e1
	join Employees as m2
		on e1.managerID = m2.EmployeeID
where m2.Salary < = e1.Salary -- shu managerlarki,  ularning maoshi o‘zlari boshqarayotgan xodimning maoshidan kam yoki teng


-----------------------------------------------------------------------------------------------------------------------------
--PUZZLE 2:
/*
Retrieve students who received the highest grade in each course. 
Tables: students (columns: student_id, name), 
grades (columns: student_id, course_id, grade)

Har bir kurs bo‘yicha eng yuqori baho olgan talabalarni tanlab oling.
Jadvallar:
students (ustunlar: student_id, name)
grades (ustunlar: student_id, course_id, grade)
*/

 select * from Students
 select * from Grades
  
 ;with cte as (
 select 
		 s.student_id,
		 s.name,
		 g.course_id,
		 g.grade,
		 max(g.grade) over (partition by g.course_id) as max_grade
 from Students as s
	 join Grades as g
		on s.student_id = g.student_id
 )
 select * from cte 
 where max_grade = grade; --talabalarki, Har bir kurs bo‘yicha eng yuqori baho olganlar!
 
-------------------------------------------------------------------------------------------------------------------------------

--PUZZLE 3:
/*
Create a derived table to find employees 
with sales over $45000 in each quarter.(Sales, Employees)

Har bir chorakda $45 000 dan ortiq savdo qilgan xodimlarni topish uchun hosila jadval (derived table) yarating.
*/
 

select *from (
    select EmployeeID,
    datepart(quarter, SaleDate) as Quarter,
    sum(SalesAmount) as TotalSales
    from Sales
    group by EmployeeID, datepart(quarter, SaleDate)
) as d where d.TotalSales > 45000;

-----------------------------------------------------------------------------------------------------------------------------

--PUZZLE 4:
/*
Write a solution to get the names of products 
that have at least 100 units ordered in February 2020 and their unit.

2020-yil fevral oyida kamida 100 dona buyurtma qilingan mahsulotlarning nomlari 
--va ularning birlik o‘lchovi (unit) ni topish uchun so‘rov yozing.
Expected Output:

| product_name       | unit  |
+--------------------+-------+
| Leetcode Solutions | 130   |
| Leetcode Kit       | 100   |
*/
 select * from Products 
 select * from Orders
 ;with cte as (
					 select
							 product_id,
							 year(Order_date) as year,
							 month(order_date) as month,
							 sum(unit) as SumUnit
					 from Orders
					 where year(Order_date) = 2020 and  month(order_date) = 02  
					 group by product_id,  year(Order_date), month(order_date)
					 having sum(unit) >= 100
 )
 select   distinct
    p.Product_name,
    cte.SumUnit AS Unit
 from cte 
	join products as p
		 on cte.product_id = p.Product_id; --2020-yil fevral oyida kamida 100 dona buyurtma qilingan mahsulotlarning nomlari 
	
	---------------------------------------------------------------------------------------------------------------------

--PUZZLE 5:
/*
In this puzzle you have to find the sum of val1 and val2 for each group 
and put that value at the beginning of the group in the new column. 
The challenge here is to do this in a single select. 
For more details please see the sample input and expected output.

--Bu masalada sizdan har bir guruh uchun val1 va val2 yig‘indisini topish talab etiladi
va shu qiymatni yangi ustunda guruhning boshiga joylashtirish kerak.
Bu jarayonni faqat bitta SELECT operatorida bajarish kerak.
Batafsil tushuncha uchun namunaviy kirish (input) va kutilgan chiqish (output) ma’lumotlariga qarang.
Sample Input

| Id  | Grp | Val1 | Val2 |  
|-----|-----|------|------|  
|  1  |  1  |   30 |   29 |  
|  2  |  1  |   19 |    0 |  
|  3  |  1  |   11 |   45 |  
|  4  |  2  |    0 |    0 |  
|  5  |  2  |  100 |   17 |

Expected Output

| Id | Grp | Val1 | Val2 | Tot  |
|----|-----|------|------|------|
| 1  | 1   | 30   | 29   | 134  |
| 2  | 1   | 19   | 0    | NULL |
| 3  | 1   | 11   | 45   | NULL |
| 4  | 2   | 0    | 0    | 117  |
| 5  | 2   | 100  | 17   | NULL |

*/
 
select * from MyData
;with cte as (
select *,
		Val1 + Val2 as SumVal,
		sum(Val1 + Val2 ) over(partition by Grp) as Sum_Of_Val
from Mydata)
select
Id, Grp, Val1, Val2, 
 case 
when id = rank() over(order by sum_of_val desc ) then Sum_Of_Val
else null end as Tot
from cte



---------------------------------------END OF EXAM--------------------------------------------------------------------------------