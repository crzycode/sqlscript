-- store procedure it just a bunch of statement where you convert to bunch of code in single word 
-- store procedure provide the input and output parameter functionality 
create procedure sp_getdatas
as
begin
select * from product
end
sp_getdatas

--input parameter
create procedure sp_getbyid
@id varchar
as
begin
select * from product where Product_name like @id; 
end

sp_getbyid '%ms%'

-- multiple parameter
create procedure sp_getnamedd
@id varchar,
@name varchar
as 
begin
select * from product where Product_name like @name and Brand_name like @id
end

sp_getnamedd '%m%','%d%'

--alter procedure
alter procedure sp_getdata
@id varchar,
@name varchar
as 
begin
select * from product where Product_name like @name and Brand_name like @id
end

sp_getdata '%m%','%d%'

-- check how the query look like 
sp_helptext sp_getdata

-- drop procedure 
drop procedure sp_getbyid