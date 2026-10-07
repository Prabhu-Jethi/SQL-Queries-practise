Create table If Not Exists Queue (person_id int, person_name varchar(30), weight int, turn int)
Truncate table Queue
insert into Queue (person_id, person_name, weight, turn) values 
('5', 'Alice', '250', '1'),
('4', 'Bob', '175', '5'),
('3', 'Alex', '350', '2'),
('6', 'John Cena', '400', '3'),
('1', 'Winston', '500', '6'),
('2', 'Marie', '200', '4');

/*
person_id column contains unique values.
This table has the information about all people waiting for a bus.
The person_id and turn columns will contain all numbers from 1 to n, where n is the number of rows in the table.
turn determines the order of which the people will board the bus, where turn=1 denotes the first person to board and turn=n denotes the last person to board.
weight is the weight of the person in kilograms.

 

There is a queue of people waiting to board a bus. However, the bus has a weight limit of 1000 kilograms, so there may be some people who cannot board.

Write a solution to find the person_name of the last person that can fit on the bus without exceeding the weight limit. The test cases are generated such that the first person does not exceed the weight limit.

Note that only one person can board the bus at any given turn.
*/

SELECT q1.person_name
FROM queue q1
CROSS JOIN queue q2
WHERE q1.turn >= q2.turn
GROUP BY q1.person_name
HAVING sum(q2.weight) <= 1000
ORDER BY sum(q2.weight) DESC
LIMIT 1;