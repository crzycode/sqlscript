select * from fashion_Categories

delete from fashion_Categories where type='Booties'

select * from styles
INSERT INTO Women_article_type (Gender,Article_type)
select Gender,Article_type from styles
where Gender = 'women'
group by Gender,Article_type
Having Count(*) > 1

INSERT INTO Womens_accessory (Gender,Article_type)
select Gender,Article_type from styles
where Category = 'Accessories' and Gender = 'women'
group by Gender, Article_type
Having Count(*) > 1

select Article_type from styles where Category = 'Accessories' group by Article_type  Having Count(*) > 1

select * from Accessory_category
select * from fashion_Categories