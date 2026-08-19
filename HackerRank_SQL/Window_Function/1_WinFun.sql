
-------!!!! WINDDOW FUNCTION !!!!-------

SELECT *,
    SUM(e.score) OVER(
        PARTITION BY e.subject
    ) as subject_total
FROM exam_score as e


SELECT *,
    sum(amount) OVER(
        PARTITION BY acc_holder
        ORDER BY trans_date
    ) as closing_balance
from bank_transactions
ORDER BY trans_id


---- ranking window functions

-- row_number(), rank(), dense_rank()

SELECT
    e.stud_id,
    s.stud_name,
    s.branch,
    sum(score) as total_score,
    ROW_NUMBER () OVER (
        PARTITION BY s.branch
        ORDER BY sum(e.score) DESC
    ) as row_number,
    RANK() OVER (
        PARTITION BY s.branch
        ORDER BY sum(e.score) DESC
    ) as rank_num,
    DENSE_RANK() OVER (
        PARTITION BY s.branch
        ORDER BY sum(e.score) DESC
    ) as dense_rank_num
from exam_score as e
INNER JOIN students as s on e.stud_id = s.stud_id
GROUP BY e.stud_id, s.stud_name, s.branch
ORDER BY e.stud_id ASC;