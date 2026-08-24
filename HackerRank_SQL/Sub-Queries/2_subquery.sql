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

--- Q21. Display the names of salesman whose names are alphabetically lower than the names of customers

SELECT *
from salesman s
WHERE EXISTS (
    SELECT *
    from cust cu
    WHERE s.name < cu.customer_name
)

--- Q22. Display customers who have a greater gradation than any customer who belongs to the alphabetically lower than the city New york
---- [Tricky one] -----

SELECT *
from cust cu1
WHERE cu1.grade > any (
    SELECT cu2.grade
    from cust cu2
    WHERE cu2.city < 'New York'
)

--- Q23. Display all the orders that had amounts that were greater than atleast one of the orders on Sep-10th-2012

SELECT *
from customer_orders c1
WHERE c1.puch_amt > ANY (
    SELECT c2.puch_amt
    from customer_orders c2
    WHERE c2.ord_date = '2012-09-10'
)

--- Q24. Orders with amount smaller than any amount for a customer in london

SELECT *
FROM customer_orders c1
WHERE c1.puch_amt < ANY (
    SELECT c2.puch_amt
    from customer_orders c2
    WHERE c2.customer_id in (
        SELECT cu.customer_id
        FROM cust cu
        WHERE cu.city = 'London'
    )
)

--- Q25. Display all orders with an amount smaller than the maximum amount for a customers in london.

SELECT *
FROM customer_orders c1
WHERE puch_amt < (
    SELECT MAX(c2.puch_amt)
    FROM customer_orders c2
    WHERE c2.customer_id IN (
        SELECT cu.customer_id
        FROM cust cu
        WHERE cu.city = 'London'
    ) 
)

--- Q26. Display only those customers whose grade are, in fact, higher than every customer in New York.

SELECT cu1.customer_id, cu1.customer_name
FROM cust cu1
WHERE cu1.grade > ALL (
    SELECT cu2.grade
    FROM cust cu2
    WHERE cu2.city = 'New York'
)

--- Q27. Find only these customers whose grade are higher than every customer to the city new york

SELECT *
FROM cust cu1
WHERE cu1.grade > ALL (
    SELECT cu2.grade
    FROM cust cu2
    WHERE cu2.city = 'New York'
)

--- Q28. Get all the information for those customers whose grade is not as the grade of customer who belongs to the city London

SELECT *
FROM cust cu1
WHERE cu1.grade != ANY (
    SELECT cu2.grade
    FROM cust cu2
    WHERE cu2.city = 'London'
)

--- Q29. find all those customers whose grade are not as the grade, belongs to the city Paris.

SELECT *
FROM cust 
WHERE grade != ANY (
    SELECT grade
    FROM cust
    WHERE city = 'Paris'
)

--- Q30. find all those customers who hold a different grade than any customer of the city Dallas.

SELECT *
FROM cust
WHERE grade NOT IN (
    SELECT grade
    FROM cust
    WHERE city = 'Dallas'
)

--- Q31. Find the average price of each manufacturer's product along with their name

SELECT comp_name, AVG(prod_price)
FROM company_mast, item_mast
WHERE item_mast.prod_id = company_mast.comp_id
GROUP BY comp_name

--- Q32.  display the average price of the products which is more than or equal to 350 along with their names

SELECT c.comp_name, AVG(i.prod_price) as average_price
from item_mast i
INNER JOIN company_mast c on c.comp_id = i.prod_comp_id
GROUP BY c.comp_name
HAVING AVG(i.prod_comp_id) >= 350;

--- Q33. Display the name of each company, price for their most expensive product along with their Name

SELECT c.comp_name, i.prod_name, i.prod_price 
FROM item_mast i
INNER JOIN company_mast c on c.comp_id = i.prod_comp_id
AND i.prod_price = (
    SELECT MAX(i.prod_price)
    FROM item_mast i
    WHERE i.prod_comp_id = c.comp_id
)

--- Q34. Find all details of employee whose last name is 'Lorens' and 'Pepper'.

SELECT *
from emp_details 
WHERE emp_lname in (
    'Lorens', 'Pepper'
);


--- Q35. Display all the details of employees who works in department 3 and 4

SELECT *
FROM emp_details
where emp_dept in (3, 4)


--- Q36. Display first_name and last_name of employees working for the department whose allotment amount is more than 50000.

SELECT emp_fname, emp_lname
from emp_details 
WHERE emp_dept in (
    SELECT dept_id
    from emp_department
    WHERE dept_allotment > 50000
);


--- Q37. Find departments which sanction amount is larger than the average sanction amount of all departments.

SELECT dept_id, dept_name
FROM emp_department
WHERE dept_allotment > (
    SELECT AVG(dept_allotment)
    from emp_department
);


--- Q38. Find names of departments with more than two employees are working.

SELECT ed.dept_name
FROM emp_department ed
WHERE ed.dept_id in (
    SELECT e.emp_dept
    from emp_details e
    GROUP BY e.emp_dept
    HAVING count(*) > 2
)


--- Q39. Find first_name and last_name of employees working for departments whose sanction amount is 2nd largest.

SELECT emp_fname, emp_lname
FROM emp_details 
WHERE emp_dept IN (SELECT dept_id
                    FROM emp_department 
                    WHERE dept_allotment = (SELECT MIN(dept_allotment)
                                            FROM emp_department 
                                            WHERE dept_allotment > (SELECT MIN(dept_allotment)
                                                                    FROM emp_department)));