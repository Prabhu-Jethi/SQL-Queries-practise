-- DROP TABLE IF EXISTS students;

-- CREATE TABLE students(
--     stud_id SERIAL PRIMARY KEY,
--     stud_name VARCHAR(50) NOT NULL,
--     branch VARCHAR(20) NOT NULL
-- );
-- CREATE TABLE exam_score(
--     score_id SERIAL PRIMARY KEY,
--     stud_id INT NOT NULL REFERENCES students(stud_id),
--     subject VARCHAR(40) NOT NULL,
--     score INT NOT NULL CHECK (score BETWEEN 0 AND 100),
--     exam_month VARCHAR(10) NOT NULL
-- );
-- CREATE TABLE projects(
--     project_id SERIAL PRIMARY KEY,
--     stud_id INT NOT NULL REFERENCES students(stud_id),
--     title VARCHAR(50) NOT NULL,
--     marks INT NOT NULL CHECK (marks BETWEEN 0 AND 100)
-- );

-- INSERT into students (stud_name, branch) VALUES
-- ('Rohan', 'ME'),
-- ('Ashok', 'CS'),
-- ('Riaa', 'CE'),
-- ('Raghav', 'IT'),
-- ('Varun', 'CS'),
-- ('Kavya', 'IT'),
-- ('Meghaa', 'CS');

-- INSERT INTO exam_score (stud_id, subject, score, exam_month) VALUES
-- (1, 'Cloud', 62, '2026-02'),
-- (1, 'Operating', 78, '2026-03'),
-- (1, 'DSA', 58, '2026-03'),
-- (1, 'DBMS', 82, '2026-04'),

-- (2, 'Cloud', 52, '2026-02'),
-- (2, 'OS', 82, '2026-02'),
-- (2, 'DSA', 82, '2026-03'),
-- (2, 'DBMS', 56, '2026-03'),

-- (3, 'Cloud', 61, '2026-03'),
-- (3, 'OS', 77, '2026-03'),
-- (3, 'DSA', 98, '2026-03'),
-- (3, 'DBMS', 71, '2026-04'),

-- (4, 'Cloud', 51, '2026-02'),
-- (4, 'OS', 63, '2026-03'),
-- (4, 'DSA', 45, '2026-03'),
-- (4, 'DBMS', 72, '2026-04'),

-- (5, 'Cloud', 89, '2026-03'),
-- (5, 'OS', 87, '2026-03'),
-- (5, 'DSA', 65, '2026-03'),
-- (5, 'DBMS', 60, '2026-04'),

-- (6, 'Cloud', 75, '2026-02'),
-- (6, 'OS', 91, '2026-03'),
-- (6, 'DSA', 82, '2026-04'),
-- (6, 'DBMS', 60, '2026-04'),

-- (7, 'Cloud', 78, '2026-02'),
-- (7, 'OS', 43, '2026-02'),
-- (7, 'DSA', 55, '2026-03'),
-- (7, 'DBMS', 89, '2026-03');


-- INSERT INTO projects (stud_id, title, marks) VALUES
-- (1, 'Todo-app in react', 67),
-- (2, 'E-Commerce Platform', 81),
-- (3, 'Expense Tracker API', 63),
-- (4, 'Sentiment Analysis', 90),
-- (5, 'Portfolio website', 74),
-- (6, 'Chat bot with websockets', 78),
-- (7, 'RAG based Transformer', 89);

-- SELECT * from projects;





--- SUB-QUERIES ---

-- Q1. Query out students with score greater than the average score of class

SELECT s.stud_id as student_id,
s.stud_name as student_name,
s.branch as student_branch,
e.score as student_score
from exam_score as e
INNER JOIN students as s on e.stud_id = s.stud_id
WHERE e.score < (
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

