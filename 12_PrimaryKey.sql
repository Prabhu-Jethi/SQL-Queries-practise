alter table Emp
add constraint 
PRIMARY KEY (emp_id);

insert into Emp
values (7, 'John', 'Morris', 'johnmorris12@gmail.com', 24.12, '2025-12-10');

select * from Emp;