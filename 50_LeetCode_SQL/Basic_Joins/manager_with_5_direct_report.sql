DROP Table IF EXISTS Employee;
Create table If Not Exists Employee (id int, name varchar(255), department varchar(255), managerId int)
Truncate table Employee
insert into Employee values 
(101, 'John', 'A', NULL),
(102, 'Dan', 'A', 101),
(103, 'James', 'A', 101),
(104, 'Amy', 'A', 101),
(105, 'Anne', 'A', 101),
(106, 'Ron', 'B', 101);


/*
id is the primary key (column with unique values) for this table.
Each row of this table indicates the name of an employee, their department, and the id of their manager.
If managerId is null, then the employee does not have a manager.
No employee will be the manager of themself.

 

Write a solution to find managers with at least five direct reports.

Return the result table in any order.
*/

SELECT e1.name
FROM employee e1
INNER JOIN employee e2 on e1.id = e2.managerId
GROUP BY e1.name, e2.managerId
HAVING COUNT(e2.managerId) >= 5