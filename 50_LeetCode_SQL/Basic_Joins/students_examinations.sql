Create table If Not Exists Students (student_id int, student_name varchar(20))
Create table If Not Exists Subjects (subject_name varchar(20))
Create table If Not Exists Examinations (student_id int, subject_name varchar(20))
Truncate table Students
insert into Students values 
('2', 'Bob'),
('13', 'John'),
('6', 'Alex');
Truncate table Subjects
insert into Subjects values 
('Math'),
('Physics'),
('Programming');
Truncate table Examinations
insert into Examinations values 
('1', 'Math'),
('1', 'Physics'),
('1', 'Programming'),
('2', 'Programming'),
('1', 'Physics'),
('1', 'Math'),
('13', 'Math'),
('13', 'Programming'),
('13', 'Physics'),
('2', 'Math'),
('1', 'Math');

/* Students
student_id is the primary key (column with unique values) for this table.
Each row of this table contains the ID and the name of one student in the school.

Subjects
subject_name is the primary key (column with unique values) for this table.
Each row of this table contains the name of one subject in the school.

Examinations
There is no primary key (column with unique values) for this table. It may contain duplicates.
Each student from the Students table takes every course from the Subjects table.
Each row of this table indicates that a student with ID student_id attended the exam of subject_name.

 

Write a solution to find the number of times each student attended each exam.

Return the result table ordered by student_id and subject_name.
*/


SELECT 
    st.student_id, 
    st.student_name, 
    s.subject_name, 
    COUNT(ex.student_id) as attended_exams
FROM Students st
CROSS JOIN Subjects s
LEFT JOIN Examinations ex on st.student_id = ex.student_id AND s.subject_name = ex.subject_name
GROUP BY st.student_id, st.student_name, s.subject_name
ORDER BY st.student_id, s.subject_name

