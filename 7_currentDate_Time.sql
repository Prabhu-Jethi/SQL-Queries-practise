create table test(
	my_date date,
    my_time time,
    my_datetime datetime
);
insert into test
-- values (current_date(), current_time(), now());
-- values (current_date()+1, null, null);-- 
values (current_date()-1, null, null);

select * from test;

drop table test;