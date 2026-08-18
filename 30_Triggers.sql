-- TRIGGER = When an event happens, do something
-- ex: UPDATE, DELETE, INSERT
-- checks data, handles error, auditing tables

select * from emp;
alter table emp
add column salary decimal (10, 2) after hourly_pay;
update emp
set salary = hourly_pay * 2080;

create TRIGGER before_hourly_pay_update
before update on emp
for each row
set new.salary = (new.hourly_pay * 2080);

show TRIGGERS;
