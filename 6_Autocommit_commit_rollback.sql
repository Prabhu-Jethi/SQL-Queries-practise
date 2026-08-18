SET AUTOCOMMIT = OFF;
-- cancels auto saving or auto commits--

DELETE FROM Emp;
SELECT * FROM Emp;

ROLLBACK;
-- undo any changes

-- COMMIT;
-- manually commit any changes
