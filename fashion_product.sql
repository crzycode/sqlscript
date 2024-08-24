select * from styles
select Article_type, Count(*) from styles
group by Article_type
Having Count(*) > 1

select * from fashion_Categories

truncate table fashion_Categories

select Article_type from styles where Category = 'Apparel' group by Article_type  Having Count(*) > 1

INSERT INTO top_Fashion_Products ()
SELECT top 5 u_id,Product_name,Offer_price,original_price,off_now,total_rating,total_reviews,rating,description,type
FROM products

seelct 