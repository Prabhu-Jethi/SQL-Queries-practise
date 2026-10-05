Create table If Not Exists MyNumbers (num int)
Truncate table MyNumbers
insert into MyNumbers (num) values 
('8'),
('8'),
('3'),
('3'),
('1'),
('4'),
('5'),
('6');


/*
This table may contain duplicates (In other words, there is no primary key for this table in SQL).
Each row of this table contains an integer.

 

A single number is a number that appeared only once in the MyNumbers table.

Find the largest single number. If there is no single number, report null.
*/

SELECT MAX(num) as largest_num
FROM (
    SELECT num
    FROM MyNumbers
    GROUP BY num
    HAVING COUNT(num) = 1
)

