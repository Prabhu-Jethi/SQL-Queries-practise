Create table If Not Exists Queries (query_name varchar(30), result varchar(50), position int, rating int)
Truncate table Queries
insert into Queries (query_name, result, position, rating) values 
('Dog', 'Golden Retriever', '1', '5'),
('Dog', 'German Shepherd', '2', '5'),
('Dog', 'Mule', '200', '1'),
('Cat', 'Shirazi', '5', '2'),
('Cat', 'Siamese', '3', '3'),
('Cat', 'Sphynx', '7', '4');

/*
This table may have duplicate rows.
This table contains information collected from some queries on a database.
The position column has a value from 1 to 500.
The rating column has a value from 1 to 5. Query with rating less than 3 is a poor query.

 

We define query quality as:

    The average of the ratio between query rating and its position.

We also define poor query percentage as:

    The percentage of all queries with rating less than 3.

Write a solution to find each query_name, the quality and poor_query_percentage.

Both quality and poor_query_percentage should be rounded to 2 decimal places.

Return the result table in any order.
*/

SELECT
    query_name,
    ROUND(SUM(rating::numeric / position) / COUNT(result), 2) as quality,
    ROUND(100. * COUNT(rating) FILTER (WHERE rating < 3) / COUNT(rating), 2) as poor_query_percentage
FROM queries
WHERE query_name is NOT NULL
GROUP BY query_name