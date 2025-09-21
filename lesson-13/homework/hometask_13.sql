 sp_tables
-- easy tasks
--you need to write a query that outputs "100-steven king", meaning emp_id + first_name + last_name in that format using employees table.
--Xodimlar jadvali yordamida emp_id + first_name + familiya degan ma'noni anglatuvchi "100-Steven King"ni chiqaradigan so'rovni yozishingiz kerak.
SELECT * FROM Employees
SELECT cast(EMPLOYEE_ID as VARCHAR)
	+ '-'
	+ first_name
	+ Last_Name 
FROM Employees
WHERE Employee_ID = 100; --wrote "100-steven king",  

--update the portion of the phone_number in the employees table, within the phone number the substring '124' will be replaced by '999'
--Xodimlar jadvalidagi telefon_raqamining qismini yangilang, telefon raqami ichidagi "124" pastki qatori "999" bilan almashtiriladi.
SELECT * FROM Employees
SELECT replace(phone_Number, '124', '999') as Update_phone
FROM employees; --substring '124' will be replaced by '999'

--that displays the first name and the length of the first name for all employees whose name starts with the letters 'a', 'j' or 'm'. give each column an appropriate label. sort the results by the employees' first names.(employees)
--Bu "A", "J" yoki "M" harflari bilan boshlangan barcha xodimlarning ismi va ismining uzunligini ko'rsatadi.
--Har bir ustunga tegishli belgini bering. Natijalarni xodimlarning ismlari bo'yicha tartiblang.(Xodimlar)
SELECT first_name  FROM Employees 
 
SELECT first_name,
	len(first_name) as LEN_name 
FROM Employees 
WHERE first_name like 'A%' 
		or first_name like 'J%' 
		or first_name like 'M%';

 --write an sql query to find the total salary for each manager id.(employees table)
--Har bir menejer identifikatori uchun umumiy ish haqini topish uchun SQL so'rovini yozing.(Xodimlar jadvali)
SELECT * FROM Employees 
SELECT 
	m.Manager_id,
	m.first_name,
	sum(e1.Salary) as TotalSalary 
FROM Employees as e1
	inner join Employees as m
	on e1.Manager_ID = m.Employee_ID
GROUP BY m.Manager_id, m.first_name;
 
--write a query to retrieve the year and the highest value from the columns max1, max2, and max3 for each row in the testmax table
--TestMax jadvalidagi har bir satr uchun Max1, Max2 va Max3 ustunlaridan yil va eng yuqori qiymatni olish uchun so‘rov yozing.

SELECT * from testMAx
SELECT year1,
	CASE 
		WHEN max1 > max2 and max1>max3 then max1
		WHEN max2  > max1 and max2>max3  then max2
		WHEN max3 > max2 and max3> max1 then max3
		ELSE 'Unknown' end as Max_Status
FROM TestMax;

--find me odd numbered movies and description is not boring.(cinema)
--Menga toq sonli filmlarni toping va tavsif zerikarli emas.(kino)

SELECT * 
FROM cinema
WHERE id %2 = 1 and description  <> 'boring';
 
--you have to sort data based on the id but id with 0 should always be the last row. now the question is can you do that with a single order by column.(singleorder)
--Siz ma'lumotlarni Id asosida saralashingiz kerak, lekin 0 bilan Id har doim oxirgi qator bo'lishi kerak. 
--Endi savol shuki, buni ustun bo'yicha bitta tartib bilan qila olasizmi.(SingleOrder

SELECT * FROM singleOrder
SELECT vals
FROM SingleOrder
ORDER BY 
	CASE 
		WHEN vals  = 'All'  then 1 else 0 end;

--write an sql query to select the first non-null value from a set of columns. if the first column is null, move to the next, and so on. if all columns are null, return null.(person)
--Ustunlar to'plamidan birinchi nol bo'lmagan qiymatni tanlash uchun SQL so'rovini yozing. Agar birinchi ustun null bo'lsa, keyingisiga o'ting va hokazo. 
--Agar barcha ustunlar null bo'lsa, nullni qaytaring.(shaxs)
SELECT * FROM person
SELECT *,
	coalesce(ssn, passportid, itin, NULL) as All_Nulls
FROM Person;

--Medium Tasks
--Split column FullName into 3 part ( Firstname, Middlename, and Lastname).(Students Table)
--To'liq ism ustunini 3 qismga bo'ling (Ismi, otasining ismi va familiyasi). (Talabalar jadvali)
 
SELECT *,
substring(fullname, 1, len(left (fullname, Charindex(' ', fullname) - 1))) as Firstname,
reverse(substring(reverse(fullname), 1, len(left ( reverse(fullname), Charindex(' ', reverse(fullname)) - 1)))) as LastName,
substring(fullname, Charindex( ' ', fullname)+1, 
len(Fullname) - charindex(' ', fullname) - charindex(' ', reverse(fullname))) as MiddleName 
FROM Students;


--For every customer that had a delivery to California, provide a result set of the customer orders that were delivered to Texas. (Orders Table)
--Kaliforniyaga yetkazib berilgan har bir mijoz uchun Texasga yetkazib berilgan mijoz buyurtmalarining natijasini taqdim eting. (Buyurtmalar jadvali)
 
 
SELECT * FROM Orders
WHERE CustomerID  in (SELECT CustomerID
FROM Orders
WHERE  DeliveryState = 'CA') and deliveryState =  'TX';


--Write an SQL statement that can group concatenate the following values.(DMLTable)
--Quyidagi qiymatlarni birlashtira oladigan SQL bayonotini yozing.(DMLTable)

SELECT * FROM DMLTable
SELECT
string_agg(concat( SequenceNumber, String), ',')
FROM DMLTable;


--Find all employees whose names (concatenated first and last) contain the letter "a" at least 3 times.
--Ismlari (birinchi va oxirgi) kamida 3 marta "a" harfini o'z ichiga olgan barcha xodimlarni toping.
SELECT * FROM Employees
SELECT
first_Name, 
Last_Name 
FROM Employees
WHERE len(First_name+Last_name) - len(replace(First_name+Last_name, 'a', '' )) >=3;

 
 
--The total number of employees in each department and the percentage of those employees who have been with the company for more than 3 years(Employees)
 --Har bir bo'limdagi xodimlarning umumiy soni va kompaniyada 3 yildan ortiq ishlagan xodimlarning ulushi (Xodimlar)
 select * from Employees
select * from Employees
select 
count(Employee_id)
from Employees

select Department_ID,
count( Employee_ID) as ishchilarSoni 
from Employees 
group by DEPARTMENT_ID


select
where datediff(year, hire_date, getdate()) > = 3



select 
 Employee_ID,
 hire_date
from Employees
where datediff(year, hire_date, getdate()) < = 3
 

select Department_id,
count(Employee_ID) 
from Employees
group by Department_id

select Department_id,
       count(Employee_ID) as EmployeeCount
into Employees_Backup
from Employees
group by Department_id;




SELECT Department_ID,
	count(Employee_ID) as CountEmployee
into VETERAN_backup
FROM Employees 
WHERE Datediff( year, hire_date, getDate())   >= 3
GROUP BY Department_ID;

select * from Employees_Backup
select * from VETERAN_backup

select 
eb.DEPARTMENT_ID,
eb.EmployeeCount,
vb.CountEmployee,
cast(eb.EmployeeCount/vb.CountEmployee *100 as Varchar) + '%'   as javob
from Employees_Backup as eb
join VETERAN_backup as vb
	on eb.DEPARTMENT_ID = vb.DEPARTMENT_ID

	SELECT 
    Department_id,
    COUNT(Employee_ID) AS Total_Employees,
    (
        SELECT 
            CAST(COUNT(*) * 100.0 / COUNT(E.Employee_ID) AS DECIMAL(5,2))
        FROM Employees E2
        WHERE 
            E2.Department_id = E.Department_id
            AND DATEDIFF(YEAR, E2.Hire_Date, GETDATE()) > 3
    ) AS Percentage_More_Than_3_Years
FROM Employees E
GROUP BY Department_id;


--Write an SQL statement that determines the most and least experienced Spaceman ID by their job description.(Personal)
--Ish ta'rifi bo'yicha eng ko'p va eng kam tajribaga ega Spaceman ID-ni aniqlaydigan SQL bayonotini yozing.(Shaxsiy)
select * from Personal

SELECT * FROM Personal as p
WHERE MissionCount = (
			SELECT 
			min(MissionCount) as MinMissing
			FROM Personal 
			WHERE JobDescription = p.JobDescription)
or MissionCount = (
			SELECT 
			max(MissionCount) as MinMissing
			FROM Personal
			WHERE JobDescription = p.JobDescription);
			

--	Write an SQL query that separates the uppercase letters, lowercase letters, numbers, 
--and other characters from the given string 'tf56sd#%OqH' into separate columns.
 
 DECLARE @xman VARCHAR(50) = 'tf56sd#%OqH';
  
WITH Numbers AS (
    SELECT TOP(LEN(@xman)) ROW_NUMBER() OVER(ORDER BY (SELECT NULL)) AS n
    FROM sys.objects
)
SELECT
     STRING_AGG(SUBSTRING(@xman, n, 1), '') AS UppercaseLetters,
     STRING_AGG(CASE WHEN SUBSTRING(@xman, n, 1) LIKE '[a-z]' THEN SUBSTRING(@xman, n, 1) END, '') AS LowercaseLetters,
     STRING_AGG(CASE WHEN SUBSTRING(@xman, n, 1) LIKE '[0-9]' THEN SUBSTRING(@xman, n, 1) END, '') AS Numbers,
    STRING_AGG(CASE WHEN SUBSTRING(@xman, n, 1) LIKE '[^a-zA-Z0-9]' THEN SUBSTRING(@xman, n, 1) END, '') AS OtherChars
FROM Numbers; 

--Write an SQL query that replaces each row with the sum of its value and the previous rows' value. (Students table)
--Har bir qatorni uning qiymati va oldingi satrlar qiymatining yig'indisi bilan almashtiradigan SQL so'rovini yozing. (Talabalar jadvali)
select * from Students
SELECT 
    StudentID,
    Grade,
    SUM(Grade) OVER (ORDER BY StudentID) AS CumulativeSum
FROM Students; --Chat gpt ishlab berdi 

--You are given the following table, which contains a VARCHAR column that contains mathematical equations.
--Sum the equations and provide the answers in the output.(Equations)
 
select * from Equations
DECLARE @Equation VARCHAR(200)
DECLARE @SQL NVARCHAR(MAX)
DECLARE @Result INT

DECLARE cur CURSOR FOR
SELECT Equation FROM Equations

OPEN cur
FETCH NEXT FROM cur INTO @Equation

WHILE @@FETCH_STATUS = 0
BEGIN
  
    SET @SQL = N'SET @ResultOut = ' + @Equation
    EXEC sp_executesql @SQL, N'@ResultOut INT OUTPUT', @ResultOut=@Result OUTPUT
   UPDATE Equations
    SET TotalSum = @Result
    WHERE Equation = @Equation

    FETCH NEXT FROM cur INTO @Equation
END
CLOSE cur
DEALLOCATE cur
 
SELECT * FROM Equations --Chat GPT ishlab berdi 


--Given the following dataset, find the students that share the same birthday.(Student Table)
--Quyidagi maʼlumotlar toʻplamini hisobga olgan holda, tugʻilgan kuni bir xil boʻlgan talabalarni toping.(Talabalar jadvali)
SELECT StudentName, Birthday
FROM Student
WHERE Birthday IN (
    SELECT Birthday
    FROM Student
    GROUP BY Birthday
    HAVING COUNT(*) > 1
); --ChatGPT ishlab berdi


--You have a table with two players (Player A and Player B) and their scores.
--If a pair of players have multiple entries, aggregate their scores into a single row for each unique pair of players. 
--Write an SQL query to calculate the total score for each unique player pair(PlayerScores)
 
select * from PlayerScores
SELECT 
    CASE WHEN PlayerA < PlayerB THEN PlayerA ELSE PlayerB END AS Player1,
    CASE WHEN PlayerA < PlayerB THEN PlayerB ELSE PlayerA END AS Player2,
    SUM(Score) AS TotalScore
FROM PlayerScores
GROUP BY 
    CASE WHEN PlayerA < PlayerB THEN PlayerA ELSE PlayerB END,
    CASE WHEN PlayerA < PlayerB THEN PlayerB ELSE PlayerA END; --ChatGPT ishlab berdi

  