select * from product where Brand_id = 11
SELECT top 10 Product_name FROM product
WHERE Product_name LIKE 'ah%';
create view product_brand as
select product_name,Brand_name from product as p
inner join brand on brand.brand_id = p.Brand_id

select * from product_brand	where Product_name LIKE 'dm%'


select Product_name,MRP,Packsizes,Brand_name, Count(*) from product_details
group by Product_name,MRP,Packsizes,Brand_name
Having Count(*) > 1

select * from 
select * from product_details where Product_name = 'Atjoint Tablet'

delete from product where product_id = 4708
delete from price where product_id = 4708
delete from packofsize where product_id = 4708

select * from product where Product_id = 9223
select * from price where Product_id = 9223
select * from packofsize where Product_id = 9223
DELETE FROM brand
    WHERE Brand_id NOT IN
    (
        SELECT MAX(Brand_id) AS MaxRecordID
        FROM brand
        GROUP BY Brand_name
    );
	select * from brand
	truncate table brand

select * from product where Product_name = '2baconil 21mg Nicotine Transdermal Patch Step 1'

select * from brand
truncate table product
create view packofsizeproduct as
select p.Product_id, Product_name, name, pack_size_label from product as p
join packof on packof.name = p.Product_name
order by Product_id asc

select * from product as p
join price on price.Product_id = p.Product_id
join packofsize on packofsize.Product_id = p.Product_id
order by p.Product_id asc
select * from packofsize
drop table packof



select * from product order by Product_id asc
select * from price order by Product_id asc
select * from packofsize order by Product_id asc

select * from product

create view vw_product_details as
select top 100 p.Product_id,p.Product_name,Brand_name,MRP,Packsizes,Image_name,Smallimage_name from product as p
join brand on brand.Brand_id = p.Brand_id
join price on price.Product_id = p.Product_id
join packofsize on packofsize.Product_id = p.Product_id
join productImage as im on im.Product_id = p.Product_id;

select * from vw_product_details
select * from Products_2
drop view vw_product_details
where p.Product_name like 'mn%';
select * from vw_product_details where Product_id = 2

select * from productImage


select * from vw_product_details where product_name like 'df%'
where p.Product_name like 'm%';
select * from product_details
truncate table packofsize
select top 10 Product_id,Product_name from product where Product_name like 'df%';
drop view product_details