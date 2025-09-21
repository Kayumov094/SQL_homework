 --Easy-Level Tasks
--Using Products table, find the total number of products available in each category.
--Mahsulotlar jadvalidan foydalanib, har bir toifadagi mahsulotlarning umumiy sonini toping.

 SELECT 
		Category
		,count(ProductID) as CountProducts
FROM Products
GROUP BY category; --Used Products table, find the total number of products available in each category.

--Using Products table, get the average price of products in the 'Electronics' category.
--Mahsulotlar jadvalidan foydalanib, "Elektronika" toifasidagi mahsulotlarning o'rtacha narxini oling.
 
SELECT
		avg(Price) as AvgCostElectronics
FROM Products
WHERE category = 'Electronics' --get the average price of products in the 'Electronics' category.

--Using Customers table, list all customers from cities that start with 'L'
--Mijozlar jadvalidan foydalanib, "L" harfi bilan boshlangan shaharlardagi barcha mijozlarni ro'yxatlang.
 
SELECT * 
FROM Customers 
WHERE city like 'L%'; --list all customers from cities that start with 'L'

--Using Products table, get all product names that end with 'er'.
--Mahsulotlar jadvalidan foydalanib, "er" bilan tugaydigan barcha mahsulot nomlarini oling.
 
SELECT * 
FROM Products 
WHERE ProductName like '%er'; --get all product names that end with 'er'.

--Using Customers table, list all customers from countries ending in 'A'.
--Mijozlar jadvalidan foydalanib, "A" bilan tugaydigan mamlakatlardagi barcha mijozlarni ro'yxatlang.
SELECT * 
FROM Customers
WHERE country like '%A'; --list all customers from countries ending in 'A'

--Using Products table, show the highest price among all products.
--Mahsulotlar jadvalidan foydalanib, barcha mahsulotlar orasida eng yuqori narxni ko'rsating.
 
SELECT  
		max(Price) as MaxPriceProduct
FROM Products;

--Using Products table, label stock as 'Low Stock' if quantity < 30, else 'Sufficient'.
 
SELECT *,
		IIF(StockQuantity<30, 'Low Stock', 'Sufficient') as StockStatus
FROM Products; --label stock as 'Low Stock' if quantity < 30, else 'Sufficient'

--Using Customers table, find the total number of customers in each country.

 SELECT 
		Country
		,count(CustomerID) AS ByCountryCustomers
FROM Customers
GROUP BY   Country;

--Using Orders table, find the minimum and maximum quantity ordered.
--Buyurtmalar jadvalidan foydalanib, buyurtma qilingan minimal va maksimal miqdorni toping.
 
 SELECT
		min(quantity) AS MinQuantity
		,max(quantity) AS MaxQuantity
FROM Orders; --found the minimum and maximum quantity ordered.

--Medium-Level Tasks
--Using Orders and Invoices tables, list customer IDs who placed orders in 2023 January to find those who did not have invoices.
 
SELECT o.CustomerID
FROM Orders o
LEFT JOIN Invoices i 
    ON o.CustomerID = i.CustomerID
WHERE YEAR(o.OrderDate) = 2023
  AND MONTH(o.OrderDate) = 1
  AND i.CustomerID IS NULL; --list customer IDs who placed orders in 2023 January to find those who did not have invoices.


--Using Products and Products_Discounted table, Combine all product names from Products and Products_Discounted including duplicates.
 
SELECT ProductName 
FROM Products
UNION ALL
SELECT ProductName
FROM Products_Discounted;--Combine all product names from Products and Products_Discounted including duplicates.

--Using Products and Products_Discounted table, Combine all product names from Products and Products_Discounted without duplicates.
 
SELECT ProductName 
FROM Products
UNION  
SELECT ProductName
FROM Products_Discounted;--Combine all product names from Products and Products_Discounted without duplicates.
 
 --Using Orders table, find the average order amount by year.
 
SELECT 
		year(OrderDate) as ByYearOrder
		,avg(TotalAmount) as AvgTotalAmount
FROM Orders
GROUP BY year(OrderDate); -- found the average order amount by year.

--Using Products table, group products based on price: 'Low' (<100), 'Mid' (100-500), 'High' (>500). Return productname and pricegroup.
  
SELECT ProductName,
	CASE 
		WHEN price<100 THEN 'Low'
		WHEN price between 100 and 500 THEN 'Mid'
		ELSE 'High' END AS StatusPrice
FROM Products; --grouped products based on price: 'Low' (<100), 'Mid' (100-500), 'High' (>500).
 
--Using City_Population table, use Pivot to show values of Year column in seperate columns ([2012], [2013]) and copy results to a new Population_Each_Year table.
 
 SELECT *
			,[2012]
			,[2013]
 FROM City_Population
 PIVOT(
 sum(population) for year in( [2012], [2013])
 ) AS Aholini_yillik_yil; --use Pivot to show values of Year column in seperate columns ([2012], [2013]) and copy results to a new Population_Each_Year table.

 --Using Sales table, find total sales per product Id.
   
SELECT 
		ProductID
		,sum(SaleAmount) as ProductTotalAmount
FROM Sales 
GROUP BY ProductID; --found total sales per product Id.


--Using Products table, use wildcard to find products that contain 'oo' in the name. Return productname.
 
SELECT ProductName 
FROM Products 
WHERE ProductName like '%oo%'; --used wildcard to find products that contain 'oo' in the name. Returned productname.

--Using City_Population table, use Pivot to show values of City column in seperate columns (Bektemir, Chilonzor, Yakkasaroy) and copy results to a new Population_Each_City table.
  
SELECT *
		,[Bektemir]
		,[Chilonzor]
		,[Yakkasaroy]
FROM City_Population
PIVOT(
		sum(population) for district_name in ([Bektemir], [Chilonzor], [Yakkasaroy])
) AS Aholi_shahar_Jadvali; --used Pivot to show values of City column in seperate columns (Bektemir, Chilonzor, Yakkasaroy) and copy results to a new Population_Each_City table.
  
--  Hard-Level Tasks
--Using Invoices table, show top 3 customers with the highest total invoice amount. Return CustomerID and Totalspent.
--Hisob-fakturalar jadvalidan foydalanib, 
--eng ko'p umumiy hisob-faktura miqdoriga ega bo'lgan
--eng yaxshi 3 ta mijozni ko'rsating. CustomerID va Totalsent-ni qaytaring.
 select * from Invoices
 select   TOP 3 CustomerID, sum(TotalAmount)as Totalsent
 from Invoices
 group by CustomerID
 order by Totalsent desc

--Transform Population_Each_Year table to its original format (City_Population).
  
 SELECT district_id, district_name, year, population
FROM (
    SELECT district_id, district_name, [2012], [2013]
    FROM City_Population
    PIVOT (
        SUM(population) FOR year IN ([2012], [2013])
    ) AS Aholini_yillik_yil
) p
UNPIVOT (
    population FOR year IN ([2012], [2013])
) AS unpvt;

--Using Products and Sales tables, list product names and the number of times each has been sold. (Research for Joins)
 
select p.ProductName, count(s.SaleID) as TimeSoldProducts
from Products p join Sales s on p.ProductID = s.ProductID
group by p.ProductName 
order by TimeSoldProducts DESC; --list product names and the number of times each has been sold. 

--Transform Population_Each_City table to its original format (City_Population).
SELECT 
    year,
    district_name,
    population
FROM (
    SELECT year, [Bektemir], [Chilonzor], [Yakkasaroy]
    FROM City_Population
    PIVOT(
        SUM(population) FOR district_name IN ([Bektemir], [Chilonzor], [Yakkasaroy])
    ) AS Aholi_shahar_Jadvali
) p
UNPIVOT
(
    population FOR district_name IN ([Bektemir], [Chilonzor], [Yakkasaroy])
) AS unpvt; 