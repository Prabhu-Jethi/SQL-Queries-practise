-- ROLLUP, extention of the GROUPBY clause
-- produces another rows and shows the GRAND TOTAL (super-aggregate value)

select count(transaction_id), order_date
from transactions
group by order_date with ROLLUP;

select count(transaction_id) as '# of orders', cust_id
from transactions
group by cust_id with ROLLUP;  

select sum(hourly_pay) as 'hourly_pay', emp_id
from emp
group by emp_id with ROLLUP; 