select * from Mobile_accessory_category
select * from Mobile_accessory_product



truncate table Mobile_accessory_category
truncate table Mobile_accessory_product
--Category
insert into Mobile_accessory_category(File_name,type)
 select top 1 File_name, type from products where type = 'Smart Watch' 
 insert into Mobile_accessory_category(File_name,type)
select top 1 File_name, type from products where type = 'Tablet' 
insert into Mobile_accessory_category(File_name,type)
select top 1 File_name, type from products where type = 'Ear buds' 
insert into Mobile_accessory_category(File_name,type)
select top 1 File_name, type from products where type = 'Power Bank' 
 insert into Mobile_accessory_category(File_name,type)
select top 1 File_name, type from products where type = 'Wired Headset' 
insert into Mobile_accessory_category(File_name,type)
select top 1 File_name, type from products where type = 'Memory card' 
insert into Mobile_accessory_category(File_name,type)
select top 1 File_name, type from products where type = 'Mobile' 
insert into Mobile_accessory_category(File_name,type)
select top 1 File_name, type from products where type = 'SSD' 
insert into Mobile_accessory_category(File_name,type)
select top 1 File_name, type from products where type = 'Pen Drive' 
insert into Mobile_accessory_category(File_name,type)
select top 1 File_name, type from products where type = 'HDD' 
insert into Mobile_accessory_category(File_name,type)
select top 1 File_name, type from products where type = 'Laptop' 
--product
insert into Mobile_accessory_product(File_name,Product_name,type)
select top 5 File_name,Product_name, type from products where type = 'Smart Watch' 
insert into Mobile_accessory_product(File_name,Product_name,type)
select top 5 File_name,Product_name, type from products where type = 'Tablet' 
insert into Mobile_accessory_product(File_name,Product_name,type)
select top 5 File_name,Product_name, type from products where type = 'Ear buds' 
insert into Mobile_accessory_product(File_name,Product_name,type)
select top 5 File_name,Product_name, type from products where type = 'Power Bank'
insert into Mobile_accessory_product(File_name,Product_name,type)
 
select top 5 File_name,Product_name, type from products where type = 'Wired Headset' 
insert into Mobile_accessory_product(File_name,Product_name,type)
select top 5 File_name,Product_name,type from products where type = 'Memory card'
insert into Mobile_accessory_product(File_name,Product_name,type)
select top 5 File_name,Product_name, type from products where type = 'Mobile' 

insert into Mobile_accessory_product(File_name,Product_name,type)
select top 5 File_name,Product_name, type from products where type = 'SSD' 
insert into Mobile_accessory_product(File_name,Product_name,type)
select top 5 File_name, Product_name,type from products where type = 'Pen Drive' 
insert into Mobile_accessory_product(File_name,Product_name,type)
select top 5 File_name,Product_name, type from products where type = 'HDD' 
insert into Mobile_accessory_product(File_name,Product_name,type)
select top 5 File_name,Product_name, type from products where type = 'Laptop' 

--electronics
insert into Electronics_product_category(File_name,type)
select top 1 File_name, type from products where type = 'Air Conditioner' order by NEWID()
insert into Electronics_product_category(File_name,type)
select top 1 File_name, type from products where type = 'Refrigerator' order by NEWID()
insert into Electronics_product_category(File_name,type)
select top 1 File_name, type from products where type = 'Washing Machine' order by NEWID()
insert into Electronics_product_category(File_name,type)
select top 1 File_name, type from products where type = 'Tv' order by NEWID()
insert into Electronics_product_category(File_name,type)

select top 1 File_name, type from products where type = 'Water Purifier' order by NEWID()
insert into Electronics_product_category(File_name,type)

select top 1 File_name, type from products where type = 'Monitor' order by NEWID()





insert into Electronic_products(File_name,Product_name,type)
select top 5 File_name,Product_name, type from products where type = 'Air Conditioner'

insert into Electronic_products(File_name,Product_name,type)
select top 5 File_name,Product_name, type from products where type = 'Refrigerator'

insert into Electronic_products(File_name,Product_name,type)
select top 5 File_name,Product_name, type from products where type = 'Washing Machine'

insert into Electronic_products(File_name,Product_name,type)
select top 5 File_name,Product_name, type from products where type = 'Tv' 

insert into Electronic_products(File_name,Product_name,type)
select top 5 File_name,Product_name, type from products where type = 'Water Purifier'

insert into Electronic_products(File_name,Product_name,type)
select top 5 File_name,Product_name, type from products where type = 'Monitor' 


select * from Electronics_product_category
select * from Electronic_products

truncate table Electronics_product_category
truncate table Electronic_products

select * from products 