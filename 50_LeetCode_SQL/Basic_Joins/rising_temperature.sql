Create table If Not Exists Weather (id int, recordDate date, temperature int);
Truncate table Weather
insert into Weather (id, recordDate, temperature) values 
('1', '2015-01-01', '10'),
('2', '2015-01-02', '25'),
('3', '2015-01-03', '20'),
('4', '2015-01-04', '30');


/*
id is the column with unique values for this table.
There are no different rows with the same recordDate.
This table contains information about the temperature on a certain day.

 

Write a solution to find all dates' id with higher temperatures compared to its previous dates (yesterday).

Return the result table in any order.
*/

SELECT w2.id as id
FROM Weather w1
CROSS JOIN Weather w2 
WHERE (w2.recordDate - w1.recordDate) = 1 AND w2.temperature > w1.temperature;


-- In POSTGRES (Date1 - Date2) is correct ✅
-- Datediff(date1, date2) is incorrect ❌