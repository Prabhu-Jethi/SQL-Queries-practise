

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

