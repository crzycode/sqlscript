select * from Ajiowomen

select category, Count(*) from Ajiowomen
group by category
Having Count(*) > 1

select * from Ajiomen where category = '32'

UPDATE Ajiomen
SET category = 'Pant'
where File_name = 'ajio-60066'