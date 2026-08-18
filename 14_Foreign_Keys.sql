create table customers(
	cust_id int primary key auto_increment,
    first_name varchar(30),
    last_name varchar(30)
);
insert into customers (first_name, last_name)
values ('Jacob', 'Polenski'),
       ('Alfie', 'Stronkers'), 
       ('Edward', 'Addams'), 
       ('Xavier', 'Bartlett');
insert into customers (first_name, last_name)
values ('Puff', 'Puffers');

select * from customers; 
-- delete from customers;
-- drop table customers; 

create table transactions(
	transaction_id int primary key auto_increment,
    amount decimal (5,2),
    cust_id int,
    FOREIGN KEY(cust_id) REFERENCES customers(cust_id)
);
alter table transactions
auto_increment = 1000;
insert into transactions(amount, cust_id)
values (25.42, 3), 
	   (46.97, 1), 
       (251.32, 2), 
       (87.21, 1),
       (242.12, 4);
select * from transactions;

alter table transactions
drop FOREIGN KEY fk_cust_id;

alter table transactions
add constraint fk_cust_id
FOREIGN KEY(cust_id) REFERENCES customers(cust_id);