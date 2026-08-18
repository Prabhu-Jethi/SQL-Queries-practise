CREATE table employees(
    employee_id INT,
    employee_name VARCHAR(50),
    department VARCHAR(20),
    salary FLOAT,
    manager_id INT
);
INSERT into employees VALUES 
(101, 'aarav', 'engineering', 35000.00, 105),
(102, 'meera', 'engineering', 47235.98, 106),
(103, 'kabir', 'sales', 38000, 105),
(105, 'rohan', 'engineering', 36000, NULL),
(106, 'rohan', 'sales', 65900, NULL);

-- waq to display all engineering employees ordered by salary from highest to lowest
SELECT employee_name, salary
from employees
where department = 'engineering'
ORDER BY salary DESC;

-- find number of employees in each dept having count more than 2
SELECT department, count(*) as employee_count
from employees
group by department
having count(*) > 2;

-- find the second-highest distinct salary (SUB-QUERY)
SELECT max(salary) as second_highest_salary
from employees
where salary < (
    SELECT max(salary)
    from employees
);

-- find employees earning more than the company average salary (SUB_QUERY)
SELECT employee_name, salary
from employees
where salary > (
    SELECT avg(salary)
    from employees
);

-- highest salary in each dept
SELECT department, max(salary) as highest_salary
from employees
group by department;

-- employees whose salary is higher than their manager salary (SELF-JOIN)
SELECT e.employee_name, e.salary
from employees e 
join employees m on e.manager_id = m.manager_id
where e.salary > m.salary;

create table customers(
    cust_id INT,
    cust_name VARCHAR(40),
    city VARCHAR(30)
);
insert into customers VALUES
(1, 'Aditi Sharma', 'Delhi'),
(2, 'Rahul verma', 'Mumbai'),
(3, 'Simran kaur', 'Chandigarh'),
(4, 'Arjun nair', 'Bengaluru');
CREATE table orders(
    order_id INT,
    cust_id int,
    amount INT,
    status VARCHAR(20)
);
insert into orders VALUES
(501, 1, 2400, 'Delivered'),
(502, 1, 3500, 'Delivered'),
(503, 2, 1899, 'Pending'),
(504, 2, 2560, 'Cancelled'),
(505, 3, 999, 'Delivered');

-- display each order with customer name
SELECT o.order_id, c.cust_name, o.amount, o.status
from orders o
JOIN customers c on o.cust_id = c.cust_id;

-- customers who never placed order
SELECT c.cust_id, c.cust_name
from customers c
left join orders o on c.cust_id = o.cust_id
where o.order_id is NULL;

--customers with more than one order
SELECT c.cust_name, count(*) as order_count
from customers c
JOIN orders o on c.cust_id = o.cust_id
GROUP by c.cust_name
having count(*) > 1;

--highest spending customer based only on delivered orders
SELECT c.cust_name, sum(o.amount) as total_spending
from customers c
join orders o on c.cust_id = o.cust_id
where o.status = 'Delivered'
group by c.cust_name
ORDER BY total_spending DESC
-- limit 1;


--- Q- A table has 100 million records. You want to remove all rows as quickly as possible
--- while keeping the table. Which SQL command will you use?

-- A - Using TRUNCATE, (TRUNCATE table name) when all rows must be removed quickly. It keeps the table structured
---  but removes the data. It is faster than delete for full table cleanup.

-- ** If accidentally we deleted a row using 'DELETE' command, It can still be recovered.
-- Meanwhile Truncated rows can't be recovered. **


--- Q- A new intern should only be able to view the employee table but should n't modify it.
--- Which command will you use ?

--A- use "GRANT" to give access. SELECT permission allows reading data from Employees.

--- GRANT SELECT ON employees TO intern_user

--- REVOKE from intern_user



--- Q- An alias created in select list cannot be referenced in the where clause of the same
--- query. How does SQL's logical execution order explain this ?

--- A-  where is evaluated before select so the alias doesn't exist yet when where runs.
-- so the query will throw an error.

-- From -> joins -> where -> groupby -> having -> select -> orderby -> limit


-- Q- A ranking query contains duplicate salaries. How will ROW_NUMBER(), RANK() and 
-- DENSE_RANK() assign values differently ?

-- A- ROW_NUMBER() gives a unique sequence when salaries tie. RANK() gives same rank to ties
-- but leaves gaps. DENSE_RANK() gives same rank to ties without gaps.


-- Q- Table contains duplicate and NULL email values, How will COUNT(*), COUNT(email), and
-- COUNT(DISTINCT email) differ ?

-- A- COUNT(*) counts every row, COUNT(email) counts only rows where email is not NULL,
-- COUNT(DISTINCT email) counts unique non-null emails only.


--Q- Report contains missing values across primary_phone, alternate_phone, emergency_phone.
--How would you return the first available value and show 'Not available' all 3 are null

--A - select cust_name, COALESCE(primary_phone, alternative_phone, emergency_phone,
--- 'Not-available') as contact_phone FROM custoemers.
    

CREATE TABLE user_logins(
    user_id INT,
    login_date DATE,
    session_minutes INT
);
INSERT INTO user_logins VALUES
(1, '2026-07-01', 35),
(1, '2026-07-02', 42),
(1, '2026-07-03', 28),
(2, '2026-07-15', 20),
(2, '2026-07-16', 25),
(3, '2026-07-02', 30);

-- find each user's previous login date
SELECT user_id, login_date, 
LAG(login_date) OVER (PARTITION BY user_id ORDER BY login_date) as previous_login
from user_logins


--- Q- A salary report must classify employees into low, medium and high salary bands inside
-- the SELECT output. which conditional expression would you use, and why is it preferable to it.

-- A- Use CASE because it works inside SELECT, ORDER BY and aggregate expressions. 


--- Q- A percentage calculation divides achieved_sales by target_sales but some targets are zero,
-- How would you prevent a divide-by-zero error while preserving those rows ?

-- A- NULLIF(target_sales, 0) turns zero into NULL. Dividing by NULL returns NULL instead of 
-- crashing the query. Rows are preserved so missing or invalid percentage can be handled later.
 
 -- select emp_id, achieved_sales * 100.0 / NULLIF(target_sales, 0) AS achievement_pct
 -- FROM sales_target.


create table customer_records(
    cust_id INT,
    cust_name VARCHAR(50),
    email VARCHAR(60),
    created_at TIMESTAMP
);
insert into customer_records VALUES
(301, 'Nikhil Jain', 'nikhil@gmail.com', '2024-01-12 10:15'),
(302, 'Sara Ali', 'sara@gmail.com', '2024-02-03 09:10'),
(303, 'Nikhil Jain', 'nikhil@gmail', '2024-05-21 18:30'),
(304, 'Dev Patel', 'dev@gmail.com', '2024-06-11 12:45');

-- Query to delete duplicate records while keeping the newest record for each email.
WITH ranked as (
    SELECT cust_id,
        ROW_NUMBER() OVER (
            PARTITION BY email ORDER BY created_at DESC
        ) as rn
    from customer_records
)
DELETE FROM customer_records
WHERE cust_id in (
    SELECT cust_id 
    from ranked
    where rn > 1
);


DROP TABLE IF EXISTS orders;

CREATE TABLE orders (
    order_id     SERIAL PRIMARY KEY,
    customer_id  INT NOT NULL,
    order_date   DATE NOT NULL,
    amount       NUMERIC(10,2) NOT NULL
);
INSERT INTO orders (customer_id, order_date, amount) VALUES
(1, '2024-01-05', 250.00),
(1, '2024-02-10', 400.00),
(1, '2024-03-15', 150.00),
(1, '2024-05-01', 600.00),
(2, '2024-01-20', 100.00),
(2, '2024-01-25', 300.00),
(2, '2024-04-10', 220.00),
(3, '2024-02-01', 500.00),
(3, '2024-02-20', 500.00),
(3, '2024-03-05', 90.00),
(4, '2024-01-15', 700.00),
(4, '2024-06-01', 50.00);

SELECT customer_id, order_date, amount,
sum(amount) OVER (PARTITION BY customer_id ORDER BY order_date) as running_total,
RANK() OVER (PARTITION BY customer_id ORDER BY amount DESC) as amt_rank
from orders
order by customer_id, order_date;