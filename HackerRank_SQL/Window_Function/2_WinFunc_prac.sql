
--- Q1. As a business analyst on the revenue forecasting team at NVIDIA, you are given a table of NVIDIA transactions in 2021.
--- Write a query to summarize the total sales revenue for each product line. The product line with the highest revenue should be at the top of the results.

SELECT DISTINCT p.product_line,
    SUM(amount) OVER (PARTITION BY p.product_line) AS total_revenue
FROM transactions t
INNER JOIN product_info p on t.product_id = p.product_id
ORDER BY total_revenue desc;

--- Q2. How does the PARTITION BY clause work in a window function? Can you provide an example?

--A - The PARTITION BY clause divides the result set into partitions to which the window function is applied. 
-- For example, SUM(sales) OVER (PARTITION BY department) calculates the total sales for each department. Each department is
-- treated as a separate group for the calculation.


--- Q3. Explain the difference between ROW_NUMBER(), RANK(), and DENSE_RANK() functions. When would you use each?

--- A- ROW_NUMBER() assigns a unique sequential number to rows within a partition, without regard for ties.
-- RANK() gives rows the same rank if they have the same value, but the next rank number skips the number of rows with the same rank.
-- DENSE_RANK() also gives the same rank for identical values but does not skip rank numbers.
-- Use Cases: ROW_NUMBER() for unique numbering, RANK() for scenarios where gaps in ranking are acceptable, DENSE_RANK() when you want continuous ranking.


--- Q4. How would you calculate a running total using SQL window functions?

--- A- SELECT 
  -- sales_date, 
  -- sales_amount, 
  -- SUM(sales_amount) OVER (ORDER BY sales_date) AS running_total 
-- FROM sales; 


--- Q5. Assume you're given a table containing data on Amazon customers and their spending on products in different category, 
--- write a query to identify the top two highest-grossing products within each category in the year 2022. The output should include the category, product, and total spend.

WITH ranking_spending_cte AS (
    SELECT category, product,
        SUM(spend) AS total_spend,
        RANK() OVER(PARTITION BY category ORDER BY SUM(spend) DESC) AS ranking
    FROM product_spend
    WHERE EXTRACT(YEAR FROM transaction_date) = 2022
    GROUP BY category, product
)
SELECT category, product, total_spend
FROM ranking_spending_cte
WHERE ranking <= 2
ORDER BY category, ranking;


--- Q6. What does the NTILE() function do, and how might it be useful in analyzing data?

--- A- NTILE() divides the rows in a result set into a specified number of roughly equal groups. It’s useful for breaking data into quartiles, deciles, etc. 
-- For example, NTILE(4) OVER (ORDER BY sales_amount) divides the data into four quartiles based on sales_amount


--- Q7. As a data analyst at Uber, it's your job to report the latest metrics for specific groups of Uber users. Some riders create their Uber account the same day they book their first ride; 
-- the rider engagement team calls them "in-the-moment" users.
-- Uber wants to know the average delay between the day of user sign-up and the day of their 2nd ride. 
-- Write a query to pull the average 2nd ride delay for "in-the-moment" Uber users. Round the answer to 2-decimal places.



