-- LIMIT clause is used to limit the numbers of records.
-- Useful if you're working with a lot of data.
-- Can be used to display a large data on pages.

select * from customers
order by last_name desc LIMIT 2;

select * from customers
LIMIT 1, 2;