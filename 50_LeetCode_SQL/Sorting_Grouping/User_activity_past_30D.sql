DROP TYPE IF EXISTS acts;
CREATE TYPE acts AS ENUM ('open_session', 'end_session', 'scroll_down', 'send_messages');
Create table If Not Exists Act (user_id int, session_id int, activity_date date, activity_type acts);
Truncate table Act
insert into Act (user_id, session_id, activity_date, activity_type) values 
(1, 1, '2019-07-20', 'open_session'),
(1, 1, '2019-07-20', 'scroll_down'),
(1, 1, '2019-07-20', 'end_session'),
(2, 4, '2019-07-20', 'open_session'),
(2, 4, '2019-07-21', 'send_messages'),
(2, 4, '2019-07-21', 'end_session'),
(3, 2, '2019-07-21', 'open_session'),
(3, 2, '2019-07-21', 'send_messages'),
(3, 2, '2019-07-21', 'end_session'),
(4, 3, '2019-06-25', 'open_session'),
(4, 3, '2019-06-25', 'end_session');


/*
This table may have duplicate rows.
The activity_type column is an ENUM (category) of type ('open_session', 'end_session', 'scroll_down', 'send_message').
The table shows the user activities for a social media website. 
Note that each session belongs to exactly one user.

 

Write a solution to find the daily active user count for a period of 30 days ending 2019-07-27 inclusively. A user was active on someday 
if they made at least one activity on that day.

Return the result table in any order.

The result format is in the following example.

Note: Any activity from ('open_session', 'end_session', 'scroll_down', 'send_message') will be considered valid activity for a user to be 
considered active on a day.
*/

SELECT 
    activity_date as day,
    COUNT(DISTINCT user_id) as active_users
FROM act
WHERE activity_date > '2019-06-25' AND activity_date < '2019-07-25'
GROUP BY day;