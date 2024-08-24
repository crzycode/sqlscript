select * from product where Brand_id = 11
truncate table Varient
select * from product
create view vw_product as
select p.Product_id,Product_name,Product_stock,Brand_name,Brand_image,Brand_url
,Brand_description,
Category_name,Category_image
,combo_Product
,Flavour_name
,Packsizes
,Discount
,MRP
,Image_name
,Smallimage_name
,About_product
,keyBenefits_product
,KeyIngredient_product
,DirectionOfUses_product
,SafetyInformation_product
,Highlight_product
,Varient_name
from product as p
FULL OUTER JOIN brand on brand.Brand_id = p.Brand_id
FULL OUTER JOIN category as c on c.product_id = p.Product_id
Full Outer join subcategory as sub on sub.product_id = p.Product_id
FULL OUTER JOIN combo on Combo_id = p.Product_id
FULL OUTER JOIN flavour on flavour.product_id = p.Product_id
FULL OUTER JOIN packofsize on packofsize.Product_id = p.Product_id
FULL OUTER JOIN price on price.Product_id = p.Product_id
FULL OUTER JOIN productImage on productImage.Product_id = p.Product_id
FULL OUTER JOIN productInfo on productInfo.Product_id = p.Product_id
FULL OUTER JOIN Varient on Varient.product_id = p.Product_id

create view product_price as
select p.Product_id as p_id,Product_name, p.Product_stock,
p.Product_isActive,
c.Discount,
c.price_isActive,
c.MRP,
c.Product_id,
b.brand_name
from product as p
full outer join price as c on c.product_id = p.product_id
full outer join brand as b on b.brand_id = p.Brand_id
select * from cart
truncate table cart
select * from register_user
truncate table register_user

select * from brand
truncate table brand

SELECT Brand_name, 
    COUNT(*) AS CNT
FROM brand
GROUP BY Brand_name
HAVING COUNT(*) > 1;


DELETE FROM brand
    WHERE Brand_id NOT IN
    (
        SELECT MAX(Brand_id) AS MaxRecordID
        FROM brand
        GROUP BY Brand_name
    );

	select * from product
	truncate table product