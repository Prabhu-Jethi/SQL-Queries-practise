Create table If Not Exists Prices (product_id int, start_date date, end_date date, price int)
Create table If Not Exists UnitsSold (product_id int, purchase_date date, units int)
Truncate table Prices
insert into Prices (product_id, start_date, end_date, price) values 
('1', '2019-02-17', '2019-02-28', '5'),
('1', '2019-03-01', '2019-03-22', '20'),
('2', '2019-02-01', '2019-02-20', '15'),
('2', '2019-02-21', '2019-03-31', '30');
Truncate table UnitsSold
insert into UnitsSold (product_id, purchase_date, units) values 
('1', '2019-02-25', '100'),
('1', '2019-03-01', '15'),
('2', '2019-02-10', '200'),
('2', '2019-03-22', '30');


/*
Price
(product_id, start_date, end_date) is the primary key (combination of columns with unique values) for this table.
Each row of this table indicates the price of the product_id in the period from start_date to end_date.
For each product_id there will be no two overlapping periods. That means there will be no two intersecting periods for the same product_id.

UnitsSold
This table may contain duplicate rows.
Each row of this table indicates the date, units, and product_id of each product sold.

Write a solution to find the average selling price for each product. average_price should be rounded to 2 decimal places.
If a product does not have any sold units, its average selling price is assumed to be 0.

Return the result table in any order.
*/

SELECT
    p.product_id,
    COALESCE(ROUND(SUM(units * price) / sum(units)::NUMERIC, 2), 0) as average_price
FROM Prices p
LEFT JOIN UnitsSold us on p.product_id = us.product_id AND us.purchase_date BETWEEN start_date AND end_date
GROUP BY p.product_id

