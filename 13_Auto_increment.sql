create table transactions(
	trans_id int primary key AUTO_INCREMENT,
    amount decimal (5, 2)
);
insert into transactions(amount)
values (144.15);

alter table transactions
AUTO_INCREMENT = 1000;

delete from transactions;

select * from transactions;