INSERT INTO Emp(emp_id, first_name, last_name)
VALUES (001, 'Eugene', 'Krabs', 'eugenekrabs@gmail.com', 35.34, '2023-03-02'),
       (002, 'Matthew', 'Scotts', 'mattscotts43@gmail.com', 15.54, '2023-06-02'),
	   (003, 'Ben', 'Doggets', 'Bdgetts347@gmail.com', 26.47, '2024-07-18'),
       (004, 'Eva', 'Crackstone', 'imeva32@gmail.com', 47.23, '2024-10-01'),
       (005, 'Joseph', 'Nuts', 'josephnutss12@gmail.com', 25.10, '2025-11-07'),
       
       (006, 'Pattrick', 'Pinkman');
-- in case if you have inserted duplicate columns then here's how you can delete it --
-- DELETE FROM Emp
-- WHERE emp_id=1
-- LIMIT 1;

SELECT * FROM Emp;