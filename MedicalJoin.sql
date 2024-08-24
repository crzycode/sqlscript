select * from product as p
join brand on brand.mBrand_id = p.idProduct_id
join category as cat on cat.idCategory_id = p.idProduct_id
join combo on combo.idCombo_id = p.idProduct_id
join flavour on flavour.idFlavour_id = p.idProduct_id
join packofsize on packofsize.idPacksize_id = P.idProduct_id
join price on idPrice_id = p.idProduct_id
join productImage on productImage.idImage_id = p.idProduct_id
join productInfo on idinfo_id = p.idProduct_id

join subcategory on idSubcategory_id  = p.idProduct_id
join Varient on idVarient_id = p.idProduct_id