alter table Emp
add column job varchar(20) after hourly_pay;

select * from Emp;

update Emp
set job = 'developer'
where emp_id = 7;

select *
from Emp
where hire_date < "2024-07-18" AND job = "hr";

select *
from Emp
where job = "team lead" OR job = "asst. manager";

select *
from Emp
where NOT job = "investors" AND NOT job = "asst. manager";

select *
from Emp
where hire_date BETWEEN "2024-10-01" AND "2025-12-02";

select *
from Emp
where job IN ('manager', 'investors', 'developer');
