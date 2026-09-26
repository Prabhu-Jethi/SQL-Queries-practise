Create table If Not Exists Sales (sale_id int, product_id int, year int, quantity int, price int);
Create table If Not Exists Product (product_id int, product_name varchar(10));
Truncate table Sales
insert into Sales (sale_id, product_id, year, quantity, price) values 
('1', '100', '2008', '10', '5000'),
('2', '100', '2009', '12', '5000'),
('7', '200', '2011', '15', '9000');
Truncate table Product
insert into Product (product_id, product_name) values 
('100', 'Nokia'),
('200', 'Apple'),
('300', 'Samsung');


/*
(sale_id, year) is the primary key (combination of columns with unique values) of this table.
product_id is a foreign key (reference column) to Product table.
Each row of this table shows a sale on the product product_id in a certain year.
Note that the price is per unit.

product_id is the primary key (column with unique values) of this table.
Each row of this table indicates the product name of each product.

 

Write a solution to report the product_name, year, and price for each sale_id in the Sales table.

Return the resulting table in any order.
*/


SELECT p.product_name, s.year, s.price
FROM Sales as s
INNER JOIN Product as p ON s.product_id = p.product_id
