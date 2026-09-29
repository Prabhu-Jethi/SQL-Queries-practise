DROP TYPE IF EXISTS approved_declined_enum;
Create type approved_declined_enum AS enum ('approved', 'declined');
Create table If Not Exists Trans (id int, country varchar(4), state approved_declined_enum, amount INT, trans_date date)
Truncate table Trans
insert into Trans (id, country, state, amount, trans_date) values 
(121, 'US', 'approved', 1000, '2018-12-18'),
(122, 'US', 'declined', 2000, '2018-12-19'),
(123, 'US', 'approved', 2000, '2019-01-01'),
(124, 'DE', 'approved', 2000, '2019-01-07');


/*
id is the primary key of this table.
The table has information about incoming transactions.
The state column is an enum of type ["approved", "declined"].

Write an SQL query to find for each month and country, the number of transactions and their total amount, the number of approved transactions and 
their total amount.

Return the result table in any order.
*/

SELECT
    to_char(trans_date, 'YYYY-MM') as month,
    country,
    count(*) as trans_count,
    count(state) FILTER (WHERE state = 'approved') as approved_count,
    sum(amount) as trans_total_amount,
    COALESCE(sum(amount) FILTER (WHERE state = 'approved'), 0) as approved_total_amount
FROM trans
GROUP BY month, country