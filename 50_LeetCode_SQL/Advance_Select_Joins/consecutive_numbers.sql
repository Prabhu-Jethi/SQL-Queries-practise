Create table If Not Exists Logs (id int, num int)
Truncate table Logs
insert into Logs (id, num) values 
('1', '1'),
('2', '1'),
('3', '1'),
('4', '2'),
('5', '1'),
('6', '2'),
('7', '2');

/*
In SQL, id is the primary key for this table.
id is an autoincrement column starting from 1.


Find all numbers that appear at least three times consecutively.

Return the result table in any order.
*/

WITH CTE AS (
    SELECT
        num,
        LEAD(num, 1) OVER() num1,
        LEAD(num, 2) OVER() num2
    FROM logs
)
SELECT DISTINCT num AS ConsecutiveNums
FROM CTE
WHERE num = num1 AND num = num2;
