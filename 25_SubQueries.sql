select first_name, last_name, hourly_pay,
		(select avg(hourly_pay) from emp) as avg_pay
from emp;

select first_name, last_name, hourly_pay
from emp
where hourly_pay > (select avg(hourly_pay) from emp);

select first_name, last_name
from customers
where cust_id NOT IN
(select DISTINCT cust_id
from transactions
where cust_id IS NOT NULL);
