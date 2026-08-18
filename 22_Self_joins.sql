-- SELF JOIN
-- join another copy of a table to itself
-- used to compare rows of the same table
-- helps to display a hierarchy of data

alter table customers
add referral_id int;

update customers
set referral_id = 4
where cust_id = 5;

delete from customers
where referral_id = 4;

select * from customers;

select A.cust_id, A.first_name, A.last_name,
       concat(B.first_name, ' ', B.last_name) as 'referred_by'
from customers as A
inner join customers as B
on A.referral_id = B.cust_id;


alter table emp
add supervisor_id int;

update emp
set supervisor_id = 1
where emp_id = 5;
select * from emp;

select A.emp_id, A.first_name, A.last_name,
       concat(B.first_name, ' ', B.last_name) as 'reports to'
from emp as A
inner join emp as B
on A.supervisor_id = B.emp_id;