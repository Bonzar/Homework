show tables from vk_full_update;

select * from users limit 100;

insert into user_statuses (name) values
	('active'),
	('blocked'),
	('deleted');

ALTER TABLE users ADD status_id int(120) after phone;
update users set status_id = FLOOR(1 + RAND() * 3);

select id from media where (media_type_id = 2) order by rand() limit 1;

update friendship set confirmed_at = null where status_id = 1;

describe friendship;

update messages set to_user_id = FLOOR(1 + RAND() * 100) where from_user_id = to_user_id;

alter table friendship drop requested_at;

update media set updated_at = (select created_at from media ORDER BY RAND() LIMIT 1);

select created_at from media ORDER BY RAND() LIMIT 1;

update friendship set status_id = FLOOR(1 + RAND() * 3);

TRUNCATE friendship_statuses;

ALTER TABLE messages ADD media_id int(120) after body;

DELETE FROM communities WHERE id > 20;

UPDATE communities_users SET community_id = FLOOR(1 + RAND() * 20);

INSERT INTO friendship_statuses (name) VALUES
  ('Requested'),
  ('Confirmed'),
  ('Rejected');

update friendship set confirmed_at = null where confirmed_at < updated_at;
update friendship set updated_at = created_at where created_at > updated_at;

update media set size = floor(1000 + rand() * 100000) where `size` < 1000;

update media set filename = concat(
"https://yandx.disc/vk/",
filename,
".",
(select name from extensions where id = media_type_id limit 1)
);


select name from extensions where id = (select id from media_types mt ORDER BY RAND() limit 1);
select name from extensions where id = 1;



create temporary table extensions (id int primary key auto_increment, name varchar(10));
drop table extensions;
select * from extensions;
insert into extensions (name) values ('mp3'), ('png'), ('mkv');

UPDATE media SET metadata = CONCAT('{"owner":"', 
  (SELECT CONCAT(first_name, ' ', last_name) FROM users WHERE id = user_id),
  '"}');  


select * from media_types where id = media_type_id limit 1;


create table user_statuses (
	id int(100) not null primary key auto_increment,
	name varchar(50) not null unique
); 