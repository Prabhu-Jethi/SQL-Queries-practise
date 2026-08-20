
------ Common Table Expression (CTE) ----

-- ** syntax ** ---
-- WITH _____ AS (              ------ Temporary table
        --- ? SQL QUERY
---)


SELECT 
    s.stud_id as student_id,
    s.stud_name as student_name,
    s.branch as student_branch,
    e.score as student_score
from exam_score as e
INNER JOIN students as s on e.stud_id = s.stud_id
WHERE e.score > (
    SELECT avg(score) as class_avg
    from exam_score
);

--- Q1. Query out students with score greater than the average score of class

WITH cls_avg AS (
    SELECT AVG(score) as class_avg
    FROM exam_score
)
SELECT 
    s.stud_id as student_id,
    s.stud_name as student_name,
    s.branch as student_branch,
    e.score as exam_score,
    ca.class_avg as class_average_score
FROM exam_score e
INNER JOIN students s on e.stud_id = s.stud_id
CROSS JOIN cls_avg ca
WHERE e.score > ca.class_avg


--- Q2. Criteria for placement atleast 1 exam attempt have score > 85 and any one of their project shoud have marks > 85

WITH ex_score AS (
    SELECT DISTINCT stud_id
    FROM exam_score 
    WHERE score >= 80
),
pro_score AS (
    SELECT DISTINCT stud_id
    FROM projects
    WHERE marks >= 80
)
SELECT 
    s.stud_id as student_id,
    s.stud_name as student_name,
    s.branch as student_branch
FROM students s
INNER JOIN ex_score ex on ex.stud_id = s.stud_id
INNER JOIN pro_score pr on pr.stud_id = s.stud_id
