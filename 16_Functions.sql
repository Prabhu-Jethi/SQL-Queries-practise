select COUNT(amount) AS count
from transactions;

select MAX(amount) as maximum
from transactions;

select MIN(amount) as minimum
from transactions;

select AVG(amount) as average
from transactions;

select SUM(amount) as sum
from transactions;

select CONCAT(first_name, " ", last_name) AS full_name
from emp;
