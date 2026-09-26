Create table If Not Exists Employees (id int, name varchar(20));
Create table If Not Exists EmployeeUNI (id int, unique_id int);
Truncate table Employees
insert into Employees (id, name) values 
('1', 'Alice'),
('7', 'Bob'),
('11', 'Meir'),
('90', 'Winston'),
('3', 'Jonathan');
Truncate table EmployeeUNI
insert into EmployeeUNI (id, unique_id) values 
('3', '1'),
('11', '2'),
('90', '3');


/*
id is the primary key (column with unique values) for this table.
Each row of this table contains the id and the name of an employee in a company.

(id, unique_id) is the primary key (combination of columns with unique values) for this table.
Each row of this table contains the id and the corresponding unique id of an employee in the company.


Write a solution to show the unique ID of each user, If a user does not have a unique ID replace just show null.

Return the result table in any order.
*/


SELECT eu.unique_id, e.name
FROM Employees e
LEFT JOIN EmployeeUNI eu on e.id = eu.id


