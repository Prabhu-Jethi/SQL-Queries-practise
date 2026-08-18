select * from products;

-- insert into products
-- values (104, 'Straw', 0.00),
-- 	   (105, 'Fork', 0.00),
--        (106, 'Napkin', 0.00),
--        (107, 'Ketchup', 0.00);

delete from products
where prod_id >= 104;

alter table products
alter price set DEFAULT 0;

insert into products (prod_id, prod_name)
values (104, 'Straw'),
	   (105, 'Fork'),
       (106, 'Napkin'),
       (107, 'Ketchup');
       
-- create table transactions (
-- 	transaction_id int,
--     amount decimal (5, 2),
--     transaction_date datetime default now()
-- );
-- insert into transactions (transaction_id, amount)
-- values (1, 45.78);
-- select * from transactions;
-- drop table transactions;
