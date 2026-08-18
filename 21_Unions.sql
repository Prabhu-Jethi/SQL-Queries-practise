-- UNION operator combines the results of two or more SELECT statements.

select first_name, last_name from Emp
UNION
select first_name, last_name from customers;