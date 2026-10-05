Create table If Not Exists Cust (customer_id int, product_key int)
Create table Prod (product_key int)
Truncate table Cust
insert into Cust (customer_id, product_key) values 
('1', '5'),
('2', '6'),
('3', '5'),
('3', '6'),
('1', '6');
Truncate table Prod
insert into Prod (product_key) values 
('5'),
('6');


/*
This table may contain duplicates rows. 
customer_id is not NULL.
product_key is a foreign key (reference column) to Product table.

product_key is the primary key (column with unique values) for this table.


Write a solution to report the customer ids from the Customer table that bought all the products in the Product table.

Return the result table in any order.
*/


SELECT cu.customer_id
FROM cust cu
GROUP BY cu.customer_id
HAVING COUNT(DISTINCT product_key) = (
    SELECT COUNT(p.product_key)
    FROM prod p
)