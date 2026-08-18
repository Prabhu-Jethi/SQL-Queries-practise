-- GROUPBY = aggregate all rows by a specific column
--           often used with aggregate functions
--           ex. SUM(), MAX(), MIN(), AVG(), COUNT()

select * from transactions;

alter table transactions
add column order_date date;
update transactions
set order_date = '2025-01-03'
where transaction_id = 1004;

select SUM(amount), cust_id
from transactions
GROUP BY cust_id; 

select MAX(amount), order_date
from transactions
GROUP BY order_date; 

select MIN(amount), order_date
from transactions
GROUP BY order_date; 

select AVG(amount), order_date
from transactions
GROUP BY order_date; 

select COUNT(amount), cust_id
from transactions
GROUP BY cust_id
HAVING COUNT(amount) > 1; -- 'having' used instead of 'where' 