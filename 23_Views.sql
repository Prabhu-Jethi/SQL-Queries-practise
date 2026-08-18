-- VIEWS
-- A virtual table based on the result-set of an SQL statement.
-- The fields in a view are fields from one or more real tables in the databases.
-- They're not real tables, but can be interacted with as if they were.
select * from emp;

create VIEW employees_attendance as
select first_name, last_name
from emp;
select * from employees_attendance;
drop VIEW employees_attendance;

alter table customers
add column email varchar(30);
update customers
set email = 'Imjacobpols@gmail.com'
where cust_id = 1;
select * from customers;

create VIEW cust_emails as
select email
from customers;
select * from cust_emails;