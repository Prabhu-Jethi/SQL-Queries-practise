alter table products
modify price float NOT NULL;

insert into products
values (104, 'ice cream', null);

select * from products;