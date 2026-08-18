create database practise;
use practise;

-- 1) create a table student
create table student(
	id int primary key auto_increment,
    name varchar(50),
    branch varchar(20),
    cgpa decimal(3, 2)
);

-- 2) insert records into table
insert into student (name, branch, cgpa)
values ('akash', 'cse', 8.35),
	   ('dinesh', 'mech', 7.72),
       ('manish', 'ee', 8.00);

-- 3) fetch all records
select * from student;

-- 4) fetch students with cgpa > 8
select * from student
where cgpa > 8;

-- 5) find student whose name start with 'A'
select * from student
where name like 'a%';

-- 6) display unique branch
select distinct branch from student;

-- 7) update cgpa of student
update student
set cgpa = 8.14
where id = 7;

-- 8) delete a student record
delete from student
where id = 9;

-- 9) count total number of students
select count(*) from student;

-- 10) find maximum cgpa
select max(cgpa) from student;

-- 11) find average cgpa
select avg(cgpa) from student;

-- 12) sort students by cgpa(highest first)
select * from student
order by cgpa desc;

-- 13) get top student by mark
select * from student
order by cgpa desc
limit 1;

-- 14) group student by branch
select branch, count(*) as total_students
from student
group by branch;

-- 15) fetch students having average cgpa above 7
select avg(cgpa) as avg_cgpa, branch
from student
group by branch
having avg(cgpa) > 7;

-- 16) create another table 'courses'
create table courses(
	course_id int primary key,
    course_name varchar(40),
    stud_id int
);
insert into courses
values (1, 'python-programming', 7),
	   (2, 'ai/ml', 8),
       (3, 'devops', 14),
       (4, 'java-fullstack', 11),
       (5, 'vfx/animation', 10),
       (6, 'fullstack web-developer', 12),
       (7, 'system designer', 13);
       
select * from courses;

-- 17) inner join
select student.name, courses.course_name
from student
inner join courses
on student.id = courses.stud_id;

-- 18) left join
select student.name, courses.course_name
from student
left join courses
on student.id = courses.stud_id;

-- 19) find students without any course
select student.name
from student
left join courses
on student.id = courses.stud_id
where courses.course_name is null;

-- 20) subquery: students with cgpa above avg
select * from student
where cgpa > (select avg(cgpa) from student);

-- 21) find 2nd highest marks
select max(cgpa)
from student
where cgpa < (select max(cgpa) from student);

-- 22) add a new column 'email'
alter table student
add email varchar(30);

-- 23) remove column
alter table student
drop email;

-- 24) create an index
create index idx_name
on student(name);

-- 25) use transaction
start transaction;
update student set cgpa = 6.46 where id = 13;
rollback;
	