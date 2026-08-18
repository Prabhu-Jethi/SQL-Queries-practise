-- INDEX (BTree data structure)
-- Indexes are used to find values within a specific column more quickly
-- MySQL normally searches sequentially through a column
-- The longer the column, the more expensive the operation is
-- UPDATE takes more time, SELECT takes less time

SHOW INDEXES from customers;

create INDEX last_name_idx
on customers(last_name);

alter table customers
drop INDEX last_name_idx;