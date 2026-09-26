Create table If Not Exists Signups (user_id int, time_stamp TIMESTAMP)
CREATE TYPE confirmed_timeout_enum as ENUM ('confirmed', 'timeout');
Create table If Not Exists Confirmations (user_id int, time_stamp TIMESTAMP, action confirmed_timeout_enum)
Truncate table Signups
insert into Signups values 
('3', '2020-03-21 10:16:13'),
('7', '2020-01-04 13:57:59'),
('2', '2020-07-29 23:09:44'),
('6', '2020-12-09 10:39:37');
Truncate table Confirmations
insert into Confirmations values 
('3', '2021-01-06 03:30:46', 'timeout'),
('3', '2021-07-14 14:00:00', 'timeout'),
('7', '2021-06-12 11:57:29', 'confirmed'),
('7', '2021-06-13 12:58:28', 'confirmed'),
('7', '2021-06-14 13:59:27', 'confirmed'),
('2', '2021-01-22 00:00:00', 'confirmed'),
('2', '2021-02-28 23:59:59', 'timeout');

/*
Signups:
user_id is the column of unique values for this table.
Each row contains information about the signup time for the user with ID user_id.

Confirmations:
(user_id, time_stamp) is the primary key (combination of columns with unique values) for this table.
user_id is a foreign key (reference column) to the Signups table.
action is an ENUM (category) of the type ('confirmed', 'timeout')
Each row of this table indicates that the user with ID user_id requested a confirmation message at time_stamp and that confirmation 
message was either confirmed ('confirmed') or expired without confirming ('timeout').

 

The confirmation rate of a user is the number of 'confirmed' messages divided by the total number of requested confirmation messages. 
The confirmation rate of a user that did not request any confirmation messages is 0. Round the confirmation rate to two decimal places.

Write a solution to find the confirmation rate of each user.

Return the result table in any order.
*/

SELECT 
    s.user_id, 
    ROUND(AVG(CASE WHEN cf.action = 'confirmed' THEN 1 ELSE 0 END)::numeric, 2) as confirmed_rate
FROM Signups s
LEFT JOIN Confirmations cf on s.user_id = cf.user_id
GROUP BY s.user_id

