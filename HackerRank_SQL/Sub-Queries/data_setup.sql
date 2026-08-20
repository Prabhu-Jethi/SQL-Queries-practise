DROP TABLE IF EXISTS students;

CREATE TABLE students(
    stud_id SERIAL PRIMARY KEY,
    stud_name VARCHAR(50) NOT NULL,
    branch VARCHAR(20) NOT NULL
);
CREATE TABLE exam_score(
    score_id SERIAL PRIMARY KEY,
    stud_id INT NOT NULL REFERENCES students(stud_id),
    subject VARCHAR(40) NOT NULL,
    score INT NOT NULL CHECK (score BETWEEN 0 AND 100),
    exam_month VARCHAR(10) NOT NULL
);
CREATE TABLE projects(
    project_id SERIAL PRIMARY KEY,
    stud_id INT NOT NULL REFERENCES students(stud_id),
    title VARCHAR(50) NOT NULL,
    marks INT NOT NULL CHECK (marks BETWEEN 0 AND 100)
);

INSERT into students (stud_name, branch) VALUES
('Rohan', 'ME'),
('Ashok', 'CS'),
('Riaa', 'CE'),
('Raghav', 'IT'),
('Varun', 'CS'),
('Kavya', 'IT'),
('Meghaa', 'CS');

INSERT INTO exam_score (stud_id, subject, score, exam_month) VALUES
(1, 'Cloud', 62, '2026-02'),
(1, 'Operating', 78, '2026-03'),
(1, 'DSA', 58, '2026-03'),
(1, 'DBMS', 82, '2026-04'),

(2, 'Cloud', 52, '2026-02'),
(2, 'OS', 82, '2026-02'),
(2, 'DSA', 82, '2026-03'),
(2, 'DBMS', 56, '2026-03'),

(3, 'Cloud', 61, '2026-03'),
(3, 'OS', 77, '2026-03'),
(3, 'DSA', 98, '2026-03'),
(3, 'DBMS', 71, '2026-04'),

(4, 'Cloud', 51, '2026-02'),
(4, 'OS', 63, '2026-03'),
(4, 'DSA', 45, '2026-03'),
(4, 'DBMS', 72, '2026-04'),

(5, 'Cloud', 89, '2026-03'),
(5, 'OS', 87, '2026-03'),
(5, 'DSA', 65, '2026-03'),
(5, 'DBMS', 60, '2026-04'),

(6, 'Cloud', 75, '2026-02'),
(6, 'OS', 91, '2026-03'),
(6, 'DSA', 82, '2026-04'),
(6, 'DBMS', 60, '2026-04'),

(7, 'Cloud', 78, '2026-02'),
(7, 'OS', 43, '2026-02'),
(7, 'DSA', 55, '2026-03'),
(7, 'DBMS', 89, '2026-03');


INSERT INTO projects (stud_id, title, marks) VALUES
(1, 'Todo-app in react', 67),
(2, 'E-Commerce Platform', 81),
(3, 'Expense Tracker API', 63),
(4, 'Sentiment Analysis', 90),
(5, 'Portfolio website', 74),
(6, 'Chat bot with websockets', 78),
(7, 'RAG based Transformer', 89);

SELECT * from projects;


create table high_score_report(
    id serial PRIMARY KEY,
    stud_id int NOT NULL REFERENCES students(stud_id),
    stud_name VARCHAR(50) NOT NULL,
    subject VARCHAR(30) NOT NULL,
    score int NOT NULL,
    archived_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);



CREATE TABLE salesman(
    salesman_id int PRIMARY KEY NOT NULL,
    name VARCHAR(50) NOT NULL,
    city VARCHAR(40),
    commission FLOAT NOT NULL
);
INSERT INTO salesman VALUES
(5001, 'James Hoog', 'New York', 0.15),
(5002, 'Nail Knite', 'Paris', 0.13),
(5005, 'Pit Alex', 'London', 0.11),
(5006, 'Mc Lyon', 'Paris', 0.14),
(5003, 'Lauson Hen', NULL, 0.12),
(5007, 'Paul Adam', 'Rome', 0.13);

CREATE TABLE cust(
    customer_id int NOT NULL,
    customer_name VARCHAR(50),
    city VARCHAR(20),
    grade int,
    salesman_id INT
);
INSERT into cust VALUES
(3002, 'Nick Rimando', 'New York', 100, 5001),
(3005, 'Graham Bell', 'California', 200, 5002),
(3001, 'Brad Guzaan', 'London', NULL, 5005),
(3004, 'Fabian Ruis', 'Paris', 300, 5006),
(3007, 'Brad Davis', 'New York', 200, 5001),
(3009, 'Geoff Camero', 'Berlin', 100, 5003),
(3008, 'Julian Green', 'London', 300, 5002),
(3003, 'Jozy Altider', 'Moscow', NULL, 5007);

CREATE TABLE customer_orders(
    ord_no serial PRIMARY KEY,
    puch_amt FLOAT NOT NULL,
    ord_date DATE NOT NULL,
    customer_id int NOT NULL,
    salesman_id INT NOT NULL
);
INSERT INTO customer_orders (puch_amt, ord_date, customer_id, salesman_id) VALUES
(150.5, '2012-10-05', 3005, 5002),
(270.65, '2012-09-10', 3001, 5005),
(65.26, '2012-10-05', 3002, 5001),
(110.5, '2012-08-17', 3009, 5003),
(948.5, '2012-09-10', 3005, 5002),
(2400.6, '2012-07-27', 3007, 5001),
(5760, '2012-09-10', 3002, 5001),
(1983.43, '2012-10-10', 3009, 5003),
(2480.4, '2012-10-10', 3004, 5006),
(250.45, '2012-06-27', 3003, 5007);


CREATE TABLE company_mast(
    comp_id serial PRIMARY KEY,
    comp_name VARCHAR(50) NOT NULL
);
INSERT INTO company_mast (comp_name) VALUES
('Samsung'),
('IBall'),
('Epsion'),
('Zebronics'),
('Asus'),
('Frontech');



CREATE TABLE item_mast(
    prod_id serial PRIMARY KEY,
    prod_name VARCHAR(50) NOT NULL,
    prod_price INT NOT NULL,
    prod_comp_id INT not NULL
);
INSERT INTO item_mast (prod_name, prod_price, prod_comp_id) VALUES
('Mother Board', 3200, 3),
('Key Board', 450, 2),
('ZIP device', 250, 1),
('speaker', 550, 4),
('monitor', 5200, 1),
('dvd drive', 900, 6),
('cd drive', 800, 2),
('printer', 2400, 3),
('refill cartridge', 350, 5),
('mouse', 260, 4);



CREATE TABLE emp_department(
    dept_id serial PRIMARY Key NOT NULL,
    dept_name VARCHAR(40),
    dept_allotment INT NOT NULL
);
INSERT INTO emp_department (dept_name, dept_allotment) VALUES
('HR', 45000),
('IT', 50000),
('Sales', '42500'),
('Management', 73000),
('Finance', 45000);

CREATE TABLE emp_details(
    emp_id serial PRIMARY KEY,
    emp_fname VARCHAR(50),
    emp_lname VARCHAR(50),
    emp_dept INT NOT NULL
);
INSERT INTO emp_details (emp_fname, emp_lname, emp_dept) VALUES
('Michale', 'Robinson', 4),
('Thiodore', 'Forges', 2),
('Robert', 'Downey', 2),
('Williams', 'Mendes', 1),
('Potts', 'Pepper', 1),
('Jenifer', 'Lorens', 5),
('Matthews', 'Mayden', 3),
('Jacob', 'Eddie', 3),
('Robert', 'Patkinson', 1),
('Charlie', 'Jenner', 3),
('Karen', 'Fukahuraa', 2),
('Max', 'Amini', 5),
('Luis', 'Nair', 4),
('Aman', 'Gupta', 5);