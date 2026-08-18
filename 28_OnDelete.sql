-- ON DELETE SET NULL -> when a FK is deleted, replace the FK with NULL
-- ON DELETE CASCADE -> when a FK is deleted, delete row

alter table transactions drop foreign key fk_cust_id;

alter table transactions
add constraint fk_cust_id
foreign key(cust_id) references customers(cust_id)
ON DELETE SET NULL;

alter table transactions
add constraint fk_transaction_id
foreign key(cust_id) references customers(cust_id)
ON DELETE CASCADE;

delete from customers
where cust_id = 1;

select * from customers;
select * from transactions;