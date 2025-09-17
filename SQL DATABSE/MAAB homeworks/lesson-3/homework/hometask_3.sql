--Easy-Level Tasks
/* Define and explain the purpose of BULK INSERT in SQL Server.
	Answer:BULK INSERT bu SQL Serverdagi buruq bo'lib, .CSV, .TXT va boshqa formatdagi katta hajmdagi faylarni tezkor yuklash uchun ishlatiladi;

List four file formats that can be imported into SQL Server.
Answer: .CSV;	.TXT; .XML;	.JSON; */

--Create a table Products with columns: ProductID (INT, PRIMARY KEY), ProductName (VARCHAR(50)), Price (DECIMAL(10,2)).
CREATE TABLE Products (
		ProductID INT PRIMARY KEY,
		ProductName VARCHAR (50),
		Price DECIMAL (10,2)
); --Created a table Products with columns: ProductID (INT, PRIMARY KEY), ProductName (VARCHAR(50)), Price (DECIMAL(10,2))
SELECT * FROM products;

--Insert three records into the Products table using INSERT INTO.
INSERT INTO Products (ProductID, ProductName, Price)
VALUES( 1, 'samsung', 1425.25), ( 2, 'apple', 1000.65), ( 3, 'nokia', 900.75); --Inserted three records into the Products table

/* Explain the difference between NULL and NOT NULL.
bular table yaratilayotganda ustunlar uchun beriladigan constaintlar hisoblanadi.
NULL - bu qiymat mavjud emas yoki nomalum degani ,ULL bu qiymati null bo'lsin degani;
NOT NULL -  bu kiritilayotgan qiymat NULL bolishi mumkin emas degani */

--Add a UNIQUE constraint to the ProductName column in the Products table.
ALTER TABLE Products
ADD CONSTRAINT C_ProductName 
UNIQUE (ProductName) --Added a UNIQUE constraint to the ProductName column in the Products table.

--Write a comment in a SQL query explaining its purpose.
-- bir qatorlik commentlar yozish uchun ;
--/* */  bu ko'p qatorlik commentlar yozish uchun ishlatiladi 

--Add CategoryID column to the Products table.
ALTER TABLE Products
ADD CategoryID INT; --Added CategoryID column to the Products table

--Create a table Categories with a CategoryID as PRIMARY KEY and a CategoryName as UNIQUE.
CREATE TABLE Categories (
		CategoryID INT,
		CategoryName VARCHAR(50) UNIQUE,
		CONSTRAINT PK_Categories PRIMARY KEY (CategoryID)
); -- Created a table Categories

--Explain the purpose of the IDENTITY column in SQL Server.
-- SQL serverda indentity - avtomatik ravishda son berib boruvchi property hisoblanib, odatda ID ustunlar uchun ishlatiladi. indentity(1, 1) degani ID ustuni 1 dan boshlansin va oraliqni 1 dan hisoblab ket degan buyruqni anglatadi

--Medium-Level Tasks
--Use BULK INSERT to import data from a text file into the Products table.
BULK INSERT Products
FROM 'F:\Arslonbek\data_analitika\SQL DATABSE\Example_db\Products.txt'
WITH (
		ROWTERMINATOR = '\n',
		FIELDTERMINATOR = ',',
		FIRSTROW = 1
);--Used BULK INSERT to import data from a text file into the Products table.
 
--Create a FOREIGN KEY in the Products table that references the Categories table.
ALTER TABLE Products
		ADD CONSTRAINT FK_Products_Categories
		FOREIGN KEY (CategoryID) 
		REFERENCES Categories(CategoryID); --Created a FOREIGN KEY in the Products table that references the Categories table.


--Explain the differences between PRIMARY KEY and UNIQUE KEY.
--PRIMARY KEY - bu SQL da table yaratayotganimizda table design qilishda ishlatiladi. 
-- PRIMARY KEY bu qatorlardagi qiymatlarning asosiy va takrorlanmas qiymati hisoblanadi.unda takrorlangan qiymatlar va NULL qiymatlarni ham qabul qilmaydi

-- UNIQUE KEY bu unikal qiymat qabul qiluvchi constraint hisoblanadi, jadvalga  takroriy qiymat kirirtishga yo'l qo'ymaydi, lekin NULL qiymatga ruxsat berishi mumkin 


--Add a CHECK constraint to the Products table ensuring Price > 0.
ALTER TABLE products 
		ADD CONSTRAINT Ch_Products 
		CHECK (price>0);

--Modify the Products table to add a column Stock (INT, NOT NULL).
ALTER TABLE Products
ADD Stock INT NOT NULL DEFAULT 0; --Modified the Products table
 
UPDATE Products SET price = NULL WHERE price = 900.75;
SELECT ProductName, ISNULL(price,77) AS narx 
FROM Products;
--Use the ISNULL function to replace NULL values in Price column with a 0.
ALTER TABLE Products 
		DROP CONSTRAINT Ch_products
GO
UPDATE Products 
		SET price = ISNULL(price, 0);

--Describe the purpose and usage of FOREIGN KEY constraints in SQL Server.
/* SQL Serverda Foreign key biror jadvaldagi noyob va takrorlanmas qiymat saqlovchi ustunni boshqa jadvalga bo'glab olish.
bu bilan ma'lumotlarni bir nechta jadvaldan osonlik bilan olishimiz yoki boshqarishimiz mumkin bo'ladi.*/

--Hard-Level Tasks
--Write a script to create a Customers table with a CHECK constraint ensuring Age >= 18.
CREATE TABLE Customers (
		CustomerID int,
		CustomerName VARCHAR(50),
		Age INT CHECK (age>=18),
		CONSTRAINT PK_Customers PRIMARY KEY (CustomerID) 
); --created Customers table with check constraint

--Create a table with an IDENTITY column starting at 100 and incrementing by 10.
CREATE TABLE Orders (
		OrderID INT IDENTITY(100, 10),
		OrderName VARCHAR(500),
		OrderDate DATE
); --created table Orders with identity
--Write a query to create a composite PRIMARY KEY in a new table OrderDetails.
CREATE TABLE OrderDetails (
		OrderID INT NOT NULL,
		ProductID INT NOT NULL,
		Quantity INT NOT NULL,
		Price DECIMAL (10,2),
		CONSTRAINT PK_OrderDetails PRIMARY KEY (OrderID, ProductID)
); --created table OrderDetails with composite PRIMARY KEY

--Explain the use of COALESCE and ISNULL functions for handling NULL values.
-- isnull(expr, replecement) - bu ikkita argument qabul qiluvchi funksiya bo'lib, expr ni NULL ga tekshiradi, agar tasdiqlansa replecement qaytaradi
--example:select isnull(Ordername, 'Noname') from Orders;

-- coalesce (expr1, expr2,expr3..., replecement) bu ikki va undan ortiq argument qabul qiluvchi funlsiya bo'lib, expr1 ni tekshiradi, expr2 va hk tekshirib replecement qaytaradi
--example: select coalesce (name, lastname, country, 'Unknown') from Employees;

--Create a table Employees with both PRIMARY KEY on EmpID and UNIQUE KEY on Email.
CREATE TABLE Employees (
		EmpID INT,
		EmpName VARCHAR (100),
		Email VARCHAR(50) UNIQUE,
		CONSTRAINT PK_Employees PRIMARY KEY (EmpID)
);--created table Employees with primary key and unique

--Write a query to create a FOREIGN KEY with ON DELETE CASCADE and ON UPDATE CASCADE options.
--for parent table
CREATE TABLE OnlineOrders(
		OrderID int,
		OrderName VARCHAR(50)
		CONSTRAINT PK_OnlineOrders PRIMARY KEY (OrderID)
);
-- for child table 
CREATE TABLE OrderHumans(
		HumanID INT,
		HumanName VARCHAR(50),
		OrderID INT,
		Quantity INT CHECK (Quantity>0),
		CONSTRAINT PK_OrderHumans PRIMARY KEY (HumanID),
		CONSTRAINT FK_Order_Humans_OnlineOrders
		FOREIGN KEY (OrderID)
		REFERENCES OnlineOrders (OrderID)
		ON DELETE CASCADE
		ON UPDATE CASCADE
);--Wrote a query to create a FOREIGN KEY with ON DELETE CASCADE and ON UPDATE CASCADE options.







