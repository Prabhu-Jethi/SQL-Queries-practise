
CREATE TYPE yes_no_enum as ENUM ('Y', 'N');

Create table Products(
    product_id serial, 
    low_fats yes_no_enum NOT NULL, 
    recyclable yes_no_enum NOT NULL
);
Truncate table Products
insert into Products (low_fats, recyclable) values 
('Y', 'N'),
('Y', 'Y'),
('N', 'Y'),
('Y', 'Y'),
('N', 'N');


-- Write a solution to find the ids of products that are both low fat and recyclable.

SELECT product_id
FROM Products
WHERE low_fats = 'Y' AND recyclable = 'Y';