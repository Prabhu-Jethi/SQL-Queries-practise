-- Store Procedure > - prepared SQL code that you can save great if there's a query that you write often.
--                   - reduces network traffic.
--                   - increases performance
--                   - secure, admin can grant permission to use
--                   - increases memory uses of every connection

DELIMITER $$
create PROCEDURE get_cust()
BEGIN
	select * from customers;
END $$
DELIMITER ;

CALL get_cust();
drop PROCEDURE get_cust;


delimiter $$
create PROCEDURE find_cust(IN id int)
begin
	select *
    from customers
    where cust_id = id;
end $$
delimiter ;
call find_cust(3);