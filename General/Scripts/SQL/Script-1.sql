create table public.ins_data(id serial primary key,age numeric,name varchar)

create procedure insert_test(numeric, varchar)
language plpgsql
as $$
begin 
	insert into public.ins_data(age,name) values ($1,$2) RETURNING *;
end;
$$;

CREATE OR REPLACE FUNCTION insertfun_test(p_age numeric, p_name VARCHAR)
RETURNS TABLE (id int, age numeric, name VARCHAR) AS $$
BEGIN
    RETURN QUERY
    INSERT INTO public.ins_data(age, name)
    VALUES (p_age, p_name)
    RETURNING *;
END;
$$ LANGUAGE plpgsql;

drop function insertfun_test
select * from insertfun_test(25,'mangal');
select * from public.ins_data