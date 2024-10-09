create table blog_category (
cat_id serial primary key,
cat_name varchar,
cat_shortname varchar,
cat_slug varchar,
cat_description text,
status boolean default true,
created_by bigint,
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
updated_by bigint,
updated_at timestamp
)

-- insert category 

create or replace function category_fn_ins(c_cat_name varchar,c_cat_short_name varchar,c_cat_slug varchar,c_cat_description text)
returns void
LANGUAGE plpgsql
as $$
begin
	if length(
	c_cat_name) > 2 and 
	c_cat_name is not null and
	length(c_cat_short_name) > 2 and
	c_cat_short_name is not null and 
	length(c_cat_slug) > 2 and
	c_cat_slug is not null then 
		select cat_name, cat_shortname,cat_slug from blog_category where 
		replace(lower(trim(cat_name)),' ','') = replace(lower(trim(c_cat_name)),' ','')  or
		replace(lower(trim(cat_shortname)),' ','') = replace(lower(trim(c_cat_short_name)),' ','') or 
		replace(lower(trim(cat_slug)),' ','') = replace(lower(trim(c_cat_short_name)),' ','')
		if found then
		
	else 
		raise exception 'cant';
	end if;
	
end;
$$;

select * from category_fn_ins(null::varchar,'cat'::varchar,'cat_slug'::varchar,'description'::text)




create or replace function mst.blog_func_ins(
b_blog_title varchar,
b_content text,
b_blog_link varchar,
b_seo_settings jsonb,
b_blog_info jsonb,
b_social_settings jsonb,
b_featured_image text,
b_thumbnail text,
b_blog_views int,
b_status boolean,
b_staff_id bigint,
b_merchant_id bigint,
b_tags text[]
)
RETURNS TABLE (
    blog_id integer,
    blog_title VARCHAR,
    blog_link varchar,
    blog_thumbnail TEXT,
    author_name TEXT,
    tags TEXT,
    categories TEXT,
    blog_views INT,
    created_at TIMESTAMP,
    blog_status boolean)
	as $$
DECLARE
	unmatched_tag_count INT;
	j int;
	unmatched_og_tag text;
	unmatched_tag text;
	unmatched_tags text[];
	unmatched_tag_id INTEGER;
	unmatched_og_tags text[]:= ARRAY[]::TEXT[];
	inserted_tag_ids INTEGER[] := ARRAY[]::INTEGER[];
 	category_ids integer[];
BEGIN
 -- Get unmatched tags
	perform 1 from prd.alt_blogs abc where replace(trim(lower(abc.blog_title)),' ','') = b_blog_title or replace(trim(lower(abc.blog_link)),' ','') = b_blog_link;
	if found then 
		raise exception 'Link Or Title Already Exist';
	else 
  IF array_length(b_tags, 1) > 0 THEN
	inserted_tag_ids := prd.increment_fn_tag(ARRAY[b_tags],b_merchant_id,b_staff_id);
    IF inserted_tag_ids IS NOT NULL AND array_length(inserted_tag_ids, 1) > 0 THEN
        b_blog_info := jsonb_set(b_blog_info, '{tags}', b_blog_info->'tags' || to_jsonb(inserted_tag_ids), true);
    END IF;
end if;
  IF jsonb_array_length(b_blog_info->'categories') > 0 THEN
        SELECT array_agg((value::integer)) INTO category_ids
        FROM jsonb_array_elements_text(b_blog_info->'categories') AS value;
        PERFORM prd.increment_fn_cat(category_ids);
  end if;
 end if;
		 RETURN QUERY
	 		insert into prd.alt_blogs(blog_title,blog_content,blog_link,blog_seo,blog_info,blog_social,blog_feature_image,
	 							blog_thumbnail,blog_views,blog_status,created_by,merchant_id)
                          values(b_blog_title::varchar,
                          b_content::text,
                          b_blog_link::varchar,
                          b_seo_settings::jsonb,
                          b_blog_info::jsonb,
                          b_social_settings::jsonb,
                          b_featured_image::text,
                          b_thumbnail::text,
                          b_blog_views::int,
                          b_status::boolean,
                          b_staff_id::bigint,
                          b_merchant_id::bigint) 
                          RETURNING prd.alt_blogs.blog_id,
                          prd.alt_blogs.blog_title,
                          prd.alt_blogs.blog_link,
                          prd.alt_blogs.blog_thumbnail,
                          prd.alt_blogs.blog_info->> 'author_name' as author_name,
                          prd.alt_blogs.blog_info->> 'tags' as tags,
                          prd.alt_blogs.blog_info->> 'categories' as categories,
                          prd.alt_blogs.blog_views,
                          prd.alt_blogs.created_at,
                          prd.alt_blogs.blog_status;
	
END $$ LANGUAGE plpgsql;





CREATE OR REPLACE FUNCTION prd.increment_fn_tag( t_tags text[])
RETURNS bigint[]
LANGUAGE plpgsql
AS $$
DECLARE
    matched_count INTEGER;
    tag_name_record RECORD;
    unmatched_count INTEGER;
    inserted_tag_id bigint;
    inserted_tag_ids bigint[];
BEGIN
    -- Count unmatched tags
    WITH original_tags AS (
        SELECT unnest(ARRAY[t_tags]) AS original_tag
    ),
    unmatched AS (
        SELECT original_tag, LOWER(REPLACE(original_tag, ' ', '')) AS modified_tag
        FROM original_tags
        EXCEPT
        SELECT tag_name, LOWER(REPLACE(tag_name, ' ', '')) 
        FROM test_tags
    )
    SELECT COUNT(*) INTO unmatched_count
    FROM unmatched;

    -- Insert unmatched tags
    IF unmatched_count > 0 THEN       
        FOR tag_name_record IN 
            SELECT original_tag 
            FROM (
                WITH original_tags AS (
                    SELECT unnest(ARRAY[t_tags]) AS original_tag
                ),
                unmatched AS (
                    SELECT original_tag, LOWER(REPLACE(original_tag, ' ', '')) AS modified_tag
                    FROM original_tags
                    EXCEPT
                    SELECT tag_name, LOWER(REPLACE(tag_name, ' ', '')) 
                    FROM test_tags
                )
                SELECT original_tag FROM unmatched
            ) AS unmatched_tags
        LOOP           
            INSERT INTO test_tags (tag_name,counts, tag_description)
            VALUES (tag_name_record.original_tag,1 NULL)
            RETURNING tag_id INTO inserted_tag_id;
            inserted_tag_ids := array_append(inserted_tag_ids, inserted_tag_id);
        END LOOP;
    END IF;

    -- Count matched tags
    WITH original_tags AS (
        SELECT unnest(ARRAY[t_tags]) AS original_tag
    ),
    matched AS (
        SELECT original_tag, LOWER(REPLACE(original_tag, ' ', '')) AS modified_tag
        FROM original_tags
        INTERSECT
        SELECT tag_name, LOWER(REPLACE(tag_name, ' ', '')) 
        FROM test_tags
    )
    SELECT COUNT() INTO matched_count
    FROM matched;

    -- Update matched tags
    IF matched_count > 0 THEN
        FOR tag_name_record IN 
            SELECT original_tag 
            FROM (
                WITH original_tags AS (
                    SELECT unnest(ARRAY[t_tags]) AS original_tag
                ),
                matched AS (
                    SELECT original_tag, LOWER(REPLACE(original_tag, ' ', '')) AS modified_tag
                    FROM original_tags
                    INTERSECT
                    SELECT tag_name, LOWER(REPLACE(tag_name, ' ', '')) 
                    FROM test_tags
                )
                SELECT original_tag FROM matched
            ) AS matched_tags
        LOOP
            UPDATE test_tags
            SET tag_usagecount = tag_usagecount + 1
            WHERE LOWER(REPLACE(tag_name, ' ', '')) = LOWER(REPLACE(tag_name_record.original_tag, ' ', ''));
        END LOOP;
    END IF;
    RETURN inserted_tag_ids;
END $$;

-- find new one by mached old one 
-- if find then if string or number update and return id if not then insert and return id
-- find old one by matching new one
-- if find then  number or string decrease the value by one 


-- category
-- first store old value in variable and category column replace with new 
-- find new one by mached old one then update by one 
-- find old one and decrease 


SELECT 
  CASE
    WHEN '1231234567' ~ '^[0-9]+$' THEN TRUE  -- Check if it's a number
    ELSE FALSE
  END AS is_number;
 
 
 
 -- perfectely working 
 CREATE OR REPLACE FUNCTION category_ins_upd_by_blog(b_category TEXT[])
RETURNS INTEGER[]
LANGUAGE plpgsql
AS $$
DECLARE 
    element TEXT;
   	categoryid_array INTEGER[] := ARRAY[]::INTEGER[];
   	catid integer;
BEGIN 
    FOREACH element IN ARRAY b_category LOOP
       perform 1 from test_category where cat_id = element::integer;
            if found then 
            	update test_category set counts = counts + 1 where cat_id = element::integer
            	RETURNING cat_id INTO catid;
          	 categoryid_array := array_append(categoryid_array, catid::INTEGER);
            END IF;
    END LOOP;
    RETURN categoryid_array;
END;
$$;


 CREATE OR REPLACE FUNCTION category_remove_upd_by_blog(b_category TEXT[])
RETURNS INTEGER[]
LANGUAGE plpgsql
AS $$
DECLARE 
    element TEXT;
   	categoryid_array INTEGER[] := ARRAY[]::INTEGER[];
   	catid integer;
BEGIN 
    FOREACH element IN ARRAY b_category LOOP
       perform 1 from test_category where cat_id = element::integer;
            if found then 
            	update test_category set counts = GREATEST(counts - 1, 0) where cat_id = element::integer
            	RETURNING cat_id INTO catid;
          	 categoryid_array := array_append(categoryid_array, catid::INTEGER);
            END IF;
    END LOOP;
    RETURN categoryid_array;
END;
$$;
select * from category_ins_upd_by_blog('{2,1}')

select * from test_category tc 
