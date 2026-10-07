Create table If Not Exists Emps(employee_id int, name varchar(20), reports_to int, age int)
Truncate table Emps
insert into Emps (employee_id, name, reports_to, age) values 
('9', 'Hercy', NULL, '43'),
('6', 'Alice', '9', '41'),
('4', 'Bob', '9', '36'),
('2', 'Winston', NULL, '37');

/*
employee_id is the column with unique values for this table.
This table contains information about the employees and the id of the manager they report to. Some employees do not report to anyone (reports_to is null). 


For this problem, we will consider a manager an employee who has at least 1 other employee reporting to them.

Write a solution to report the ids and the names of all managers, the number of employees who report directly to them, and the average age of the reports rounded to the nearest integer.

Return the result table ordered by employee_id.
*/

SELECT 
    e2.employee_id,
    e2.name,
    COUNT(e1.employee_id) as reports_count,
    ROUND(AVG(e1.age)::numeric) as average_age
FROM emps e1
CROSS JOIN emps e2 
WHERE e1.reports_to = e2.employee_id
GROUP BY e2.employee_id, e2.name
ORDER BY e2.employee_id
