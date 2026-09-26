Create table If Not Exists Visits(visit_id int, customer_id int);
Create table If Not Exists Transactions(transaction_id int, visit_id int, amount int);
Truncate table Visits
insert into Visits (visit_id, customer_id) values 
('1', '23'),
('2', '9'),
('4', '30'),
('5', '54'),
('6', '96'),
('7', '54'),
('8', '54');
Truncate table Transactions
insert into Transactions (transaction_id, visit_id, amount) values 
('2', '5', '310'),
('3', '5', '300'),
('9', '5', '200'),
('12', '1', '910'),
('13', '2', '970');


/*
visit_id is the column with unique values for this table.
This table contains information about the customers who visited the mall.

transaction_id is column with unique values for this table.
This table contains information about the transactions made during the visit_id.

 

Write a solution to find the IDs of the users who visited without making any transactions and the number of times they made these types of visits.

Return the result table sorted in any order.
*/

SELECT v.customer_id, count(v.visit_id) as count_no_trans
from visits v
LEFT JOIN transactions t on v.visit_id = t.visit_id
WHERE t.visit_id is NULL
GROUP BY v.customer_id
ORDER BY count_no_trans DESC;

