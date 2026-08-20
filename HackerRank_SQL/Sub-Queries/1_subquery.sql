
--- SUB-QUERIES ---

-- Q1. Query out students with score greater than the average score of class

SELECT s.stud_id as student_id,
s.stud_name as student_name,
s.branch as student_branch,
e.score as student_score
from exam_score as e
INNER JOIN students as s on e.stud_id = s.stud_id
WHERE e.score > (
    SELECT avg(score) as class_avg
    from exam_score
);


---- Q2. Criteria for placement atleast 1 exam attempt have score > 80
--- and any one of their project shoud have marks > 85

SELECT s.stud_id, s.stud_name, s.branch
from students as s
where s.stud_id in (
    SELECT stud_id
    from exam_score
    where score > 85
) and s.stud_id in (
    SELECT stud_id
    from projects
    where marks > 85
)


----- Q3. We need to have total score student has earned and number of exams
-- student has attempted.
-- and we also need to have student name and branch in the result.

SELECT s.stud_name, 
s.branch, 
total_stats.total_score,
total_stats.no_of_attempts
from (
    SELECT stud_id, 
    sum(score) as total_score, 
    count(*) as no_of_attempts
    from exam_score
    GROUP by stud_id
) as total_stats    -- temporary table
INNER JOIN students as s on s.stud_id = total_stats.stud_id
ORDER BY total_stats.total_score desc;



----- Q4. For each project get student's name, branch, project marks
-- and their average exam scores on the same row

--!!!! Temporary table is created inside JOIN !!!---

SELECT 
    s.stud_id,
    s.stud_name,
    s.branch,
    p.title,
    p.marks,
    exam_score_avg.avg_score
from projects as p
INNER JOIN students s on s.stud_id = p.stud_id
INNER JOIN (
    SELECT 
        stud_id,
        AVG(score) as avg_score
    from exam_score
    GROUP BY stud_id
) as exam_score_avg on exam_score_avg.stud_id = p.stud_id



------ Q5. There is a need of a report where we have list of exam attempts
--- which are above average (score > average class score). 
-- Also include name of the student in the report.

insert into high_score_report (
    stud_id, 
    stud_name, 
    subject, 
    score
)
SELECT s.stud_id, s.stud_name, e.subject, e.score
from exam_score as e
INNER JOIN students as s on s.stud_id = e.stud_id
where e.score > (
    SELECT avg(score)
    from exam_score
)

SELECT * from high_score_report