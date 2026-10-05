Create table If Not Exists Followers(user_id int, follower_id int)
Truncate table Followers
insert into Followers (user_id, follower_id) values 
('0', '1'),
('1', '0'),
('2', '0'),
('2', '1');

/*
(user_id, follower_id) is the primary key (combination of columns with unique values) for this table.
This table contains the IDs of a user and a follower in a social media app where the follower follows the user.

 
Write a solution that will, for each user, return the number of followers.

Return the result table ordered by user_id in ascending order.

*/


SELECT user_id, count(follower_id) as followers_count
FROM followers
GROUP BY user_id
ORDER BY user_id ASC;
