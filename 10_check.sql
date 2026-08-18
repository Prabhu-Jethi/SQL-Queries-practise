alter table Emp
add constraint chk CHECK(hourly_pay >= 10.00);

insert into Emp
values (6, 'Sheldon', 'Hamstone', 'sheldon123@gmail.com', 10.00, '2025-12-02'),
	   (7, 'Matt', 'Hayden', 'imatthayden@gamil.com', 8.24, '2025-12-04');

alter table Emp
drop CHECK chk;

select * from Emp;