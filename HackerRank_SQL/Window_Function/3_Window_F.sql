
--- Q1. Given a phone log table that has information about callers' call history, find out the callers whose first and
--- last calls were to the same person on a given day. Output the caller ID, recipient ID, and the date called.

--- find first and last call
WITH first_and_last_call AS (
    SELECT *,
        FIRST_VALUE(recipient_id) OVER (
            PARTITION BY caller_id, DATE(date_called) ORDER BY date_called ASC) AS first_call,
        FIRST_VALUE(recipient_id) OVER (
            PARTITION BY caller_id, DATE(date_called) ORDER BY date_called DESC) AS last_call
FROM caller_history
)
-- find first call by caller
SELECT DISTINCT caller_id,
    first_call AS recipient_id,
    date(date_called)
FROM first_and_last_call
WHERE first_call = last_call;

----{ Why not use last_value ?
---  The thing is that, when you add ORDER BY to a window function, SQL quietly applies a default frame: ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW. 
--- This means that the window is all the rows before the current row + the current row. That’s fine when you use FIRST_VALUE(); the window frame includes
--- all the preceding rows, so the first value really is the first value of the partition.}

---//// ALternative -- (USING ROW NUMBER())

----- {Another way of solving this problem is to use ROW_NUMBER() instead of FIRST_VALUE().
---- While FIRST_VALUE() is a more elegant solution, you should also know how to use ROW_NUMBER() in this pattern. And when 
---- Which is when you need the full row, need to handle ties deliberately, or need to operate on the first and last groups as separate datasets.}

WITH ranked AS (
    SELECT *,
        ROW_NUMBER() OVER (PARTITION BY caller_id, DATE(date_called) ORDER BY date_called ASC) AS ranked_first,
        ROW_NUMBER() OVER (PARTITION BY caller_id, DATE(date_called) ORDER BY date_called DESC) AS ranked_last
    from caller_history
),
first_calls AS (
    SELECT 
        caller_id,
        recipient_id,
        DATE(date_called) AS call_date
    from ranked
    WHERE ranked_first = 1
),
last_calls AS (
    SELECT
        caller_id,
        recipient_id,
        DATE(date_called) AS call_date
    from ranked
    WHERE ranked_last = 1
)
SELECT f.caller_id, f.recipient_id, f.call_date
from first_calls f
join last_calls l 
    on f.caller_id = l.caller_id
    and f.recipient_id = l.recipient_id
    and f.call_date = l.call_date;


-- ****** #2 INTERVIEW PATTERN :- CALCULATE RUNNING TOTALS AND CUMMULATIVE METRICS ******
--- Q2. You are given a day worth of scheduled departure and arrival times of trains at one train station. One platform can only accommodate one train 
-- from the beginning of the minute it's scheduled to arrive until the end of the minute it's scheduled to depart. Find the minimum number of platforms 
-- necessary to accommodate the entire scheduled traffic.

--- combine arrival and departures in one dataset
WITH timetable_cte AS (
    (SELECT
        train_id,
        arrival_time as time,
        1 as mark
    from train_arrives)
    UNION ALL
    (SELECT
        train_id,
        departure_time as time,
        -1 as mark
    from train_departures)
ORDER by time ASC, mark DESC
),
--- calculating the cummulative sum
cum_sum AS (
    SELECT *,
        sum(mark) OVER (ORDER by time ASC, mark DESC) as trains_at_same_time
    FROM timetable_cte
)
--- aggregation and final output
SELECT max(trains_at_same_time) AS min_platforms
from cum_sum;


-- ****** Interview Pattern :- COMPARE THE CURRENT ROW WITH PREVIOUS OR NEXT ROW ********
