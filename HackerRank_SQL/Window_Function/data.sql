

CREATE table bank_transactions(
    trans_id serial PRIMARY KEY,
    acc_holder VARCHAR(100),
    trans_date DATE,
    trans_type VARCHAR(20),
    amount DECIMAL(10, 2)
);
INSERT INTO bank_transactions (
    acc_holder,
    trans_date,
    trans_type,
    amount
) VALUES
('shubham', '2026-01-01', 'deposit', 1000),
('shubham', '2026-01-02', 'withdraw', -200),
('shubham', '2026-01-05', 'deposit', 500),
('shubham', '2026-01-08', 'withdraw', -100),
('rahul', '2026-01-01', 'deposit', 3000),
('rahul', '2026-01-02', 'deposit', 1000),
('rahul', '2026-01-03', 'withdraw', -1000),
('rahul', '2026-01-04', 'deposit', 100);


CREATE TABLE product_info(
    product_id SERIAL PRIMARY KEY NOT NULL,
    product_name VARCHAR(50),
    product_line VARCHAR(50)
);

ALTER TABLE product_info
ADD CONSTRAINT pk_product_info PRIMARY KEY (product_id);

INSERT INTO product_info (product_name, product_line) VALUES
('Quadro RTX 8000', 'GPU'),
('Quadro RTX 6000', 'GPU'),
('GeForce RTX 3060', 'GPU'),
('BlueField-3', 'DPU');


CREATE TABLE transactions (
    transaction_id INT PRIMARY KEY NOT NULL,
    product_id INT REFERENCES product_info(product_id),
    amount INT
);
INSERT INTO transactions VALUES
(101, 1, 5000),
(102, 2, 4200),
(105, 3, 9000),
(107, 4, 7000);


CREATE TABLE product_spend(
    category VARCHAR(40),
    product VARCHAR(40),
    user_id int PRIMARY KEY NOT NULL,
    spend DECIMAL,
    transaction_date TIMESTAMP
);
INSERT INTO product_spend VALUES
('appliance', 'refrigerator', 165, 246.00, '2021-12-26 12:00:00'),
('appliance', 'refrigerator', 123, 299.00, '2022-03-02 12:00:00'),
('appliance', 'washing machine', 125, 219.80, '2022-03-02 12:00:00'),
('electronics', 'vacuum', 178, 152.43, '2022-04-05 12:00:00'),
('electronics', 'wireless headset', 156, 249.90, '2022-07-08 12:00:00'),
('electronics', 'vacuum', 145, 189.00, '2022-07-15 12:00:00');


CREATE TABLE users(
    user_id SERIAL NOT NULL,
    registration_date DATE
);
INSERT INTO users (registration_date) VALUES
('2022-08-15'),
('2022-08-21');


CREATE TABLE rides(
    ride_id SERIAL NOT NULL,
    user_id INT,
    ride_date DATE
);
INSERT INTO rides (user_id, ride_date) VALUES
(1, '2022-08-15'),
(1, '2022-08-16'),
(2, '2022-09-20'),
(2, '2022-09-23');



CREATE TABLE transaction_details (
    transaction_id SERIAL PRIMARY KEY NOT NULL,
    merchant_id INT NOT NULL,
    credit_card_id INT,
    amount INT,
    transaction_timestamp TIMESTAMP
);

ALTER TABLE transaction_details
ADD product_name VARCHAR(50);

INSERT INTO transaction_details (merchant_id, credit_card_id, amount, transaction_timestamp) VALUES
(101, 0123, 150, '2022-09-25 12:00:00'),
(101, 0123, 100, '2022-09-25 12:08:00'),
(101, 0123, 240, '2022-09-25 12:28:00'),
(102, 1234, 500, '2022-09-25 13:00:00'),
(102, 1234, 200, '2022-09-25 14:25:00');

UPDATE transaction_details
SET product_name = 'AirPods'
WHERE transaction_id = 5;

SELECT * FROM transaction_details;


