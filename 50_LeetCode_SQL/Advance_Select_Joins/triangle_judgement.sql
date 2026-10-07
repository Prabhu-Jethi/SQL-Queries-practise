Create table If Not Exists Triangle (x int, y int, z int)
Truncate table Triangle
insert into Triangle (x, y, z) values 
('13', '15', '30'),
('10', '20', '15');

/*
In SQL, (x, y, z) is the primary key column for this table.
Each row of this table contains the lengths of three line segments.

Report for every three line segments whether they can form a triangle.

Return the result table in any order.
*/

SELECT *,
    CASE 
        WHEN x + y > z AND x + z > y AND y + z > x THEN 'Yes' ELSE 'No' 
    END AS triangle
FROM triangle 
