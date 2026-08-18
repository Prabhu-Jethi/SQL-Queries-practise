CREATE TABLE employees (
	emp_id INT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    hourly_pay DECIMAL(5, 2),
    hire_date DATE
);
SELECT * FROM employees;

RENAME TABLE employees TO Emp;
-- DROP TABLE Emp;

ALTER TABLE Emp
ADD phone_num VARCHAR(15); 

ALTER TABLE Emp
RENAME COLUMN phone_num TO email;

ALTER TABLE Emp
MODIFY COLUMN email VARCHAR(50);

ALTER TABLE Emp
MODIFY email VARCHAR(50)
AFTER last_name;
-- FIRST--
-- DROP COLUMN email--
 
SELECT * FROM Emp;