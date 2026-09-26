Create table Customer (id int, name varchar(25), referee_id int)
Truncate table Customer
insert into Customer (id, name, referee_id) values 
('1', 'Will', NULL),
('2', 'Jane', NULL),
('3', 'Alex', '2'),
('4', 'Bill', NULL),
('5', 'Zack', '1'),
('6', 'Mark', '2');


-- Find the names of the customer that are either:

   -- 1. referred by any customer with id != 2.
   -- 2. not referred by any customer.

SELECT name
FROM Customer
WHERE referee_id != 2 or referee_id IS NULL;
