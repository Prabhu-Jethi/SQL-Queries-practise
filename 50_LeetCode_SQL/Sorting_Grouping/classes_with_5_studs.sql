Create table If Not Exists Courses (student varchar(255), class varchar(255))
Truncate table Courses
insert into Courses (student, class) values 
('A', 'Math'),
('B', 'English'),
('C', 'Math'),
('D', 'Biology'),
('E', 'Math'),
('F', 'Computer'),
('G', 'Math'),
('H', 'Math'),
('I', 'Math');


/*
(student, class) is the primary key (combination of columns with unique values) for this table.
Each row of this table indicates the name of a student and the class in which they are enrolled.

 

Write a solution to find all the classes that have at least five students
*/

SELECT class 
FROM courses
GROUP BY class
HAVING COUNT(student) >= 5;