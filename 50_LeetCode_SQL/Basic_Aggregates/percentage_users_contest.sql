
Create table If Not Exists Users (user_id int, user_name varchar(20))
Create table If Not Exists Register (contest_id int, user_id int)
Truncate table Users
insert into Users (user_id, user_name) values 
('6', 'Alice'),
('2', 'Bob'),
('7', 'Alex');
Truncate table Register
insert into Register (contest_id, user_id) values 
('215', '6'),
('209', '2'),
('208', '2'),
('210', '6'),
('208', '6'),
('209', '7'),
('209', '6'),
('215', '7'),
('208', '7'),
('210', '2'),
('207', '2'),
('210', '7');


/*
Users
user_id is the primary key (column with unique values) for this table.
Each row of this table contains the name and the id of a user.

Register
(contest_id, user_id) is the primary key (combination of columns with unique values) for this table.
Each row of this table contains the id of a user and the contest they registered into.

 

Write a solution to find the percentage of the users registered in each contest rounded to two decimals.

Return the result table ordered by percentage in descending order. In case of a tie, order it by contest_id in ascending order.
*/

select distinct r.contest_id,
    round(count(distinct r.user_id) * 100 / (select count(*) from users)::numeric, 2) as percentage 
From register r
left join users u on r.user_id = u.user_id
group by r.contest_id
order by percentage desc, r.contest_id asc;