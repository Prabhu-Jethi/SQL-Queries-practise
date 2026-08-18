SELECT first_name, last_name
FROM Emp;

SELECT *
FROM Emp
WHERE emp_id = 3;

SELECT *
FROM Emp
WHERE hourly_pay >= 30;

SELECT *
FROM Emp
WHERE emp_id != 3;

SELECT *
FROM Emp
WHERE hire_date IS NOT NULL;