UPDATE Emp 
SET hourly_pay = 10.26,
	email = 'itspinkmanpatt@gmail.com',
    hire_date = '2025-12-02'
WHERE emp_id = 6;
-- without 'WHERE' it will update all employees hourly pay to 10.26--

DELETE FROM Emp
WHERE emp_id = 6;

SELECT * FROM Emp;