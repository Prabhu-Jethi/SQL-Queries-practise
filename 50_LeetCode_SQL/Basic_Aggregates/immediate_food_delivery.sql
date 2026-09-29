Create table If Not Exists Delivery (delivery_id int, customer_id int, order_date date, customer_pref_delivery_date date)
Truncate table Delivery
insert into Delivery (delivery_id, customer_id, order_date, customer_pref_delivery_date) values 
('1', '1', '2019-08-01', '2019-08-02'),
('2', '2', '2019-08-02', '2019-08-02'),
('3', '1', '2019-08-11', '2019-08-12'),
('4', '3', '2019-08-24', '2019-08-24'),
('5', '3', '2019-08-21', '2019-08-22'),
('6', '2', '2019-08-11', '2019-08-13'),
('7', '4', '2019-08-09', '2019-08-09');


/* 
delivery_id is the column of unique values of this table.
The table holds information about food delivery to customers that make orders at some date and specify a preferred delivery date (on the same order 
date or after it).

 

If the customer's preferred delivery date is the same as the order date, then the order is called immediate; otherwise, it is called scheduled.

The first order of a customer is the order with the earliest order date that the customer made. It is guaranteed that a customer has precisely 
one first order.

Write a solution to find the percentage of immediate orders in the first orders of all customers, rounded to 2 decimal places.
*/


WITH first_order AS (
    SELECT customer_id, MIN(order_date) as orderD, MIN(customer_pref_delivery_date) as deliD
    FROM delivery
    GROUP BY customer_id
)
SELECT 
    ROUND(
        AVG(CASE WHEN f.orderD = f.deliD THEN 1 ELSE 0 END) * 100::numeric, 2
    )as immediate_percentage
FROM first_order f