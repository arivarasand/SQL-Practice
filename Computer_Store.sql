/*Create a database Computer_Store*/
Create database Computer_Store;

/*Create 2 table Manufacturers and Products in the newly created database*/
use Computer_Store;


CREATE TABLE Manufacturers (
  Code INTEGER,
  Name VARCHAR(255) NOT NULL,
  PRIMARY KEY (Code)   
);

CREATE TABLE Products (
  Code INTEGER,
  Name VARCHAR(255) NOT NULL ,
  Price DECIMAL NOT NULL ,
  Manufacturer INTEGER NOT NULL,
  PRIMARY KEY (Code), 
  FOREIGN KEY (Manufacturer) REFERENCES Manufacturers(Code) on delete cascade);


/*Insert data into the newly created tables*/

INSERT INTO Manufacturers(Code,Name) VALUES(1,'Sony');
INSERT INTO Manufacturers(Code,Name) VALUES(2,'Creative Labs');
INSERT INTO Manufacturers(Code,Name) VALUES(3,'Hewlett-Packard');
INSERT INTO Manufacturers(Code,Name) VALUES(4,'Iomega');
INSERT INTO Manufacturers(Code,Name) VALUES(5,'Fujitsu');
INSERT INTO Manufacturers(Code,Name) VALUES(6,'Winchester');

INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(1,'Hard drive',240,5);
INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(2,'Memory',120,6);
INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(3,'ZIP drive',150,4);
INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(4,'Floppy disk',5,6);
INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(5,'Monitor',240,1);
INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(6,'DVD drive',180,2);
INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(7,'CD drive',90,2);
INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(8,'Printer',270,3);
INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(9,'Toner cartridge',66,3);
INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(10,'DVD burner',180,2);

select * from Products;
select * from Manufacturers;

 /*1.Select the names of all the products in the store*/

 select Name from Products;

 /* 2. Select the names and the prices of all the products in the store.*/
 select Name,Price from Products;

 /*3. Select the name of the products with a price less than or equal to $200*/
 select Name from Products where Price <=200 ;

 /*4. Select all the products with a price between $60 and $120.*/
 select * from Products where Price between 60 and 120;

 /*5. Select the name and price in cents (i.e., the price must be multiplied by 100).*/
 select Name,Price=Price*100 from Products;

 /*6. Compute the average price of all the products.*/
 select AVG(Price) as Avg_Price from Products;

 /*7. Compute the average price of all products with manufacturer code equal to 2*/
 select avg(Price) as Avg_Price from Products where code =2;

 /*8. Compute the number of products with a price larger than or equal to $180.*/
 select count(*) from Products where Price >=180;

/*9. Select the name and price of all products with a price larger than or equal to $180, and 
sort first by price (in descending order), and then by name (in ascending order).*/
 select Name,Price from Products 
 where Price >=180
 order by Price desc,Name asc;

/*10. Select all the data from the products, including all the data for each product's manufacturer.*/
 select a.* from Products a join
 Manufacturers b on a.Code=b.Code;

/*11. Select the product name, price, and manufacturer name of all the products.*/
 select a.Name,a.Price,b.Name as manufacturer_name from Products a
 join Manufacturers b on a.Code=b.Code;

/*12. Select the average price of each manufacturer's products, showing only the manufacturer's code.*/

   select avg(Price) as Avg_Price, Manufacturers.Code
   from Products INNER JOIN Manufacturers
   on Products.Manufacturer = Manufacturers.Code
   group by Manufacturers.Code
   order by Avg_Price;

 /*13. Select the average price of each manufacturer's products, showing the manufacturer's name.*/

   select avg(Price) as Avg_Price, Manufacturers.Name
   from Products INNER JOIN Manufacturers
   on Products.Manufacturer = Manufacturers.Code
   group by Manufacturers.Name
   order by Avg_Price;

/*14. Select the names of manufacturer whose products have an average price larger than or equal to $150.*/

 select a.Name, avg(b.Price) as Avg_price from Manufacturers a
 Join Products b on a.code =b.Manufacturer
 group by a.Name
 having  avg(b.Price)>=150
 order by a.Name;

 /*15. Select the name and price of the cheapest product.*/

 select Name,Price from Products
 where price=(select min(price) from products);

 /*16. Select the name of each manufacturer along with the name and price of its most expensive product.*/

 select Manufacturers.Name as Manufacturer_Name,Products.Name as Producets_name,Products.Price 
 from Products join Manufacturers 
 on Products.Manufacturer=Manufacturers.Code
 and Products.Price in ( select max(Products.Price) from Products 
 where Products.Manufacturer=Manufacturers.Code);

 /*Select the name of each manufacturer which have an average price above $145 and contain at least 2 different products.*/

Select DISTINCT a.Name as Manufacturer_Name, a.Code
 FROM Manufacturers a
 JOIN Products b
 ON b.Manufacturer = a.code
 WHERE b.Manufacturer in (
	SELECT DISTINCT b.Manufacturer
	FROM Products b
	GROUP BY b.Manufacturer
	HAVING AVG(b.Price) >= 150 AND COUNT(b.Manufacturer) >=2
);

/*18. Add a new product: Loudspeakers, $70, manufacturer 2.*/
	insert into products( Code, Name , Price , Manufacturer)
	values ( 11, 'Loudspeakers' , 70 , 2 );

/*19. Update the name of product 8 to "Laser Printer".*/

   UPDATE Products
   SET Name = 'Laser Printer'
   WHERE Code = 8;

/*20. Apply a 10% discount to all products.*/

   UPDATE Products
   SET Price = Price - (Price * 0.1);

/*21. Apply a 10% discount to all products with a price larger than or equal to $120*/

   UPDATE Products
   SET Price = Price - (Price * 0.1)
   WHERE Price >= 120;
