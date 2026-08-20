--- Q1. Display all orders from orders table issued by salesman 'paul adam'

SELECT *
from customer_orders c
where c.salesman_id = (
    SELECT s.salesman_id
    from salesman s
    where s.name = 'Paul Adam'
)

--- Q2. Write a query to display all the orders for the salesman who belongs to london.

SELECT *
from customer_orders c
where c.salesman_id = (
    SELECT s.salesman_id
    from salesman s
    where s.city = 'London'
)

--- Q3. Find all the orders issued against the salesman who may work for the customer whose id is 3007

SELECT *
from customer_orders c
WHERE c.salesman_id = (
    SELECT c.salesman_id
    from customer_orders c
    where c.customer_id = 3007
)

--- Q4. Display all orders whose value are greater than the average order value for 10th Oct 2012.

SELECT c.ord_no, c.puch_amt, c.ord_date
from customer_orders c
WHERE c.puch_amt > (
    SELECT avg(puch_amt) as average_value
    from customer_orders c
    WHERE c.ord_date = '2012-10-10'
)

--- Q5. Find all orders attributed to a salesman in New York

SELECT *
from customer_orders c
WHERE c.salesman_id = (
    SELECT s.salesman_id
    from salesman s
    WHERE s.city = 'New York'
)

--- Q6. Display all the commision of all salesman servicing customers in paris

SELECT s.commission
from salesman s
WHERE s.salesman_id in (
    SELECT s.salesman_id
    from salesman s
    where s.city = 'Paris'
)

--- Q7. Display all the customers whose id is '2001' below salesman id of `Mc lyon`
-----(Subtract 2001 from salesman_id)

SELECT *
from cust as cu
where cu.customer_id = (
    SELECT s.salesman_id - 2001 as calculated_id
    from salesman s
    where s.name = 'Mc Lyon'
)

--- Q8. count customers with grade above New York's average.

SELECT count(*)
from cust cu
WHERE cu.grade > (
    SELECT avg(grade) as new_york_avg
    from cust cu
    where cu.city = 'New York'
)

--- Q9. Display all customers with orders on Oct-5-2012

SELECT *
from cust as cu
WHERE cu.customer_id in (
    SELECT c.customer_id
    from customer_orders as c
    where c.ord_date = '2012-10-05'
)

--- Q10. Display all the customers with orders issued on date 17th-Aug-2012

SELECT *
from cust cu
WHERE cu.customer_id in (
    SELECT c.customer_id
    from customer_orders c
    where c.ord_date = '2012-08-17'
)

--- Q11. Find the names and numbers of all salesman who had more than one customers.

SELECT s.salesman_id, s.name 
from salesman s
WHERE s.salesman_id in (
    SELECT cu.salesman_id
    from cust cu
    GROUP BY cu.salesman_id
    HAVING count(*) > 1
)

--- Q12. find all orders with order amount which are above average amounts of customers

SELECT *
FROM customer_orders a
WHERE puch_amt > (
    SELECT AVG(puch_amt)
    FROM customer_orders b
    WHERE b.customer_id = a.customer_id
);

--- Q13. find all orders with order amount which are `on` or `above` average amounts of customers

SELECT *
from customer_orders a
where puch_amt >= (
    SELECT avg(puch_amt)
    from customer_orders b
    WHERE b.customer_id = a.customer_id
);

--- Q14. find the sums of the amounts from the orders table, grouped by date, 
--- eliminating all those dates where the sum was not at least 1000.00 above the maximum order amount for that date.

SELECT SUM(c1.puch_amt) as total_amount, c1.ord_date
from customer_orders c1
GROUP BY c1.ord_date
HAVING SUM(c1.puch_amt) > (
    SELECT MAX(c2.puch_amt) + 1000
    from customer_orders c2
    WHERE c2.ord_date = c1.ord_date
)

--- Q15. Extract the data from the customer table if and only if one or more of the customers in the customer table are located in London.

SELECT * 
FROM cust cu
WHERE EXISTS (
    SELECT *
    FROM cust cu
    WHERE cu.city = 'London'
);

--- Q16. Find salesman who have multiple customers.

SELECT *
from salesman s
where s.salesman_id in (
    SELECT cu.salesman_id
    from cust cu
    GROUP BY cu.salesman_id
    HAVING count(*) > 1
)

--- Q17. Salesman who worked only for one customer

SELECT s.salesman_id, s.name
from salesman s
WHERE s.salesman_id in (
    SELECT cu.salesman_id
    from cust cu
    GROUP BY cu.salesman_id
    HAVING count(*) = 1
)

--- Q18. Extract the rows of all salesman who have customers with more than one orders

SELECT *
FROM salesman s
WHERE s.salesman_id in (
    SELECT cu.salesman_id
    from cust cu
    WHERE cu.customer_id in (
        SELECT c.customer_id
        from customer_orders c
        GROUP BY c.customer_id
        HAVING count(*) > 1
    )
)

--- Q19. Find salesman with all information who lives in the city where any of the customer lives

SELECT *
FROM salesman s
WHERE s.city in (
    SELECT cu.city
    from cust cu
)

--- Q20. Find all the salesman for whom there are customers that follow them

SELECT count(*) as salesman_followed_by_customers
FROM salesman s
WHERE s.city in (
    SELECT cu.city
    from cust cu
)

