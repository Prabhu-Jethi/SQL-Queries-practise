Create table If Not Exists Project (project_id int, employee_id int)
DROP TABLE IF EXISTS Employee;
Create table If Not Exists Employee (employee_id int, name varchar(10), experience_years int)
Truncate table Project
insert into Project (project_id, employee_id) values 
('1', '1'),
('1', '2'),
('1', '3'),
('2', '1'),
('2', '4');
Truncate table Employee
insert into Employee (employee_id, name, experience_years) values 
('1', 'Khaled', '3'),
('2', 'Ali', '2'),
('3', 'John', '1'),
('4', 'Doe', '2');

/*
Project
(project_id, employee_id) is the primary key of this table.
employee_id is a foreign key to Employee table.
Each row of this table indicates that the employee with employee_id is working on the project with project_id.

Employee
employee_id is the primary key of this table. It's guaranteed that experience_years is not NULL.
Each row of this table contains information about one employee.

 

Write an SQL query that reports the average experience years of all the employees for each project, rounded to 2 digits.

Return the result table in any order.
*/

SELECT 
    p.project_id,
    ROUND(AVG(experience_years)::NUMERIC, 2) as average_years
FROM employee e
LEFT JOIN project p on p.employee_id = e.employee_id
GROUP BY p.project_id