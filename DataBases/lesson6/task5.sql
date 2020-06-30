-- активность выражается в количестве действий на одну неделю
-- у каждого действия есть свой вес:
-- 		лайки - 0.5
-- 		посты - 1
-- 		сообщения - 0.7

SELECT
	name,
	likes,
	posts,
	messages,
	likes*0.5 + posts + messages*0.7
FROM
	(select 
		(select concat(first_name, ' ', last_name)
			from users
			where id = u.id)
			as name, 
		(select count(*)
			from likes
			where user_id = u.id and created_at between date_sub(now(), interval 1 week) and now())
			as likes, 
		(select count(*)
			from posts
			where user_id = u.id 
			and (created_at between date_sub(now(), interval 1 week) and now()
				or updated_at between date_sub(now(), interval 1 week) and now())
-- 		    and is_public = 0 -- на усмотрение
			)as posts,
		(select count(*)
			from messages m2
			where from_user_id = u.id and created_at between date_sub(now(), interval 1 week) and now())
			as messages
	from
		users u) as activity
ORDER BY
	likes*0.5 + posts + messages*0.7
LIMIT 10;







