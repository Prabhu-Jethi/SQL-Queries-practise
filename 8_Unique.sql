create table products (
	prod_id int,
    prod_name varchar(50),
    price float
);

alter table products
add constraint UNIQUE
value (prod_name);

insert into products
values (100, 'Hamburger', 78.45),
	   (101, 'Doritos', 20.25),
       (102, 'Popcorn', 134.78),
       (103, 'Pepsi', 57.36);
       
select * from products;