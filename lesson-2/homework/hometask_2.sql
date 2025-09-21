create database MAAB_db --created MAAB_db for homework

use MAAB_db
-- Basic-Level Tasks (10)

create table Employees (
EmpID int,
name VARCHAR (50),
Salary DECIMAL (10,2)
); --Created a table Employees with columns: EmpID INT, Name (VARCHAR(50)), and Salary (DECIMAL(10,2)).
 

insert into Employees (EmpID, name, Salary) values (1, 'ahmad', 1250.12);
insert into Employees values (2, 'Eshmat', 1452.36), (3, 'Noila', 1552.36), (4, 'Nargiza', 1052.36);  --Inserted three records into the Employees table using different INSERT INTO approaches (single-row insert and multiple-row insert).

update Employees set salary=7000 where EmpID = 1; --Updated the Salary of an employee to 7000 where EmpID = 1.

delete from Employees where EmpID = 2; --Deleted a record from the Employees table where EmpID = 2.

 -- DELETE - this statement is delete values where into the  table --Give a brief definition for difference between DELETE.
 -- The TRUNCATE statement deletes all the values inside a table at once.--Give a brief definition for difference between TRUNCATE.
-- The DROP statement deletes table--Give a brief definition for difference between DROP.

alter table Employees alter column name VARCHAR(100); --Modified the Name column in the Employees table to VARCHAR(100).

alter table Employees add Department VARCHAR(50); --Added a new column Department (VARCHAR(50)) to the Employees table.
 
 alter table Employees alter column salary FLOAT; --Changed the data type of the Salary column to FLOAT.
 
create table Departments (
DepartmentID int Primary key,
DepartmentName VARCHAR (50)
); --Created another table Departments with columns DepartmentID (INT, PRIMARY KEY) and DepartmentName (VARCHAR(50)).
 
 delete  from Employees ; --Removed all records from the Employees table without deleting its structure.

-- Intermediate-Level Task
select * from Departments;
alter table Departments  add salary float;

insert into Departments values (1, 'marketing'), (2, 'analyse'), (3, 'design'), (4, 'sale'), (5, 'HR');--Inserted five records into the Departments table using INSERT INTO SELECT method(you can write anything you want as data).

update Departments set salary = 3000 where DepartmentID= 1;--(DepartmentID, salary) values (1, 3000) ,(2, 4000),(3, 5000),(4, 6000),(5, 7000)
update Departments set salary = 4000 where DepartmentID= 2;
update Departments set salary = 5000 where DepartmentID= 3;
update Departments set salary = 6000 where DepartmentID= 4;
update Departments set salary = 7000 where DepartmentID= 5;

update Departments set DepartmentName = 'Management' where salary>5000; --Updated the Department of all employees where Salary > 5000 to 'Management'.

delete from Employees; --Writed a query that removes all employees but keeps the table structure intact.
 
alter table Employees drop column Department; --Droped the Department column from the Employees table.

EXEC sp_rename 'Employees', 'StaffMembers';--Renamed the Employees table to StaffMembers using SQL commands.

drop table Departments; --Writed a query to completely remove the Departments table 

--Advanced-Level Tasks
create table Product (
ProductID int PRIMARY KEY,
ProductName VARCHAR(50),
Category VARCHAR (100),
Price Decimal (10,2)
); --Created a table name Products with at least 5 columns, including: ProductID (Primary Key), ProductName (VARCHAR), Category (VARCHAR), Price (DECIMAL)

alter table Product add constraint CHK_Price check (Price>0); --Added a CHECK constraint to ensure Price is always greater than 0.

alter table Product add StockQuantity int default  50; --Modified the table to add a StockQuantity column with a DEFAULT value of 50.

EXEC sp_rename 'Product.Category', 'ProductCategory', 'COLUMN'; --Renamed Category to ProductCategory
 
insert into Product values (1, 'paxta', 'QishloqXo''jaligi', 5000, 120);--Inserted 5 records into the Products table using standard INSERT INTO queries.
insert into Product values (2, 'mashina', 'avtomobilSanoati', 4000, 55), (3, 'olma', 'OziqOvqat', 1235, 140),(4, 'trimol', 'Farmaseftika', 100, 170), (5, 'temir', 'Og''irSanoat', 5000, 69);

SELECT * 
into Product_backup
from Product; --Used SELECT INTO to create a backup table called Products_Backup containing all Products data.

EXEC sp_rename 'Product', 'Inventory', 'Object'; --Renamed the Products table to Inventory.

Alter table Inventory drop constraint CHK_Price; -- Avval Inventory jadvalidagi constraintni o'chirib tashladim 

alter table Inventory alter column Price FLOAT; --Altered the Inventory table to change the data type of Price from DECIMAL(10,2) to FLOAT.

Alter table Inventory add ProductCode int identity (1000, 5); --Added an IDENTITY column named ProductCode that starts from 1000 and increments by 5 to Inventory table.

select * from Inventory; -- select final result 