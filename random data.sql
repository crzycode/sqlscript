
INSERT INTO elec_category (image_name,type)
SELECT top 10 u_id,type
FROM products
where type = 'Tablet'

select  type,image_name from elec_category Having Count(*) > 1
ORDER BY NEWID() 




SELECT
DISTINCT type,image_name
FROM elec_category;
Having Count(*) > 1

ORDER BY NEWID() 

select * from users




select type, Count(*) from products
group by type
Having Count(*) > 1

select * from elec_category

SELECT TOP 17 * FROM elec_category ORDER BY NEWID() 

SELECT DISTINCT type
  FROM elec_category
  ORDER BY NEWID() 

delete type from elec_category
group by type
Having Count(*) > 1


  SELECT *
FROM elec_category;


DELETE FROM fashion_categories
    WHERE fashion_cat_id NOT IN
    (
        SELECT MAX(fashion_cat_id) AS MaxRecordID
        FROM fashion_categories
        GROUP BY type
    );

	select type from styles group by type Having Count(*) > 1
	select top 1 * from styles where type ='saree'  ORDER BY NEWID()


UPDATE topElec
SET type = 'Smart Watch'
where type = 'smart watch'
select * from products where off_now like '90%'





UPDATE fashion_categories SET type = 'T-Shirt' where type = 't-shirt'

select * from  top_fashion_products

SELECT TOP 19 * FROM Women_section ORDER BY NEWID() 

select * from products