-- INNER JOIN--
select *
from transactions INNER JOIN customers
ON transactions.cust_id = customers.cust_id; 

select transaction_id, amount, first_name
from transactions INNER JOIN customers
ON transactions.cust_id = customers.cust_id;

-- LEFT JOIN--
select *
from transactions LEFT JOIN customers
ON transactions.cust_id = customers.cust_id;

-- RIGHT JOIN--
select *
from transactions RIGHT JOIN customers
ON transactions.cust_id = customers.cust_id;

-- 