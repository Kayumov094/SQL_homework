 
 --1. EXISTS yordamida 2024-yil mart oyida kamida bitta mahsulot sotib olgan mijozlarni toping
 select * from #sales
 select 
	SaleID,
	CustomerName,
	quantity,
	SaleDate
from #Sales as s
where exists (select 1 from #Sales as x where s.CustomerName = x.CustomerName and year(SaleDate) = 2024 and month(SaleDate) = 03)
--2.Quyi so‘rov yordamida eng yuqori umumiy savdo daromadiga ega mahsulotni toping.

select * from #Sales 
;with cte as (
select 
product,
sum(Quantity * Price) as TotalRevenue
from #Sales 
group by Product
)
select Top 1
product,
TotalRevenue as MaxRevenueByProducts
from cte 
order by MaxRevenueByProducts desc

 --3. Find the second highest sale amount using a subquery
--3. Quyi so'rov yordamida ikkinchi eng yuqori sotuv miqdorini toping
select * from #Sales 
;with cte as (
    select 
    product,
    sum(quantity * price) as totalrevenue,
    rank() over (order by sum(quantity * price) desc) as rnk
    from #sales
    group by product
)
select product, totalrevenue
from cte
where rnk = 2;

 
select * from #Sales 
-- Bir oyda sotilgan mahsulotlarning umumiy miqdorini pastki so'rov yordamida toping

select 
    product,
    saledate,
    quantity,
    price,
    (select sum(quantity * price)
     from #sales s2
     where month(s2.saledate) = month(s1.saledate)
       and year(s2.saledate) = year(s1.saledate)
    ) as monthtotal
from #sales s1;

-- EXISTS yordamida boshqa xaridor bilan bir xil mahsulotlarni sotib olgan mijozlarni toping

select distinct s1.customername
from #sales s1
where exists (
    select 1
    from #sales s2
    where s1.product = s2.product
      and s1.customername <> s2.customername
);

-- 6. Har bir odamning individual meva darajasida qancha meva borligini qaytaring
select 
name,
sum(case when fruit = 'apple' then 1 else 0 end) as apple,
sum(case when fruit = 'orange' then 1 else 0 end) as orange,
sum(case when fruit = 'banana' then 1 else 0 end) as banana
from fruits
group by name;

--7. Oiladagi keksa odamlarni kichiklari bilan birga qaytaring
;with cte as (
select parentid, childid
from family
union all
select c.parentid, f.childid
from cte c
join family f on c.childid = f.parentid
)
select distinct parentid as pid, childid as chid
from cte
order by pid, chid;

--8. Quyidagi talablarni hisobga olgan holda SQL bayonini yozing. Kaliforniyaga yetkazib berilgan har bir mijoz uchun Texasga yetkazib berilgan 
--mijoz buyurtmalarining natijasini taqdim eting

select o.customerid, o.orderid, o.deliverystate, o.amount
from #orders as o
where o.deliverystate = 'tx'
and exists (
select 1 
from #orders as c
where c.customerid = o.customerid
and c.deliverystate = 'ca'
);

--9. Agar ular etishmayotgan bo'lsa, yashovchilarning ismlarini kiriting
UPDATE #residents
SET address = CONCAT(address, ' name=', fullname)
WHERE address NOT LIKE '%name=%';

--10. Toshkentdan Xorazmga boradigan yo'nalishni qaytarish uchun so'rov yozing. 
--Natija eng arzon va eng qimmat yo'nalishlarni o'z ichiga olishi kerak
;with routepaths as (
select departurecity,
arrivalcity,
cost,
cast(departurecity + ' - ' + arrivalcity as varchar(max)) as route
from #routes
where departurecity = 'tashkent'

union all
 
select p.departurecity,
r.arrivalcity,
p.cost + r.cost as cost,
cast(p.route + ' - ' + r.arrivalcity as varchar(max)) as route
from routepaths p
join #routes r
on p.arrivalcity = r.departurecity
)
 
select route, cost
from routepaths
where arrivalcity = 'khorezm'
and (cost = (select min(cost) from routepaths where arrivalcity = 'khorezm')
or cost = (select max(cost) from routepaths where arrivalcity = 'khorezm'))
order by cost;

--11. Mahsulotlarni joylashtirish tartibiga qarab tartiblang.
;with productgroups as (
select id, vals,
sum(case when vals = 'product' then 1 else 0 end) 
over (order by id rows unbounded preceding) as productgroup
from #rankingpuzzle
)
select  concat('product_', productgroup) as productgroup,
vals
from productgroups
where vals <> 'product'
order by id;

--12.Savdolari o'z bo'limidagi o'rtacha savdodan yuqori bo'lgan xodimlarni toping

select 
e.employeename,
e.department,
e.salesamount
from  #employeesales e
join (    select 
department,  avg(salesamount) as avgsales
from 
#employeesales
group by 
department
) as d
on e.department = d.department
where     e.salesamount > d.avgsales
order by     e.department, e.salesamount desc;

 --13. EXISTS yordamida har qanday oyda eng yuqori sotuvga erishgan xodimlarni toping
select     e.employeename,
e.department,
e.salesamount,
e.salesmonth,
e.salesyear
from     #employeesales e
where    not exists (
select 1 from #employeesales s
where 
s.salesmonth = e.salesmonth
and s.salesyear = e.salesyear
and s.salesamount > e.salesamount
)
order by 
e.salesyear, e.salesmonth;

--14. NOT EXISTS yordamida har oyda savdo qilgan xodimlarni toping
 select distinct e1.employeename
from #employeesales e1
where not exists (
    select distinct e2.salesmonth
from #employeesales e2
where not exists (
select 1
from #employeesales e3
where 
    e3.employeename = e1.employeename
    and e3.salesmonth = e2.salesmonth
    and e3.salesyear = e2.salesyear
));

--15. Barcha mahsulotlarning o'rtacha narxidan qimmatroq bo'lgan mahsulotlar nomlarini oling.

select name, price
from products
where price > (
select avg(price) 
from products
);
--16. Qimmatli qog'ozlar soni eng yuqori miqdordan past bo'lgan mahsulotlarni toping.
select name, stock
from products
where stock < (
select max(stock)
from products
);
--17. “Noutbuk” bilan bir xil turkumga kiruvchi mahsulotlar nomlarini oling.

select name, category
from products
where category = (
select category 
from products 
where name = 'laptop'
)
and name <> 'laptop';

--18. Narxlari Elektronika turkumidagi eng past narxdan yuqori bo'lgan mahsulotlarni oling.
select name, category, price
from products
where price > (
select min(price)
from products
where category = 'electronics'
);

--19. Narxlari tegishli toifadagi o'rtacha narxdan yuqori bo'lgan mahsulotlarni toping.
select 
p.productid,
p.name,
p.category,
p.price
from products p
where p.price > (
select avg(p2.price)
from products p2
where p2.category = p.category
);
--20. Kamida bir marta buyurtma qilingan mahsulotlarni toping.
select 
    p.productid,
    p.name,
    p.category,
    p.price
from products p
where exists (
    select 1
    from orders o
    where o.productid = p.productid
);

--21. Buyurtma qilingan o'rtacha miqdordan ko'proq buyurtma qilingan mahsulotlarning nomlarini oling.
select 
p.productid,
p.name,
p.category,
p.price
from products p
join orders o 
on p.productid = o.productid
group by p.productid, p.name, p.category, p.price
having sum(o.quantity) > (
select avg(totalquantity)
from (
    select sum(quantity) as totalquantity
    from orders
    group by productid
) as avgtable
);

--22. Hech qachon buyurtma berilmagan mahsulotlarni toping.

select 
productid,
name,
category,
price
from products
where productid not in (select distinct productid from orders);

--23. Buyurtma qilingan eng yuqori umumiy miqdorga ega mahsulotni oling.
select top 1
p.productid,
p.name,
sum(o.quantity) as totalordered
from orders o
join products p 
on o.productid = p.productid
group by p.productid, p.name
order by totalordered desc;
