Create table If Not Exists Item (Item_id int, new_price int, change_date date)
Truncate table Item
insert into Item (Item_id, new_price, change_date) values 
('1', '20', '2019-08-14'),
('2', '50', '2019-08-14'),
('1', '30', '2019-08-15'),
('1', '35', '2019-08-16'),
('2', '65', '2019-08-17'),
('3', '20', '2019-08-18');


/*
(product_id, change_date) is the primary key (combination of columns with unique values) of this table.
Each row of this table indicates that the price of some product was changed to a new price at some date.

Initially, all products have price 10.

Write a solution to find the prices of all products on the date 2019-08-16.

Return the result table in any order.
*/

SELECT item_id, new_price As Price
FROM Item
WHERE (item_id, change_date) IN (
    SELECT Item_id, max(change_date)
    FROM Item
    WHERE change_date <= '2019-08-16'
    GROUP BY item_id
)
UNION
SELECT item_id, 10 AS Price
FROM Item
WHERE item_id NOT IN (
    SELECT item_id
    FROM Item
    WHERE change_date <= '2019-08-16'
)