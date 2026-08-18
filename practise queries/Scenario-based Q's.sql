-- Q.1) Employee database
-- Description: You're managing an employee database where each employee is associated with a department. Employees have attributes like ID, name, 
-- and salary, while departments have attributes like ID and name. Design a query to retrieve the names of all employees along with their 
-- corresponding department names.

create table emp(
	id INT primary key,
    name VARCHAR(50),
    salary float  -- usd
);
insert into emp
values (1001, "Samay Raina", 4.3),
(1002, "Ajay Nagar", 5.6),
(1005, "Ravi Gupta", 2.2);
select * from emp;
create table dept(
	dept_id INT,
    dept_name VARCHAR(20)
);
insert into dept
values (1001, "Management"),
(1002, "Hiring"),
(1005, "Production");
select * from dept;

select emp.name, dept.dept_name as dept_name
from emp
join dept on emp.id = dept.dept_id;


-- Q-2) Sales Analysis
-- Description: In a sales database, you have two tables: "orders" and "customers." Each order has a customer ID, order ID, and order date, while each
-- customer has an ID and name. Write a SQL query to find the total number of orders placed by each customer.

create table orders(
	cust_id int primary key auto_increment,
    order_id int,
    order_date date
);
insert into orders (order_id, order_date)
values (025, "2026-03-30"),
(026, "2026-03-30"),
(027, "2026-03-31");
create table customers(
	cust_id int,
    cust_name varchar(50)
);
insert into customers
values (1, "Brian"),
(2, "Benjamin"),
(3, "Bethell");
select * from orders;
select * from customers;

select customers.cust_name, count(orders.order_id) as total_orders
from customers
join orders on customers.cust_id = orders.cust_id
group by customers.cust_name;


-- Q-3) Product Inventory
-- Description: You're working with a product inventory database that includes tables for "products" and "inventory." The products table contains 
-- information about each product, including product ID and name, while the inventory table tracks the quantity of each product in stock. 
-- Create a query to display the names of products with a stock quantity of less than 10.


