select * from vwallproducts
create view vwallproducts as

select 
Product_name as product, 
Product_stock,
Brand_name,
Brand_description,
Brand_url,
Brand_image,
Category_name,
Category_image,
Product_id as productid,
Flavour_name,
Packsize,
MRP,
SalePrice,
Discount_amount,
Discount,
Image_name,
Smallimage_name,
About_product,
KeyIngredient_product,
keyBenefits_product,
DirectionOfUses_product,
SafetyInformation_product,
Highlight_product,
Rating as rate,
Rating_count,
Subcategory_name,
Subcategory_image,
Varient_name

from allproduct as a
join product on a.Productname = product.Product_id
join category on a.Category = category.Category_id
join subcategory on a.Subcategory = subcategory.Subcategory_id
join price on a.Price = Price.Price_id
join Varient on a.Varient = Varient.Varient_id
join flavour on a.Flavour = flavour.Flavour_id
join combo on a.Combo = combo.Combo_id
join productImage on a.[Image] = productImage.Image_id
join productInfo on a.ProductInfo = productInfo.info_id
join brand on a.Brand = brand.Brand_id
join packofsize on a.Packsize = packofsize.Packsize_id
join rating on a.Rating = rating.Rating_id


