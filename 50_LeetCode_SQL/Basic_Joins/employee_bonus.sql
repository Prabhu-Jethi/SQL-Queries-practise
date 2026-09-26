Create table If Not Exists Employee (empId int, name varchar(255), supervisor int, salary int);
Create table If Not Exists Bonus (empId int, bonus int)
Truncate table Employee
insert into Employee (empId, name, supervisor, salary) values 
('3', 'Brad', NULL, '4000'),
('1', 'John', '3', '1000'),
('2', 'Dan', '3', '2000'),
('4', 'Thomas', '3', '4000');
Truncate table Bonus
insert into Bonus (empId, bonus) values 
('2', '500'),
('4', '2000');


/*
empId is the column with unique values for this table.
Each row of this table indicates the name and the ID of an employee in addition to their salary and the id of their manager.

empId is the column of unique values for this table.
empId is a foreign key (reference column) to empId from the Employee table.
Each row of this table contains the id of an employee and their respective bonus.

 

Write a solution to report the name and bonus amount of each employee who satisfies either of the following:

    The employee has a bonus less than 1000.
    The employee did not get any bonus.

Return the result table in any order.
*/

SELECT e.name, b.bonus
FROM employee e
LEFT JOIN bonus b on e.empId = b.empId
WHERE b.bonus < 1000 OR b.bonus is NULL
