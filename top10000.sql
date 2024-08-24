select top 10000 Product_id,Product_name from product
select top 10000 Product_id,Product_name from product  where Product_id not in(select top 20000 Product_id from product)
select top 10000 Product_id,Product_name from product  where Product_id not in(select top 30000 Product_id from product)
select top 10000 Product_id,Product_name from product  where Product_id not in(select top 40000 Product_id from product)
select top 10000 Product_id,Product_name from product  where Product_id not in(select top 100000 Product_id from product)
create database allmedical
select * from product where product_name like 'abs%'
select Brand_name, Count(*) from product where Product_name like 'abs%'
group by Brand_name
Having Count(*) > 1

select * from product_Searches where Product_name like '%alex%'
select * from product where Product_id = 22
select * from register_user
truncate table register_user
select * from pincodes where pincode = 400076