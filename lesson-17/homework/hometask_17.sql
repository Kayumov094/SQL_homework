  --Siz barcha distribyutorlar va ularning mintaqalar bo'yicha sotilishi haqida hisobot taqdim etishingiz kerak.
  --Agar distribyutorda mintaqa uchun hech qanday savdo bo'lmasa,
  --o'sha kun uchun nol dollar qiymatini belgilang. Har bir mintaqa uchun kamida bitta sotuv bor deb hisoblang

  --You must provide a report of all distributors and their sales by region. If a distributor did not have any sales for a region, 
  --rovide a zero-dollar value for that day. Assume there is at least one sale for each region
  SELECT * FROM #RegionSales
 
 ;WITH cte_region AS (
									 SELECT DISTINCT region 
									 FROM #RegionSales ),
			cte_Distributor AS (
												 SELECT DISTINCT  Distributor
												 FROM #RegionSales),
			cte_sales AS (
										SELECT 
										Region,
										Distributor,
										sum(Sales) as TotalSales
										FROM #RegionSales 
										GROUP BY Region, Distributor)
 SELECT 
			 d.Distributor,
			 r.Region,
			 coalesce(TotalSales, 0) as TotalSalesByRegion 
 FROM cte_Distributor as d
				cross join cte_region as r
				left join cte_Sales as s
				on  s.Region = r.Region
					and s.Distributor = d.Distributor
ORDER BY Distributor, Region


 --Find managers with at least five direct reports
 --Kamida beshta bevosita hisobotga ega bo'lgan menejerlarni toping
 
 SELECT name
 FROM   Employee as e 
 WHERE exists  (
				 SELECT 
 							ManagerID,
							count( ID) as DirectReports 
				 FROM Employee as e1
				 WHERE   e. ID = e1.ManagerID
				 GROUP BY   ManagerID
				 HAVING count(id) >=5);

--3. Write a solution to get the names of products that have at least 100 units ordered in February 2020 and their amount.
-- 2020-yil fevral oyida kamida 100 dona buyurtma qilingan mahsulotlarning nomlarini va ularning miqdorini olish uchun yechim yozing.
 
 SELECT 
	p.Product_name,
	sum(o.Unit) as unit 
FROM Orders as o
	join Products as p
		on o.Product_id = p.Product_id 
WHERE year(o.Order_date) = 2020
			and month(o.Order_date) = 02
 GROUP BY p.Product_name
 HAVING sum(o.Unit) >= 100; --names of products that have at least 100 units ordered in February 2020 and their amount.

 -- Har bir mijoz eng koʻp buyurtma bergan sotuvchini qaytaradigan SQL bayonotini yozing.
  
;WITH cte AS (
SELECT 
		 CustomerID,
		 Vendor,
		 sum(Count) as total,
		 DENSE_RANK() OVER(partition by CustomerID order by sum(count) desc ) as ranking
FROM Orders 
GROUP BY 
				CustomerID,
				Vendor)
SELECT CustomerID, Vendor FROM cte 
WHERE ranking = 1; --Har bir mijoz eng koʻp buyurtma bergan sotuvchilar \

--You will be given a number as a variable called @Check_Prime check if this number is prime then return
--'This number is prime' else eturn 'This number is not prime'
 
 declare @check_prime int = 91;
 declare @boluvchi int = 2;
declare @qoldiq int =  1; --natija 1 bolsa tub boladi aks holda tub emas 

if @check_Prime < = 1
	set @qoldiq = 0;
else 
begin
		while @Boluvchi <@Check_Prime
		begin
				if @check_prime%@boluvchi = 0
						begin 
							set @qoldiq = 0;
							break
						end
				set @boluvchi = @boluvchi + 1;
		end
end
 
 if @qoldiq = 1
	begin
		print(cast(@check_prime as VARCHAR (10)) + ' Bu tub son')
		print('Dastur yakunlandi')
	end
else 
	begin
		print(cast(@check_prime as VARCHAR(10)) + ' Bu tub son emas')
		print('Dastur yakunlandi')
	end
	 
 
 --6. Berilgan jadvaldagi har bir qurilma uchun signallarning umumiy sonini va signallarning umumiy sonini
 --qaytar 
 select * from device
 ;WITH 
			SignalCount as (
								SELECT 
									device_id,
									locations,
									count(*) as signalTotal
								FROM device
								GROUP BY device_id, locations),
			MaxSignal AS (
								SELECT device_id,
									max( signalTotal) as MaxSignals 
								FROM SignalCount
								GROUP BY device_id)
SELECT 
		sc.device_id,
 		count(case when sc.SignalTotal = ms.MaxSignals then  2 end) as no_of_location,
		ms.MaxSignals as Max_signal_location,
		sum(sc.SignalTotal) as no_of_signals
	FROM SignalCount as sc 
		join maxSignal as ms
			on sc.Device_id = ms.Device_id
	GROUP BY sc.Device_id , ms.MaxSignals;

 --7. write a sql to find all employees who earn more than the average salary in their corresponding department. 
 --return empid, empname,salary in your output
 
 SELECT 
	EmpID,
	EmpName,
	Salary
FROM Employee as e1
WHERE salary> = (
								 SELECT
								  avg(salary) as AvgSalary
								 FROM Employee e2
								 WHERE e1.DeptID = e2.DeptID); --  employees who earn more than the average salary
								
SELECT e1.EmpID, e1.EmpName, e1.Salary
FROM Employee AS e1
JOIN (    SELECT DeptID, AVG(Salary) AS AvgSalary
    FROM Employee
    GROUP BY DeptID) AS t
  ON e1.DeptID = t.DeptID
WHERE e1.Salary >= t.AvgSalary;


--8. Siz ofis lotereya pulining bir qismisiz, 
--unda siz yutuqli lotereya raqamlari jadvalini hamda har bir chiptaning tanlangan raqamlari jadvalini saqlaysiz. 
--Agar chiptada barcha yutuq raqamlari bo'lmasa-da, ba'zilari bo'lsa, 
--siz 10 dollar yutib olasiz. Agar chiptada barcha yutuq raqamlari bo'lsa, 
--siz 100 dollar yutib olasiz. Bugungi o'yin uchun umumiy yutuqni hisoblang.
 
 select * from Tickets
 select * from Numbers
 ;WITH cte AS (
					 select 
						t.TicketID,
						t.Number,
						case 
							 when t.Number = n.Number then 1
							 else null end as Status
					 from tickets as t
						 left join Numbers as n
							 on t.Number = n.Number
 ),
 bonus AS ( 
					 select 
						TicketID,
						count(Status) as bonus
					from cte
					group by TicketID),
yutuq AS ( 
					 select 
					 case 
							when bonus = 3 then 100 
							when bonus between 1 and 2 then 10
							else 0 end as 'Yutuq'
					from bonus)
	SELECT 
			sum(yutuq) as SumBonus
	FROM yutuq;
 --Foydalanuvchilarning umumiy sonini 
 --va har bir sana uchun faqat mobil,
 --faqat ish stoli va ikkala mobil va ish stoli yordamida sarflangan umumiy miqdorni topish uchun SQL so‘rovini yozing.

 

; with PlatformAgg as (
											select 
											Spend_date,
											Platform,
											SUM(Amount) as Total_Amount,
											COUNT(distinct User_id) as Total_users
											from Spending
											group by Spend_date, Platform),
BothAgg as (
						select 
						Spend_date,
						'Both' as Platform,
						SUM(Amount) as Total_Amount,
						COUNT(distinct User_id) as Total_users
						from Spending
						group by Spend_date)
select 
		Spend_date, Platform, 
		Total_Amount, 
		Total_users,
        case 
           when Platform = 'Mobile' then 1
           when Platform = 'Desktop' then 2
           else 3
       end as sort_order
from PlatformAgg
union ALL
select Spend_date, Platform, Total_Amount, Total_users,
       case 
           when Platform = 'Mobile' then 1
           when Platform = 'Desktop' then 2
           else 3
       end
from BothAgg
order by Spend_date, sort_order;



--10. Write an SQL Statement to de-group the following data.
select * from grouped
;with expand as (
     select Product, 1 as CurrentVal, Quantity as Total
    from Grouped
	 union ALL
    select Product, CurrentVal + 1, Total
    from expand
    where CurrentVal + 1 <= Total
)
select Product, 1 as Quantity
from expand
order by Product
option (MAXRECURSION 0);
