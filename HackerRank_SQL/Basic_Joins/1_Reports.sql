CREATE TABLE students(
    id INT,
    NAME VARCHAR(50),
    MARKS INT
);

INSERT INTO students VALUES
(1, 'Julia', 88),
(2, 'Samantha', 68),
(3, 'Maria', 99),
(4, 'Scarlet', 78),
(5, 'Ashley', 63),
(6, 'Jane', 81)

select * from students;

CREATE TABLE grades (
    grade INT,
    min_mark INT,
    max_mark INT
);

INSERT INTO grades VALUES
(1, 0, 9),
(2, 10, 19),
(3, 20, 29),
(4, 30, 39),
(5, 40, 49),
(6, 50, 59),
(7, 60, 69),
(8, 70, 79),
(9, 80, 89),
(10, 90, 100);

SELECT * from grades;


--- QUERY ---
WITH marks_and_grades as (
    SELECT id, name, marks, grade
    from students s
    join grades g on s.marks BETWEEN g.min_mark and g.max_mark
)
SELECT CASE
    WHEN grade >= 8 then NAME ELSE NULL
    END as name, grade, marks
FROM marks_and_grades
ORDER BY grade DESC, name, marks;