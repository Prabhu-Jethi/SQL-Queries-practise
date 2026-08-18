-- ----- Q1- Show top 5 rows from each table
-- SELECT * FROM trading.members LIMIT 5;
-- SELECT * FROM trading.prices LIMIT 5;
-- SELECT * FROM trading.transactions LIMIT 5;


-- ----- Q2- In members table, sort all the rows by 'first_name' in alphabetical orders top 5

-- SELECT *
-- FROM trading.members
-- ORDER BY first_name ASC LIMIT 3;


-- ------ Q3- Which records from trading.members are from the United States region?

-- SELECT *
-- FROM trading.members
-- WHERE region = 'United States'


-- ------- Q4- Select only the member_id and first_name columns for members who are not from Australia

-- Select member_id, first_name
-- FROM trading.members
-- WHERE region != 'Australia'


-- ------- Q5- Return the unique region values from the trading.members table and sort the output by reverse alphabetical order

-- SELECT DISTINCT region
-- FROM trading.members
-- ORDER BY region DESC;


-- ------- Q6- How many members are there from Australia or the United States?

-- SELECT COUNT(*) AS member_count
-- FROM trading.members
-- WHERE region IN ('Australia', 'United States')


-- ------- Q7- How many members are not from Australia or the United States?

-- SELECT COUNT(*) AS member_count
-- FROM trading.members
-- WHERE region NOT IN ('Australia', 'United States')


-- ------- Q8- How many members are there per region? Sort the output by regions with the most mentors to the least

-- SELECT DISTINCT region, COUNT(*) AS member_count
-- FROM trading.members
-- GROUP BY region
-- ORDER BY member_count DESC;


-- ------- Q9- How many US mentors and non US mentors are there?


-- SELECT
--     CASE
--         WHEN region != 'United States' THEN 'Non-US'
--         ELSE region
--     END AS member_region,
--     COUNT(*) AS member_count
-- FROM trading.members
-- GROUP BY member_region
-- ORDER BY member_count;


-- ------- Q10- How many mentors have a first name starting with a letter before 'E'?


-- SELECT COUNT(*) AS member_count
-- FROM trading.members
-- WHERE LEFT(first_name, 1) < 'E'




---------------------------------------------------------------------------------------------------------------

-- SELECT *
-- FROM trading.prices
-- WHERE ticker = 'ETH' LIMIT 10;



-- ------- Q1- How many total records do we have in the trading.prices table?

-- SELECT COUNT(*) AS Total_record
-- FROM trading.prices


-- ------- Q2-  How many records are there per ticker value?

-- SELECT ticker, COUNT(*) AS record_count
-- FROM trading.prices
-- GROUP BY ticker


-- ------ Q3- What is the minimum and maximum market_date values?

-- SELECT MIN(market_date) AS min_date, MAX(market_date) AS max_date
-- FROM trading.prices


-- ----- Q4- Are there differences in the minimum and maximum market_date values for each ticker?

-- SELECT ticker, MIN(market_date) AS min_date, MAX(market_date) AS max_date
-- FROM trading.prices
-- GROUP BY ticker


-- ------- Q5- What is the average of the price column for Bitcoin records during the year 2020?

-- SELECT AVG(price) AS avg_price
-- FROM trading.prices
-- WHERE market_date BETWEEN '2020-01-01' AND '2020-12-31'


-- ------- Q6- What is the monthly average of the price column for Ethereum in 2020? 
-- -------- Sort the output in chronological order and also round the average price value to 2 decimal places

-- SELECT
--   DATE_TRUNC('MON', market_date) AS month_start,
--   ROUND(AVG(price)::NUMERIC, 2) AS average_eth_price
-- FROM trading.prices
-- WHERE EXTRACT(YEAR FROM market_date) = 2020
--   AND ticker = 'ETH'
-- GROUP BY month_start
-- ORDER BY month_start;


-- --------Q7- Are there any duplicate market_date values for any ticker value in our table?

-- SELECT ticker, COUNT(market_date) AS total_market_date,
--     COUNT(DISTINCT(market_date)) AS unique_market_date
-- FROM trading.prices
-- GROUP BY ticker


-- ------- Q8- How many days from the trading.prices table exist where the high price of Bitcoin is over $30,000?


-- SELECT COUNT(*) AS row_count
-- FROM trading.prices
-- WHERE high > 30000


-- ------- Q9-  How many "breakout" days were there in 2020 where the price column is greater than the open column for each ticker?

-- SELECT ticker,
--     SUM(CASE 
--             WHEN price > open THEN 1 
--             ELSE 0
--         END) AS breakout_days
-- FROM trading.prices
-- WHERE DATE_TRUNC('YEAR', market_date) = '2020-01-01'
-- GROUP BY ticker



-- --------- Q10- How many "non_breakout" days were there in 2020 where the price column is less than the open column for each ticker?

-- SELECT ticker,
--     SUM(CASE
--             WHEN price < open THEN 1
--             ELSE 0
--         END) AS non_breakout_days
-- FROM trading.prices
-- WHERE DATE_TRUNC('YEAR', market_date) = '2020-01-01'
-- GROUP BY ticker



-- ------------ Q11-  What percentage of days in 2020 were breakout days vs non-breakout days? Round the percentages to 2 decimal places


-- SELECT ticker,
--     ROUND(SUM(CASE WHEN price > open THEN 1 ELSE 0 END) 
--     / COUNT(*)::NUMERIC,
--      2) AS breakout_days,
--     ROUND(SUM(CASE WHEN price < open THEN 1 ELSE 0 END) 
--     / COUNT(*)::NUMERIC,
--      2) AS non_breakout_days
-- FROM trading.prices
-- WHERE DATE_TRUNC('YEAR', market_date) = '2020-01-01'
-- GROUP BY ticker


--------------------------------------------------------------------------------------------------------------------------------------------------

-- SELECT * FROM trading.transactions

-- -- SELECT * FROM trading.transactions
-- -- WHERE member_id = 'c4ca42'
-- -- ORDER BY txn_time DESC
-- -- LIMIT 10



-- ------------ Q1-  How many records are there in the trading.transactions table?

-- SELECT COUNT(*) AS total_records
-- FROM trading.transactions


-- -------- Q2- How many unique transactions are there?

-- SELECT DISTINCT COUNT(txn_id) AS total_unique_records
-- FROM trading.transactions


-- --------- Q3- How many buy and sell transactions are there for Bitcoin?

-- SELECT txn_type, COUNT(*) AS transaction_count
-- FROM trading.transactions
-- WHERE ticker = 'BTC'
-- GROUP BY txn_type



-- ----------- Q4- For each year, calculate the following buy and sell metrics for Bitcoin:
-- --------     total transaction count
-- --------     total quantity
-- --------     average quantity per transaction
-- --------- Also round the quantity columns to 2 decimal places.

-- SELECT 
--   EXTRACT('YEAR' FROM txn_date) AS txn_year,
--   txn_type,
--   COUNT(*) AS transaction_count,
--   ROUND(SUM(quantity::NUMERIC), 2) AS total_quantity,
--   ROUND(AVG(quantity::NUMERIC), 2) AS average_quantity
-- FROM trading.transactions
-- WHERE ticker = 'BTC'
-- GROUP BY txn_type, txn_year



-- ------------- Q5- What was the monthly total quantity purchased and sold for Ethereum in 2020?

-- SELECT 
--   DATE_TRUNC('MON', txn_date):: DATE AS calender_month,
--   SUM(CASE WHEN txn_type = 'BUY' THEN quantity ELSE 0 END) AS buy_quantity,
--   SUM(CASE WHEN txn_type = 'SELL' THEN quantity ELSE 0 END) AS sell_quantity
-- FROM trading.transactions
-- WHERE ticker = 'ETH' and txn_date BETWEEN '2020-01-01' AND '2020-12-31'
-- GROUP BY calender_month




--     ------- Q6- Summarise all buy and sell transactions for each member_id by generating 1 row for each member with the following additional columns:
--     ---------- 1. Bitcoin buy quantity
--     --------   2. Bitcoin sell quantity
--     --------   3. Ethereum buy quantity
--     ---------  4. Ethereum sell quantity

-- SELECT member_id,
--   SUM(
--     CASE WHEN ticker = 'BTC' AND txn_type = 'BUY' THEN quantity ELSE 0 END
--   ) AS btc_buy_qty,
--   SUM(
--     CASE WHEN ticker = 'BTC' AND txn_type = 'SELL' THEN quantity ELSE 0 END
--   ) AS btc_sell_qty,
--   SUM(
--     CASE WHEN ticker = 'ETH' AND txn_type = 'BUY' THEN quantity ELSE 0 END
--   ) AS eth_buy_qty,
--   SUM(
--     CASE WHEN ticker = 'ETH' AND txn_type = 'SELL' THEN quantity ELSE 0 END
--   ) AS eth_sell_qty
-- FROM trading.transactions
-- GROUP BY member_id



-- ------------- Q7- What was the final quantity holding of Bitcoin for each member? Sort the output from the highest BTC holding to lowest

-- SELECT DISTINCT member_id,
--   SUM(
--     CASE WHEN ticker = 'BTC' THEN quantity ELSE 0 END
--   ) AS final_btc_holding
-- FROM trading.transactions
-- GROUP BY member_id
-- ORDER BY final_btc_holding DESC



-- ------------- Q8- Which members have sold less than 500 Bitcoin? Sort the output from the most BTC sold to least

-- -- SELECT * FROM (
-- --   SELECT member_id,
-- --     SUM(quantity) AS btc_sold_quantity
-- --   FROM trading.transactions
-- --   WHERE ticker = 'BTC' AND txn_type = 'SELL'
-- --   GROUP BY member_id
-- -- ) AS subquery
-- -- WHERE btc_sold_quantity < 500
-- -- ORDER BY btc_sold_quantity DESC

-- SELECT
--   member_id,
--   SUM(quantity) AS btc_sold_quantity
-- FROM trading.transactions
-- WHERE ticker = 'BTC'
--   AND txn_type = 'SELL'
-- GROUP BY member_id
-- HAVING SUM(quantity) < 500
-- ORDER BY btc_sold_quantity DESC;



-- ------------ Q9- What is the total Bitcoin quantity for each member_id owns after
-- ------------- adding all of the BUY and SELL transactions from the transactions table? Sort the output by descending total quantity

-- SELECT DISTINCT member_id,
--   SUM(
--     CASE WHEN txn_type = 'BUY' THEN quantity
--          WHEN txn_type = 'SELL' THEN -quantity
--   END) AS total_quantity
-- FROM trading.transactions
-- WHERE ticker = 'BTC'
-- GROUP BY member_id
-- ORDER BY total_quantity DESC



-- ------------------ Q10- Which member_id has the highest buy to sell ratio by quantity?

-- SELECT member_id,
--   SUM(
--     CASE WHEN txn_type = 'BUY' THEN quantity ELSE 0 END
--   ) / SUM(
--     CASE WHEN txn_type = 'SELL' THEN quantity ELSE 0 END
--   ) AS buy_sell_ratio
-- FROM trading.transactions
-- GROUP BY member_id
-- ORDER BY buy_sell_ratio DESC



-- ---------------------- Q11- For each member_id - which month had the highest total Ethereum quantity sold`?

-- WITH cte_ranked AS (
--   SELECT member_id,
--     DATE_TRUNC('MON', txn_date)::DATE AS calender_month,
--     SUM(quantity) AS eth_sold_qty,
--     RANK() OVER (PARTITION BY member_id ORDER BY SUM(quantity) DESC) AS monthly_rank
--   FROM trading.transactions
--   WHERE ticker = 'ETH' and txn_type = 'SELL'
--   GROUP BY member_id, calender_month
-- )
-- SELECT member_id,
--   calender_month,
--   eth_sold_qty
-- FROM cte_ranked
-- WHERE monthly_rank = 1
-- ORDER BY eth_sold_qty DESC



--------------------------------------------------------------------------------------------------------------------------------------------------

----- Entity-Relationship

---------------- Q1- What is the earliest and latest date of transactions for all members?

-- SELECT
--     MIN(txn_date) AS earliest_date,
--     MAX(txn_date) AS latest_date
-- FROM trading.transactions



-- ---------------- Q2- What is the range of market_date values available in the prices data?

-- SELECT
--     MIN(market_date) AS earliest_date,
--     MAX(market_date) AS latest_date
-- FROM trading.prices



-- ----------------- Q3- Which top 3 mentors have the most Bitcoin quantity as of the 29th of August?

-- SELECT members.first_name,
--     SUM(CASE WHEN transactions.txn_type = 'BUY' THEN transactions.quantity
--         WHEN transactions.txn_type = 'SELL' THEN -transactions.quantity
--     END) AS most_bitcoin
-- FROM trading.members
-- JOIN trading.transactions ON members.member_id = transactions.member_id
-- WHERE transactions.ticker = 'BTC'
-- GROUP BY members.first_name
-- ORDER BY most_bitcoin DESC
-- LIMIT 3;



-- ----------------- Q4- What is total value of all Ethereum portfolios for each region at the end date of our analysis? 
-- ------------------ Order the output by descending portfolio value


-- WITH cte_latest_price AS (
--     SELECT ticker, price
--     FROM trading.prices
--     WHERE ticker = 'ETH'
--     AND market_date = '2021-08-29'
-- )
-- SELECT members.region,
--     SUM(CASE WHEN transactions.txn_type = 'BUY' THEN transactions.quantity
--         WHEN transactions.txn_type = 'SELL' THEN -transactions.quantity
--     END) * cte_latest_price.price AS Ethereum_value,
--     AVG(
--         CASE WHEN transactions.txn_type = 'BUY' THEN transactions.quantity
--         WHEN transactions.txn_type = 'SELL' THEN -transactions.quantity
--     END) * cte_latest_price.price AS avg_ethereum_value
-- FROM trading.transactions
-- JOIN cte_latest_price ON transactions.ticker = cte_latest_price.ticker
-- JOIN trading.members ON transactions.member_id = members.member_id
-- WHERE transactions.ticker = 'ETH'
-- GROUP BY members.region, cte_latest_price.price
-- ORDER BY avg_ethereum_value DESC



-- --------------- Q5- What is the average value of each Ethereum portfolio in each region? 
-- ----------------- Sort this output in descending order

-- WITH cte_latest_price AS (
--   SELECT ticker, price
--   FROM trading.prices
--   WHERE ticker = 'ETH'
--   AND market_date = '2021-08-29'
-- )
-- SELECT members.region,
--   AVG(
--     CASE WHEN transactions.txn_type = 'BUY'  THEN transactions.quantity
--       WHEN transactions.txn_type = 'SELL' THEN -transactions.quantity
--     END) * cte_latest_price.price AS avg_ethereum_value
-- FROM trading.transactions
-- JOIN cte_latest_price ON transactions.ticker = cte_latest_price.ticker
-- JOIN trading.members ON transactions.member_id = members.member_id
-- WHERE transactions.ticker = 'ETH'
-- GROUP BY members.region, cte_latest_price.price
-- ORDER BY avg_ethereum_value DESC;



-- ---------- Q6- Let's try again - this time we will calculate the total sum of portfolio value and then
-- --------------- manually divide it by the total number of mentors in each region!

-- WITH cte_latest_price AS (
--     SELECT ticker, price
--     FROM trading.prices
--     WHERE ticker = 'ETH'
--     AND market_date = '2021-08-29'
-- ),
-- cte_calculation AS (
--     SELECT members.region,
--         SUM(CASE 
--                 WHEN transactions.txn_type = 'BUY' THEN transactions.quantity
--                 WHEN transactions.txn_type = 'SELL' THEN -transactions.quantity
--             END) * cte_latest_price.price AS ethereum_value,
--         COUNT(DISTINCT members.member_id) AS member_count
--     FROM trading.transactions
--     JOIN cte_latest_price ON cte_latest_price.ticker = transactions.ticker
--     JOIN trading.members ON members.member_id = transactions.member_id
--     WHERE transactions.ticker = 'ETH'
--     GROUP BY members.region, cte_latest_price.price
-- )
-- SELECT *, ethereum_value / member_count AS avg_ethereum_value
-- FROM cte_calculation
-- ORDER BY avg_ethereum_value DESC;



-----------------------------------------------------------------------------------------------------------------------------

-----------Planning ahead for analysis

-------------------- Q1- Create a Base Table We can make use of a TEMP table which is stored in a temporary schema
--------------- which will disappear once the SQL session is closed down - this is very useful in practice because 
---------- you don't always have write access to production databases all the time

------------- Create a base table that has each mentor's name, region and end of year total quantity for each ticker

-- DROP TABLE IF EXISTS temp_portfolio_base;

-- CREATE TEMP TABLE temp_portfolio_base AS
-- WITH cte_joined_data AS (
--   SELECT
--     members.first_name,
--     members.region,
--     transactions.txn_date,
--     transactions.ticker,
--     CASE
--       WHEN transactions.txn_type = 'SELL' THEN -transactions.quantity
--       ELSE transactions.quantity
--     END AS adjusted_quantity
--   FROM trading.transactions
--   INNER JOIN trading.members
--     ON transactions.member_id = members.member_id
--   WHERE transactions.txn_date <= '2020-12-31'
-- )
-- SELECT
--   first_name,
--   region,
--   (DATE_TRUNC('YEAR', txn_date) + INTERVAL '12 MONTHS' - INTERVAL '1 DAY')::DATE AS year_end,
--   ticker,
--   SUM(adjusted_quantity) AS yearly_quantity
-- FROM cte_joined_data
-- GROUP BY first_name, region, year_end, ticker;


-- ------------------- Q2- Let's take a look at our base table now to see what data we have to play with - to keep things 
-- ----------------------simple, let's take a look at Abe's data from our new temp table temp_portfolio_base

-- --------------- Inspect the year_end, ticker and yearly_quantity values from our new temp table temp_portfolio_base for 
-- ----------------Mentor Abe only. Sort the output with ordered BTC values followed by ETH values


-- SELECT year_end,
--     ticker,
--     yearly_quantity
-- FROM temp_portfolio_base
-- WHERE first_name = 'Abe'
-- ORDER BY ticker, year_end




-- -----------To create the cumulative sum - we'll need to apply a window function!
-- ----------- Q3- Create a cumulative sum for Abe which has an independent value for each ticker

-- SELECT year_end,
--     ticker,
--     yearly_quantity,
--     SUM(yearly_quantity) OVER (
--         PARTITION BY first_name, ticker
--         ORDER BY year_end
--         ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
--     ) AS cummulative_quantity
-- FROM temp_portfolio_base
-- WHERE first_name = 'Abe'
-- ORDER BY ticker, year_end




-- -----------------Now let's apply our same window function to the entire temporary dataset and start answering our questions.
-- -------------We can actually ALTER and UPDATE our temp table to add in an extra column with our new calculation

-- -------------- Q4- Generate an additional cumulative_quantity column for the temp_portfolio_base temp table


-- -- -- add a column called cumulative_quantity
-- -- ALTER TABLE temp_portfolio_base
-- -- ADD cumulative_quantity NUMERIC;
-- -- -- update new column with data
-- -- UPDATE temp_portfolio_base
-- -- SET (cumulative_quantity) = (
-- --   SELECT
-- --       SUM(yearly_quantity) OVER (
-- --     PARTITION BY first_name, ticker
-- --     ORDER BY year_end
-- --     ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
-- --   )
-- -- );
-- -- -- query the updated table to check rows for Abe
-- -- SELECT
-- --   year_end,
-- --   ticker,
-- --   yearly_quantity,
-- --   cumulative_quantity
-- -- FROM temp_portfolio_base
-- -- WHERE first_name = 'Abe'
-- -- ORDER BY ticker, year_end;

-- ----------- ***** It didn't work because our UPDATE step only takes into account a single row at a time,
-- -------------- which is exactly what we must not do with our window functions! *******


-- DROP TABLE IF EXISTS temp_cumulative_portfolio_base
-- CREATE TEMP TABLE temp_cumulative_portfolio_base AS
-- SELECT
--     first_name,
--     region,
--     ticker,
--     year_end,
--     yearly_quantity,
--     SUM(yearly_quantity) OVER (
--         PARTITION BY first_name, region
--         ORDER BY year_end
--         ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
--     ) AS cummulative_quantity
-- FROM temp_portfolio_base

-- SELECT * FROM temp_cumulative_portfolio_base



-----------------------------------------------------------------------------------------------------------------------------------------------------------

---------- Answering Data Queries ---------------

DROP TABLE IF EXISTS temp_portfolio_base;
CREATE TEMP TABLE temp_portfolio_base AS
WITH cte_joined_data AS (
  SELECT
    members.first_name,
    members.region,
    transactions.txn_date,
    transactions.ticker,
    CASE
      WHEN transactions.txn_type = 'SELL' THEN -transactions.quantity
      ELSE transactions.quantity
    END AS adjusted_quantity
  FROM trading.transactions
  INNER JOIN trading.members
    ON transactions.member_id = members.member_id
  WHERE transactions.txn_date <= '2020-12-31'
)
SELECT
  first_name,
  region,
  (DATE_TRUNC('YEAR', txn_date) + INTERVAL '12 MONTHS' - INTERVAL '1 DAY')::DATE AS year_end,
  ticker,
  SUM(adjusted_quantity) AS yearly_quantity
FROM cte_joined_data
GROUP BY first_name, region, year_end, ticker;

DROP TABLE IF EXISTS temp_cumulative_portfolio_base;
CREATE TEMP TABLE temp_cumulative_portfolio_base AS
SELECT
  first_name,
  region,
  year_end,
  ticker,
  yearly_quantity,
  SUM(yearly_quantity) OVER (
    PARTITION BY first_name, ticker
    ORDER BY year_end
    ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
  ) AS cumulative_quantity
FROM temp_portfolio_base;


----- Q1- What is the total portfolio value for each mentor at the end of 2020?

-- SELECT
--   base.first_name,
--   ROUND(
--     SUM(base.cumulative_quantity * prices.price)::NUMERIC,
--     2
--   ) AS portfolio_value
-- FROM temp_cumulative_portfolio_base AS base
-- INNER JOIN trading.prices
--   ON base.ticker = prices.ticker
--   AND base.year_end = prices.market_date
-- WHERE base.year_end = '2020-12-31'
-- GROUP BY base.first_name
-- ORDER BY portfolio_value DESC;



--------- Q2- What's the total portfolio value for each region in 2019

-- SELECT
--   base.region,
--   ROUND(
--     SUM(base.cumulative_quantity * prices.price)::NUMERIC,
--     2
--   ) AS portfolio_value
-- FROM temp_cumulative_portfolio_base AS base
-- INNER JOIN trading.prices
--   ON base.ticker = prices.ticker
--   AND base.year_end = prices.market_date
-- WHERE base.year_end = '2019-12-31'
-- GROUP BY base.region
-- ORDER BY portfolio_value DESC;


---------- Q3- What percentage of regional portfolio values does each mentor contribute at the end of 2018?

WITH cte_mentor_portfolio AS (
  SELECT
    base.region,
    base.first_name,
    ROUND(
      SUM(base.cumulative_quantity * prices.price),
      2
    ) AS portfolio_value
  FROM temp_cumulative_portfolio_base AS base
  INNER JOIN trading.prices
    ON base.ticker = prices.ticker
    AND base.year_end = prices.market_date
  WHERE base.year_end = '2018-12-31'
  GROUP BY base.first_name, base.region
),
cte_region_portfolio AS (
SELECT
  region,
  first_name,
  portfolio_value,
  SUM(portfolio_value) OVER (PARTITION BY region) AS region_total
FROM cte_mentor_portfolio
)
SELECT
  region,
  first_name,
  ROUND(100 * portfolio_value / region_total, 2) AS contribution_percentage
FROM cte_region_portfolio
ORDER BY region_total DESC, contribution_percentage DESC;
