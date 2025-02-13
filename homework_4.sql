--1
create table party_guest (id serial primary key, name varchar(50), email varchar(50), is_visited boolean default false);

alter table party_guest add constraint name_is_not_null_not_empty check(name is not null and name <> '');

alter table party_guest add constraint email_is_not_null_not_empty check(name is not null and name <> '');
alter table party_guest add constraint email_unique unique(email);
alter table party_guest add constraint email_correct check( email ~ '^[^@]+@[^@]+\.[^@]+$');

alter table party_guest add constraint is_visited_not_null check(is_visited is not null);

--2
create user manager with password '1234';
grant usage on schema public to manager;
grant select, insert on table party_guest to manager;
--grant insert on table party_guest to manager;
grant usage, update on sequence party_guest_id_seq to manager;

--3
create view party_guest_name as (select name from party_guest);

--4
create user guard with password 'password';
grant usage on schema public to guard;
grant select on table party_guest_name to guard;

--5
set role manager;
insert into party_guest(name, email) values
('Charles', 'charles_ny@yahoo.com'),
('Charles', 'mix_tape_charles@google.com'),
('Teona', 'miss_teona_99@yahoo.com');

--6
set role guard;
select * 
from party_guest_name;

--7
set role postgres;

--8
create or replace procedure party_end()
language plpgsql
as $$
	begin
		create table if not exists black_list (id serial primary key, email varchar(50));
		insert into black_list (email) select email from party_guest where is_visited = false;
		delete from party_guest where is_visited = false;
	end;
$$;

--9
create or replace function register_to_party(_name varchar, _email varchar)
returns boolean
language plpgsql
as $$
	declare
		
		is_table_black_list_exists boolean;
		is_exists_in_black_list boolean := false;
	begin
		is_table_black_list_exists := (select to_regclass('public.black_list') is not null);
		if is_table_black_list_exists then
			is_exists_in_black_list := (select count(*) <> 0 from black_list bl where _email = bl.email);			
		end if;		
		
		if not is_exists_in_black_list then
			insert into party_guest(name, email, is_visited) values (_name, _email, true);
			return true;
		end if;
		
		return false;
	end;
$$;

--10
select register_to_party('Petr', 'korol_party2@yandex.ru');

--11
call party_end();

