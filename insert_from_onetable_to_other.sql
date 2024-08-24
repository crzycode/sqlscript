select * from styles where Product_name like '%men''s%'

select Brand_name, Count(*) as cou from styles
group by Brand_name
Having Count(*) > 1
select * from products where off_now = '50% '

drop table mytable

insert into topdeals(Category_name,Category_image,Deal_type)values('Monitors','A850KYI2','Devices')

UPDATE products
SET type = 'Wired Headset'
where type = 'wired headset'

select * from products where type ='Washinmachine'


select * from topdeals where Deal_type = 'Fashion'
truncate table users

select * from products

INSERT INTO topElec (u_id,Product_name,Offer_price,original_price,off_now,total_rating,total_reviews,rating,description,type)
SELECT top 5 u_id,Product_name,Offer_price,original_price,off_now,total_rating,total_reviews,rating,description,type
FROM products
where type = 'Laptop'
INSERT INTO topElec (u_id,Product_name,Offer_price,original_price,off_now,total_rating,total_reviews,rating,description,type)
SELECT top 5 u_id,Product_name,Offer_price,original_price,off_now,total_rating,total_reviews,rating,description,type
FROM products
where type = 'Earbuds'

INSERT INTO topElec (u_id,Product_name,Offer_price,original_price,off_now,total_rating,total_reviews,rating,description,type)
SELECT top 5 u_id,Product_name,Offer_price,original_price,off_now,total_rating,total_reviews,rating,description,type
FROM products
where type = 'mobile'
INSERT INTO topElec (u_id,Product_name,Offer_price,original_price,off_now,total_rating,total_reviews,rating,description,type)
SELECT top 5 u_id,Product_name,Offer_price,original_price,off_now,total_rating,total_reviews,rating,description,type
FROM products
where type = 'monitor'

INSERT INTO topElec (u_id,Product_name,Offer_price,original_price,off_now,total_rating,total_reviews,rating,description,type)
SELECT top 5 u_id,Product_name,Offer_price,original_price,off_now,total_rating,total_reviews,rating,description,type
FROM products
where type = 'wired headset'

INSERT INTO topElec (u_id,Product_name,Offer_price,original_price,off_now,total_rating,total_reviews,rating,description,type)
SELECT top 5 u_id,Product_name,Offer_price,original_price,off_now,total_rating,total_reviews,rating,description,type
FROM products
where type = 'Tv'



INSERT INTO topElec (u_id,Product_name,Offer_price,original_price,off_now,total_rating,total_reviews,rating,description,type)
SELECT top 5 u_id,Product_name,Offer_price,original_price,off_now,total_rating,total_reviews,rating,description,type
FROM products
where type = 'hdd'

INSERT INTO topElec (u_id,Product_name,Offer_price,original_price,off_now,total_rating,total_reviews,rating,description,type)
SELECT top 5 u_id,Product_name,Offer_price,original_price,off_now,total_rating,total_reviews,rating,description,type
FROM products
where type = 'wired headset'


select * from topElec where type = 'smart watch'

delete from topElec where type = 'smart watch'

UPDATE products
SET type = 'Air Conditioner'
where type = 'AC'

select type, Count(*) from products
group by type
Having Count(*) > 1


SELECT TOP 5 * FROM topElec where type = 'Laptop' ORDER BY NEWID() 


select * from products where type = 'wired headset'
truncate table topElec


select * from fashion_Categories where type = 'Legging-churidar'

UPDATE fashion_Categories
SET image_name = '53366'
where image_name = '3075'

select * from styles where type = 'Swimsuit'





T-shirt

Swimsuit

Kids-sweatshirt