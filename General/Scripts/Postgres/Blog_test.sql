create table test_category(
cat_id serial primary key,
cat_name varchar,
counts integer,
cat_shortname varchar,
cat_slug varchar,
cat_description text
);
drop table test_category
create table test_tags(
tag_id serial primary key,
tag_name varchar,
counts integer,
tag_description text
)
drop table test_tags
create table test_blog(
blog_id serial primary key,
blog_title varchar,
blog_link varchar,
blog_info jsonb
)

select * from test_tags tt 
select * from test_blog

insert into test_blog(blog_title,blog_link,blog_info)
values('Mangal','Man','{categories:[1,2],tags:[1,2]}')

insert into test_tags(tag_name,counts,tag_description)
values('Cloth',0,'mens Cloths')

insert into test_category(cat_name,counts,cat_shortname,cat_slug,cat_description)
values('Men',0,'Mens Cloths','mens-cloths','description of Mens Category')

select * from test_category

--perfect working for insert blog with tag and category
create or replace function blog_fn_ins(b_title varchar,b_link varchar,b_info jsonb)
returns void
language plpgsql
as $$
declare 
 tag_array TEXT[];
 category_array text[];
 tagid integer[];
 categoryid integer[];
begin
	-- tags
    tag_array := ARRAY(
        SELECT jsonb_array_elements_text(b_info->'tags')
    );
 	IF array_length(tag_array, 1) > 0 THEN
        tagid := tag_ins_upd_by_blog(tag_array);
        b_info := jsonb_set(b_info, '{tags}', to_jsonb(tagid), true);
        RAISE NOTICE 'Tag IDs: %', tagid;
    END IF;
   --category
    category_array := ARRAY(
        SELECT jsonb_array_elements_text(b_info->'categories')
    );
   if array_length(category_array,1) > 0 then
   categoryid:=	category_ins_upd_by_blog(category_array);
   b_info := jsonb_set(b_info, '{categories}', to_jsonb(categoryid), true);
  	RAISE NOTICE 'Tag IDs: %', categoryid;
   END IF;
  
	insert into test_blog(blog_title,blog_link,blog_info)
	values(b_title,b_link,b_info);
end;
$$;

select * from test_tags tt 
--	raise exception '%',b_info->> 'tags';
select * from blog_fn_ins('Mangal','Man','{"categories":[1,2,3],"tags":["man","singh"]}')

select * from test_blog tb 


-- for update 
create or replace function blog_fn_upd(b_blog_id bigint,b_title varchar,b_link varchar,b_info jsonb)
returns void
language plpgsql
as $$
declare 
 new_tag_array TEXT[] := ARRAY[]::TEXT[];
 old_tag_array varchar[] := ARRAY[]::varchar[];
 tagid integer[];
 common_tagid integer[];
 action_tags RECORD;

 new_category_array TEXT[] := ARRAY[]::TEXT[];
 old_category_array TEXT[] := ARRAY[]::TEXT[];
 catid integer[];
 common_catid integer[];
 action_category RECORD;
 blog_information JSONB := '{}'::jsonb; 

begin 
	select blog_info into blog_information from test_blog where blog_id = b_blog_id;
	-- tags
    new_tag_array := ARRAY(
        SELECT jsonb_array_elements_text(b_info-> 'tags')
    );
    old_tag_array := ARRAY(
     SELECT jsonb_array_elements_text(blog_information-> 'tags')
    );
   action_tags:= get_old_and_new(new_tag_array::varchar[],old_tag_array::varchar[]);
   perform tag_remove_upd_by_blog(action_tags.old_values);
   tagid := tag_ins_upd_by_blog(action_tags.new_values);
   common_tagid := action_tags.common_values;
   tagid := tagid || common_tagid;
   b_info := jsonb_set(b_info, '{tags}', to_jsonb(tagid), true);
   raise notice 'new %,old %',action_tags.new_values,action_tags.old_values;
   raise notice 'id %',b_info;
   raise notice 'common %',common_tagid;
  
  
  
      --category
    new_category_array := ARRAY(
        SELECT jsonb_array_elements_text(b_info->'categories')
    );
   
   old_category_array := ARRAY(
        SELECT jsonb_array_elements_text(blog_information->'categories')
    );
  action_category:= get_old_and_new(new_category_array::varchar[],old_category_array::varchar[]);
  perform category_remove_upd_by_blog(action_category.old_values)
  catid := category_ins_upd_by_blog(action_category.new_values);
  common_catid := action_category.common_values;
  catid := catid || common_tagid;
  b_info := jsonb_set(b_info, '{categories}', to_jsonb(catid), true);
   
end;
$$;

select * from blog_fn_upd(43,'Mangal','Man','{"categories":[1,2,3],"tags":[1,13,"mangal"]}')

select * from test_blog tb 
select * from test_tags tt 
truncate table test_blog
truncate table test_tags

