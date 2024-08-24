show databases
use revision
select * from master
select * from products

ALTER TABLE products
ALTER COLUMN p_name NVARCHAR(100);

CREATE PROCEDURE InsertAndReturnRow
    @p_name varchar(100),
    @p_price decimal,
    @p_total decimal
AS
BEGIN
    SET NOCOUNT ON;

    -- Insert the new row
    INSERT INTO products  (p_name, p_price,p_total)
    VALUES (@p_name, @p_price,@p_total);
    SELECT * 
    FROM products 
    WHERE p_id = SCOPE_IDENTITY();  -- Replace with your primary key column

END;

CREATE FUNCTION insertdata (
    @p_name VARCHAR(100),
    @p_price DECIMAL(18,2),
    @p_total DECIMAL(18,2)
)
RETURNS TABLE
AS
RETURN
(
    INSERT INTO products (p_name, p_price, p_total)
    OUTPUT 
        inserted.p_id,
        inserted.p_name,
        inserted.p_price,
        inserted.p_total
    VALUES (@p_name, @p_price, @p_total)
)


create function fn_getall()
returns table
as 
return(select * from products)


create function inserttable(   
	@p_name varchar(100),
    @p_price decimal,
    @p_total decimal)
returns table
as 
begin
	  INSERT INTO products  (p_name, p_price,p_total)
    VALUES (@p_name, @p_price,@p_total);
end;

drop procedure InsertAndReturnRow
EXEC InsertAndReturnRow @p_name = "hello" , @p_price =24 , @p_total= 34;
create database revision
select * from fn_getall()