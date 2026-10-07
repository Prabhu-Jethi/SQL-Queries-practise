Create type primary_flag_enum AS ENUM ('Y', 'N');
Create table If Not Exists Emp (employee_id int, department_id int, primary_flag primary_flag_enum)
Truncate table Emp
insert into Emp (employee_id, department_id, primary_flag) values 
('1', '1', 'N'),
('2', '1', 'Y'),
('2', '2', 'N'),
('3', '3', 'N'),
('4', '2', 'N'),
('4', '3', 'Y'),
('4', '4', 'N');


/*
(employee_id, department_id) is the primary key (combination of columns with unique values) for this table.
employee_id is the id of the employee.
department_id is the id of the department to which the employee belongs.
primary_flag is an ENUM (category) of type ('Y', 'N'). If the flag is 'Y', the department is the primary department for the employee. If the flag is 'N', 
the department is not the primary.

 

Employees can belong to multiple departments. When the employee joins other departments, they need to decide which department is their primary department. 
Note that when an employee belongs to only one department, their primary column is 'N'.

Write a solution to report all the employees with their primary department. For employees who belong to one department, report their only department.
*/

SELECT e1.employee_id, e1.department_id
FROM emp e1
WHERE e1.primary_flag = 'Y' OR e1.employee_id IN (
    SELECT e2.employee_id
    FROM emp e2
    GROUP BY e2.employee_id
    HAVING COUNT(e2.employee_id) = 1
)