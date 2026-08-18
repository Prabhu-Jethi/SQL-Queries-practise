-- wild card characters % _
-- used to substitute one or more characters in a string

select * from Emp;

select * from Emp
where first_name LIKE "j%";
select * from Emp
where hire_date LIKE "2025%";
select * from Emp
where last_name LIKE "%e"; 
select * from Emp
where hire_date LIKE "____-07-__";