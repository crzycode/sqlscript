create table blog_tags(tag_id serial primary key,
tag_name varchar,
tag_description text,
status boolean default true,
created_by bigint,
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
updated_by bigint,
updated_at timestamp)

--insert tags
create or replace function tag_fn_ins(b_tag_name varchar,b_tag_description text,b_created_by bigint)
returns table(tag_id bigint,tag_name varchar,tag_description text,status boolean,created_at timestamp)
as $$
declare
	istagexist varchar;
begin
	if length(b_tag_name) > 2 then
		istagexist := replace(lower(trim(b_tag_name)),' ','');
		perform 1 from blog_tags where REPLACE(LOWER(TRIM(blog_tags.tag_name)), ' ', '') = istagexist;
		if found then 
			raise exception 'This Tag Name Already Exist Please Try Something New !';
		else 
			return query
			insert into blog_tags(tag_name,tag_description,created_by)
			values(b_tag_name,b_tag_description,b_created_by)
			returning blog_tags.tag_id::bigint,blog_tags.tag_name,blog_tags.tag_description,blog_tags.status,blog_tags.created_at;	
		end if;
	else
		raise exception 'Tag Name Is Required Please Try Again';
	end if;
end;
$$ language plpgsql;

select * from blog_tags
select * from tag_fn_ins('man'::varchar,'qwertyusdfghj'::text,2::bigint)

--update blog_tags 

create or replace function tag_fn_upd(b_tag_id bigint,b_tag_name varchar,b_tag_description text,b_updated_by bigint)
returns table(tag_id bigint,tag_name varchar,tag_description text,status boolean,created_at timestamp)
as $$
declare
istagexist varchar;
begin
	if length(b_tag_name) > 2 then
		istagexist := replace(lower(trim(b_tag_name)),' ','');
		perform 1 from blog_tags c where c.tag_id != b_tag_id and REPLACE(LOWER(TRIM(c.tag_name)), ' ', '') = istagexist;
		if found then 
			raise exception 'This % Tag Alread Exist',b_tag_name;
		else
			return query
			update blog_tags set
					tag_name = b_tag_name,
					tag_description = b_tag_description,
					updated_at = current_timestamp,
					updated_by = b_updated_by where blog_tags.tag_id = b_tag_id
					returning blog_tags.tag_id::bigint,blog_tags.tag_name,blog_tags.tag_description,blog_tags.status,blog_tags.created_at;		
		end if;
	else
		raise exception 'Tag Name Is Required Please Try Again';
	end if;
end;
$$ language plpgsql;


select * from tag_fn_upd(2::bigint,'Men'::varchar,'Hello Mens'::text,2::bigint)

--update status
create or replace function tag_fn_upd_status(b_tag_id bigint,b_updated_by bigint)
returns boolean
as $$
declare 
	isstatus boolean;
begin 
	select status into isstatus from blog_tags where tag_id = b_tag_id;
	IF NOT FOUND THEN
        RAISE EXCEPTION 'Tag with ID % does not exist.', b_tag_id;
    END IF;
	if isstatus = true then
		UPDATE blog_tags SET 
		status = false,
		updated_at = current_timestamp,
		updated_by = b_updated_by
        WHERE tag_id = b_tag_id;
        RETURN FALSE; 
	else
		UPDATE blog_tags SET 
		status = true,
		updated_at = current_timestamp,
		updated_by = b_updated_by
        WHERE tag_id = b_tag_id;
        RETURN TRUE;  
	end if;
end;
$$ language plpgsql;

--get all tags

create or replace function tag_fn_getall()
returns table(tag_id bigint,tag_name varchar,tag_description text,status boolean,created_at timestamp)
as $$
begin
	return query
	SELECT b.tag_id::bigint,b.tag_name,b.tag_description,b.status,b.created_at FROM blog_tags b;
end;
$$ language plpgsql;
drop function tag_fn_getall
select * from tag_fn_getall()

--get by id

create or replace function tag_fn_findbyid(b_tag_id bigint)
returns table(tag_id bigint,tag_name varchar,tag_description text,status boolean,created_at timestamp)
as $$
begin 
	RETURN query
 	SELECT b.tag_id::bigint,b.tag_name,b.tag_description,b.status,b.created_at FROM blog_tags b WHERE b.tag_id = b_tag_id;
    IF NOT FOUND THEN
        RAISE EXCEPTION 'This Tag does not exist.';
    END IF;
end;
$$ language plpgsql;


-- insert or update tags and return id array 
CREATE OR REPLACE FUNCTION tag_ins_upd_by_blog(b_tags TEXT[])
RETURNS INTEGER[]
LANGUAGE plpgsql
AS $$
DECLARE 
    element TEXT;
   	tagsid_array INTEGER[] := ARRAY[]::INTEGER[];
   	tagid integer;
BEGIN 
    FOREACH element IN ARRAY b_tags LOOP
        IF element ~ '^[0-9]+$' THEN  
            perform 1 from test_tags where tag_id = element::integer;
            if found then 
            	update test_tags set counts = counts + 1 where tag_id = element::integer
            	RETURNING tag_id INTO tagid;
          	 tagsid_array := array_append(tagsid_array, tagid::INTEGER);
            END IF;
        ELSE 
        	perform 1 from test_tags where replace(lower(trim(tag_name)),' ','')  = replace(lower(trim(element)),' ',''); 
        	if found then 
        		update test_tags set counts = counts + 1 where replace(lower(trim(tag_name)),' ','')  = replace(lower(trim(element)),' ','') 
            	RETURNING tag_id INTO tagid;
          	 tagsid_array := array_append(tagsid_array, tagid::INTEGER);
          	else
          		insert into test_tags(tag_name,counts,tag_description)
				values(element,1,null)
				RETURNING tag_id INTO tagid;
          	 	tagsid_array := array_append(tagsid_array, tagid::INTEGER);
          	end if;
        END IF;
    END LOOP;
    RETURN tagsid_array;
END;
$$;


CREATE OR REPLACE FUNCTION tag_remove_upd_by_blog(b_tags TEXT[])
RETURNS INTEGER[]
LANGUAGE plpgsql
AS $$
DECLARE 
    element TEXT;
   	tagsid_array INTEGER[] := ARRAY[]::INTEGER[];
   	tagid integer;
BEGIN 
    FOREACH element IN ARRAY b_tags LOOP
        IF element ~ '^[0-9]+$' THEN  
            perform 1 from test_tags where tag_id = element::integer;
            if found then 
            	update test_tags set counts = GREATEST(counts - 1, 0) where tag_id = element::integer
            	RETURNING tag_id INTO tagid;
          	 tagsid_array := array_append(tagsid_array, tagid::INTEGER);
            END IF;
        END IF;
    END LOOP;
    RETURN tagsid_array;
END;
$$;
select * from tag_remove_upd_by_blog('{5}')
select * from test_tags tt 


CREATE OR REPLACE FUNCTION get_old_and_new(
  new_array varchar[],
  old_array varchar[]
) 
RETURNS TABLE(new_values varchar[], old_values varchar[], common_values varchar[]) AS $$
DECLARE
  new_vals varchar[];
  old_vals varchar[];
  common_vals varchar[];
BEGIN
  -- Calculate new and old values
  SELECT
    ARRAY(SELECT unnest(new_array) EXCEPT SELECT unnest(old_array)),
    ARRAY(SELECT unnest(old_array) EXCEPT SELECT unnest(new_array)),
    ARRAY(SELECT unnest(new_array) INTERSECT SELECT unnest(old_array))
  INTO new_vals, old_vals, common_vals;

  -- Raise notice for the calculated values
  RAISE NOTICE 'New Values: %, Old Values: %, Common Values: %', new_vals, old_vals, common_vals;

  -- Return the results
  RETURN QUERY SELECT new_vals, old_vals, common_vals;
END;
$$ LANGUAGE plpgsql;

drop function get_old_and_new

select * from get_old_and_new(array[4,12]::varchar[],array[4,'hello']::varchar[])
