SET IDENTITY_INSERT productImage on


select * from product
select * from productImage
select * from packofsize
select * from price
select * from brand

create view vw_product_details as
select top 100 p.Product_id,Product_name,
Product_stock,
Brand_name,
MRP,
Packsizes,
Image_name
from product as p
join brand as b on b.Brand_id = p.Brand_id
join price as c on c.Product_id = p.Product_id
join packofsize as s on s.Product_id = p.Product_id
join productImage as i on i.Product_id = p.Product_id
where p.Product_name like 'dm%'

select * from vw_product_details where Product_name like 'm%'
CREATE INDEX vw_product_details_index
on vw_product_details(Product_id);

CREATE INDEX product_id_index
on product (Product_id);
CREATE INDEX productImage_index
on productImage (Product_id);
CREATE INDEX packofsize_index
on packofsize(Packsize_id);
CREATE INDEX price_index
on price(Product_id);
drop index product.product_index