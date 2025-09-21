sp_tables
--Easy Tasks
--Write a SQL query to split the Name column by a comma into two separate columns: Name and Surname.(TestMultipleColumns)
--Ism ustunini vergul bilan ikkita alohida ustunga bo'lish uchun SQL so'rovini yozing: Ism va Familiya.(TestMultipleColumns)
 
SELECT 
		substring(name, 1, charindex(',',name)-1) as name,
		substring(name, charindex(',', name)+1, len(name)) as surname 
FROM TestMultipleColumns; --query to split the Name column by a comma into two separate columns

--Write a SQL query to find strings from a table where the string itself contains the % character.(TestPercent)
--Jadvaldagi satrlarni topish uchun SQL so'rovini yozing, unda satrning o'zi % belgisini o'z ichiga oladi.(TestPercent)
 
 SELECT 
		*,
		substring(Strs, 1, charindex('%', Strs)-1) as name,
		substring(Strs, charindex('%', Strs)+1, len(Strs)) as lastname,
		substring(Strs, charindex('%', Strs), 1) as Percentage_
FROM TestPercent
WHERE charindex('%', Strs) >0; --query to find strings from a table where the string itself contains the % character.

--In this puzzle you will have to split a string based on dot(.).(Splitter)
--Bu boshqotirmada siz nuqta (.) ga asoslangan qatorni ajratishingiz kerak bo'ladi.(Splitter)
 
SELECT
		substring(Vals, 1, charindex('.', Vals)-1) as firstword,
		substring(Vals, charindex('.',Vals), 1)  as Character,
		substring(Vals, charindex('.', Vals)+1, len(Vals)) as lastword,
		substring(vals, charindex('.', Vals, Charindex('.', Vals) +1), len(Vals)) as latestword
FROM Splitter; -- split a string based on dot(.).(Splitter)

--Write a SQL query to replace all integers (digits) in the string with 'X'.(1234ABC123456XYZ1234567890ADS)
--Satrdagi barcha butun sonlarni (raqamlarni) "X" bilan almashtirish uchun SQL so'rovini yozing.(1234ABC123456XYZ1234567890ADS)

DECLARE @jumla VARCHAR(50) = '1234ABC123456XYZ1234567890ADS';

SET @jumla = REPLACE(@jumla, '0', 'X');
SET @jumla = REPLACE(@jumla, '1', 'X');
SET @jumla = REPLACE(@jumla, '2', 'X');
SET @jumla = REPLACE(@jumla, '3', 'X');
SET @jumla = REPLACE(@jumla, '4', 'X');
SET @jumla = REPLACE(@jumla, '5', 'X');
SET @jumla = REPLACE(@jumla, '6', 'X');
SET @jumla = REPLACE(@jumla, '7', 'X');
SET @jumla = REPLACE(@jumla, '8', 'X');
SET @jumla = REPLACE(@jumla, '9', 'X');

SELECT @jumla AS result;

--Write a SQL query to return all rows where the value in the Vals column contains more than two dots (.).(testDots)
--Vals ustunidagi qiymat ikki nuqtadan (.) ortiq bo'lgan barcha satrlarni qaytarish uchun SQL so'rovini yozing.(testDots)
 
SELECT *
FROM TestDots
WHERE Len(Vals) - len(replace('.', '', Vals))>2; --all rows where the value in the Vals column contains more than two dots (.).

--Write a SQL query to count the spaces present in the string.(CountSpaces)
--Satrdagi bo'shliqlarni hisoblash uchun SQL so'rovini yozing.(CountSpaces)
 
SELECT 
		texts,
		len(Texts) as FullLen,
		len(Texts) - len(replace(Texts, ' ', '')) as SpaceCounted 
FROM CountSpaces; --count the spaces present in the string.

--write a SQL query that finds out employees who earn more than their managers.(Employee)
--Menejerlaridan ko'proq maosh oladigan xodimlarni aniqlaydigan SQL so'rovini yozing.(Xodim)
 SELECT 
		e1.name as EmployeeName ,
		e1.Salary as EmployeeSalary,
		e2.name as ManagerName,
		e2.Salary as ManagerSalary
FROM Employee as e1
		join Employee as e2
			on e1.ManagerID = e2.id
WHERE e1.salary > e2.Salary;   --out employees who earn more than their managers.

--Find the employees who have been with the company for more than 10 years, but less than 15 years.
--Display their Employee ID, First Name, Last Name, Hire Date, and the Years of Service 
--(calculated as the number of years between the current date and the hire date).(Employees)
 
SELECT 
		Employee_ID,
		first_name, 
		last_name,
		Hire_date,
		datediff(year, hire_date,  getdate()) as WorkedYears
FROM Employees 
WHERE  datediff(year, hire_date,  getdate())>10 and datediff(year, hire_date,  getdate()) <= 15; --the employees who have been with the company for more than 10 years, but less than 15 years

--Medium Tasks 

--Write a SQL query to separate the integer values and the character values into two different columns.(rtcfvty34redt)
--butun son qiymatlari va belgilar qiymatlarini ikki xil ustunga ajratish uchun sql so‘rovini yozing.(rtcfvty34redt)

DECLARE @jumla VARCHAR (50) = 'rtcfvty34redt'
DECLARE @son Varchar (50) = ' ' 
DECLARE @harf VARCHAR(30 ) = ' ' 
DECLARE @checker int = 1

WHILE @checker <= len(@jumla)
	BEGIN 
		if ASCII(substring(@jumla, @checker, 1)) between 48 and 57 
			set @son  = @son + substring(@jumla, @checker, 1)
		else if ASCII(substring(@jumla, @checker, 1)) between 97 and 122 
			set @harf = @harf +  substring(@jumla, @checker, 1)
		else 
			print('Bunday qilish mimkin emas')
	SET @checker = @checker +1
	END 

SELECT @son as Sonlar , @harf as Harflar 

--write a SQL query to find all dates' Ids with higher temperature compared to its previous (yesterday's) dates.(weather)
--oldingi (kechagi) sanalarga nisbatan yuqori haroratli barcha sanalarning identifikatorlarini topish uchun sql soʻrovini yozing.(ob-havo)

select * from Weather 

SELECT w1.id
FROM weather as w1 
join weather as w2 
	on w1.RecordDate = DATEADD(day,1, w2.RecordDate)
	and w1.temperature > w2.temperature ; -- query to find all dates' Ids with higher temperature compared to its previous 
 
 --Write an SQL query that reports the first login date for each player.(Activity)
--har bir oʻyinchi uchun birinchi kirish sanasi haqida xabar beruvchi sql soʻrovini yozing.(faoliyat)
SELECT * FROM activity
SELECT	
	player_id,
	min(event_date)
FROM Activity
GROUP BY player_id; --first login date for each player

--Your task is to return the third item from that list.(fruits)
--sizning vazifangiz ushbu ro'yxatdagi uchinchi elementni qaytarishdir.(mevalar)
SELECT * FROM fruits

 DECLARE @fruits VARCHAR(100)

 SELECT @fruits =  fruit_list
 FROM fruits
 
 SELECT @fruits as fruits
 SELECT  substring(@fruits, 3, 1) as ThirdElement; --@fruits o'zgaruvchidan 3 inchi element ajratib olindi
 
--Write a SQL query to create a table where each character from the string will be converted into a row.(sdgfhsdgfhs@121313131)
--satrdagi har bir belgi qatorga aylantiriladigan jadval yaratish uchun sql so'rovini yozing.(sdgfhsdgfhs@121313131)
--1-variant 
declare @jumla VARCHAR(100) = 'sdgfhsdgfhs@121313131'
declare 
	@lowercase VARCHAR(50) = ' ',
	@integers VARCHAR(50) = ' ',
	@others VARCHAR(50) = ' ',
	@checker int =1

while @checker <= len(@jumla)
begin 
	if ASCII(substring(@jumla, @checker, 1)) between 97 and 122 
		set @lowercase = @lowercase + substring(@jumla, @checker, 1)
	else if ASCII( substring(@jumla, @checker, 1)) between 48 and 57
		set @integers = @integers + substring(@jumla, @checker, 1)
	else  
		set @others = @others +  substring(@jumla, @checker, 1)

set @checker = @checker +1
end

select 
@lowercase as lowercsase,
@integers as integer,
@others as others 

--2 variant 

declare @jumla VARCHAR(100) = 'sdgfhsdgfhs@121313131'
declare 
	@lowercase VARCHAR(50) = ' ',
	@integers VARCHAR(50) = ' ',
	@others VARCHAR(50) = ' ',
	@checker int =1

while @checker < = len(@jumla) 
begin 
	declare @char char(1) = substring(@jumla, @checker, 1)

	if ASCII(@char) between  97 and 122 
		set @lowercase = @lowercase +@char
	else if ASCII(@char)  between 48 and 57
		set @integers = @integers + @char
	else if ASCII(@char)  between 48 and 57
		set @integers = @integers +@char
			else  
		set @others = @others +  @char

set @checker = @checker + 1
END 
select 
@lowercase as lowercsase,
@integers as integer,
@others as others 

--You are given two tables: p1 and p2. Join these tables on the id column.
--The catch is: when the value of p1.code is 0, replace it with the value of p2.code.(p1,p2)
--sizga ikkita jadval beriladi: p1 va p2. ushbu jadvallarni id ustuniga qo'shing. tushunish: 
--p1.code qiymati 0 bo'lsa, uni p2.code qiymati bilan almashtiring.(p1,p2)
select * from p1 
select * from p2

 SELECT 
		 p1.code as p1code,
		 p2.code as p2code, 
		 isnull(Nullif(p1.code, 0),  p2.code) as UpdateCode
 FROM p1 
		join p2 
			 on p1.id = p2.id

--Write an SQL query to determine the Employment Stage for each employee based on their HIRE_DATE. The stages are defined as follows:
--If the employee has worked for less than 1 year → 'New Hire'
--If the employee has worked for 1 to 5 years → 'Junior'
--If the employee has worked for 5 to 10 years → 'Mid-Level'
--If the employee has worked for 10 to 20 years → 'Senior'
--If the employee has worked for more than 20 years → 'Veteran'(Employees)

SELECT * FROM Employees
SELECT 
	first_name,
	hire_date,
	CASE 
		WHEN datediff( year, hire_date, getdate()) >1 then 'New-hire'
		WHEN datediff(year, hire_date, getdate()) between 1 and 5 then 'Junior'
		WHEN datediff(year, hire_date, getdate()) between 5 and 10 then 'Mid-Level'
		WHEN datediff(year, hire_date, getdate()) between 10 and 20 then 'Senior'
		ELSE 'Veteran' end as 'WorkedStatus'
FROM Employees 

--Write a SQL query to extract the integer value that appears at the start of the string in a column named Vals.(GetIntegers)
--vals.(getintegers) nomli ustunda satr boshida paydo bo'ladigan butun son qiymatini chiqarish uchun sql so'rovini yozing.
select * from getintegers
select  
case 
	when vals like '[0-9]%'
	then cast(substring(vals, 1, patindex('%[^0-9]%', vals + 'X')-1 ) as INT)
	else NULL end as Status
from getintegers

------Hard puzzles
--In this puzzle you have to swap the first two letters of the comma separated string.(MultipleVals)
--Bu jumboqda siz vergul bilan ajratilgan qatorning birinchi ikki harfini almashtirishingiz kerak.(MultipleVals)
SELECT * FROM MultipleVals
SELECT 
	replace(vals, substring(Vals, 1, charindex(',', vals, charindex(',', vals) +1)),  'XX')
FROM MultipleVals

--Write a SQL query that reports the device that is first logged in for each player.(Activity)
--Har bir oʻyinchi uchun birinchi kirgan qurilma haqida xabar beruvchi SQL soʻrovini yozing.(Faoliyat)
SELECT * FROM Activity
SELECT 
	device_id,
	min(event_date) as firstActivity
FROM Activity
GROUP BY device_id

--You are given a sales table. Calculate the week-on-week percentage of sales per area for each financial week. 
--For each week, the total sales will be considered 100%, and the percentage sales for each day of the week should be
--calculated based on the area sales for that week.(WeekPercentagePuzzle)
 
SELECT * FROM WeekPercentagePuzzle
SELECT 
    area,
    financialWeek,
    SUM(salesLocal + SalesRemote) AS weekly_area_sales,
    SUM(SUM(salesLocal + SalesRemote)) OVER (PARTITION BY financialWeek) AS total_week_sales,
    CAST(SUM(salesLocal + SalesRemote) * 100.0 / SUM(SUM(salesLocal + SalesRemote)) OVER (PARTITION BY financialWeek) AS DECIMAL(10,2)) AS percentage_of_week
FROM WeekPercentagePuzzle
GROUP BY area, financialWeek;





