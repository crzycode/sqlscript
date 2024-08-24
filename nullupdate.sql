select * from mytable 
select * from styles
truncate table styles
SELECT name, max_length, precision, scale, is_nullable 
FROM sys.columns
WHERE object_id = OBJECT_ID('dbo.testtable')
SELECT *
FROM mytable
WHERE * IS NULL


select * from mytable where id is null or 
 brand is null or 
 title is null or
 sold_price is null or
 actual_price is null or
 url is null or
 img is null


 UPDATE mytable
SET sold_price = '100'
WHERE sold_price IS NULL;


https://rukminim2.flixcart.com/image/612/612/kjkbv680-0/sari/e/s/t/free-wedding-sarees-vaidehi-fashion-unstitched-original-imafz3zfpjpnrqrn.jpeg?q=70