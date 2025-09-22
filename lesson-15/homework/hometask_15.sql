 -- 1. Vazifa: Kompaniyada eng kam ish haqi oladigan xodimlarni oling. Jadvallar: xodimlar (ustunlar: id, ism, ish haqi)
  
 SELECT
		id,	
		name, 
		Salary as MinSalary
 FROM Employees 
WHERE salary = (select min(salary) from employees);

--2. Vazifa: o'rtacha narxdan yuqori bo'lgan mahsulotlarni oling. Jadvallar: mahsulotlar (ustunlar: id, mahsulot_nomi, narx)
 
SELECT 
		id, 
		Product_name,
		Price as HigherPrice
FROM Products 
WHERE price > (SELECT avg(price) FROM Products); -- narxlari o'rtachadan yuqori bolgan xodimlar royhati 

--3. Savdo bo'limida xodimlarni toping Vazifa: "Sotish" bo'limida ishlaydigan xodimlarni oling. 
--Jadvallar: xodimlar (ustunlar: id, ism, bo'lim_id), bo'limlar (ustunlar: id, bo'lim_nomi)
 
select * from employee
select * from Departments

SELECT 
	id,
	name
	FROM Employee as e
	WHERE department_id = (
											SELECT  id 
											FROM Departments  
											WHERE Department_name  = 'Sales'); -- Savdo bolimida ishlaydigan xodimlar royhati 

-- 4. Vazifa: Hech qanday buyurtma bermagan mijozlarni oling.
--Jadvallar: mijozlar (ustunlar: customer_id, ism), buyurtmalar (ustunlar: order_id, customer_id)
 select * from Customers
 select * from Orders

 SELECT 
	customer_id,
	name 
	FROM Customers as c
	WHERE  not exists (
										SELECT 1
										FROM  Orders as o 
										WHERE c.Customer_id = o.Order_id);

	SELECT 
	customer_id,
	name 
	FROM Customers as c
	WHERE  customer_id not in  (
										SELECT order_id
										FROM  Orders as o 
										WHERE c.Customer_id = o.Order_id); -- hech qanday buyurtma bermagan mijor topildi

--Vazifa: Har bir toifadagi eng yuqori narxga ega mahsulotlarni oling.
--Jadvallar: mahsulotlar (ustunlar: id, mahsulot_nomi, narx, kategoriya_id)
 SELECT * FROM Product 

 ;WITH cte AS (
						 SELECT 
						 category_id,
						 max(price) AS MaxPrice
						 FROM Product
						 GROUP BY category_id)
 SELECT
			id,
			product_name,
			price,
			product.category_id
 FROM cte 
 join product
	ON cte.Maxprice = product.price; --har bir toifaning eng yuqori narxlari, id, nomlari chiqarildi



--Vazifa: Bo'limda eng yuqori o'rtacha ish haqi bilan ishlaydigan xodimlarni oling.
--Jadvallar: xodimlar (ustunlar: id, ism, ish haqi, bo'lim_id), bo'limlar (ustunlar: id, bo'lim_nomi)

 SELECT * FROM department
 SELECT * FROM Employeess
 
 ;WITH cte AS (
						 SELECT 
						 department_id,
						 max(salary) as maxSalary
						 FROM employeess 
						 GROUP BY department_id)
SELECT * FROM cte 
join department AS d 
	ON cte.department_id = d.id

--7. Vazifa: o'z bo'limidagi o'rtacha ish haqidan ko'proq maosh oladigan xodimlarni oling. 
--Jadvallar: xodimlar (ustunlar: id, ism, ish haqi, bo'lim_id)
 
SELECT * FROM employees
 	
 ;WITH cte AS (
SELECT 
		department_id,
		avg(salary) as AvgSalary
FROM Employees as e2
GROUP BY department_id)
 
SELECT 	
		id,
		name,
		salary
FROM Employees as e1
join cte 
	ON e1.department_id = cte.department_id
	WHERE salary> AvgSalary; --oz bolimida o'rtachadan yuqori maosh oladiganlar topildi


 --Vazifa: Har bir kursda eng yuqori baho olgan talabalarni oling.
 --Jadvallar: talabalar (ustunlar: student_id, ism), baholar (ustunlar: student_id, kurs_id, baho)
 
 SELECT * FROM Students 
 SELECT * FROM Grades

;with cte AS (
					SELECT 
					course_id,
					max(grade) as MaxGrade
					FROM Grades
					GROUP BY course_id)

SELECT 
		students.name,
		grades.grade,
		grades.course_id
FROM cte
	join grades 
		on cte.MaxGrade = grades.grade
	join students
		on students.student_id =grades.student_id; -- kursda eng yuqori ball olganlar topildi

--9. Har bir toifadagi topshiriq bo'yicha uchinchi eng yuqori narxni toping : 
--Har bir toifadagi uchinchi eng yuqori narxga ega mahsulotlarni oling.
--Jadvallar: mahsulotlar (ustunlar: id, mahsulot_nomi, narx, kategoriya_id)
 
 SELECT * FROM Products 
 
SELECT * FROM (
SELECT 
		id,
		product_name,
		price,
		 category_id,
		DENSE_RANK() OVER(PARTITION BY category_id ORDER BY price DESC ) as RankPrice
FROM Products ) as t
WHERE rankprice = 3; -- har bir mahsulotning categoriyasi bo'yicha 3 o'rinda turgan mahsulaot topildi


--Vazifa: ish haqi kompaniyaning o'rtacha darajasidan yuqori bo'lgan, 
--lekin ularning bo'limidagi maksimal darajadan past bo'lgan xodimlarni oling. 
--Jadvallar: xodimlar (ustunlar: id, ism, ish haqi, bo'lim_id)
 
SELECT 
		cte.id,
		cte.name,
		cte.salary,
		cte.department_id
FROM  (
			SELECT * 
			FROM employees
			WHERE salary> (select avg(salary) from employees)) as cte 
	join ( select 
			 department_id,
			 max(salary) as MaxDeptSalary
 FROM employees
 GROUP BY department_id) as ctk
 ON cte.department_id = ctk.department_id
 WHERE  salary < MaxDeptSalary


 
  


 
