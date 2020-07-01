-- task 3
-- активность выражается в количестве действий на одну неделю
-- у каждого действия есть свой вес:
-- 		лайки - 0.5
-- 		посты - 1
-- 		сообщения - 0.7


-- решение из 6 урока с помощью подзапросов
SELECT
	name,
	likes,
	posts,
	messages,
	likes*0.5 + posts + messages*0.7 AS activity
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
	activity;


-- решение с помощью JOIN 


SELECT 
	CONCAT(u.first_name, '', u.last_name) AS name,
	u.id AS user_ID,
	COUNT(DISTINCT m.id) AS messages,
	COUNT(DISTINCT p.id) AS posts,
	COUNT(DISTINCT l.id) AS likes,
	COUNT(DISTINCT m.id)*0.7 + COUNT(DISTINCT p.id) + COUNT(DISTINCT l.id)*0.5 AS activity
	-- здесь возникло жедание использовать псевдонимы уже посчитанные сообщения, посты и лайки, но так сделать не получилось
	-- как пробовал:
-- 	messages*0.7 + posts + likes*0.5 AS activity
	-- есть ли какой либо сокращенный вариант такой записи, чтобы код не дублировался?
FROM 
		users u
	LEFT JOIN
		messages m
		ON m.from_user_id = u.id
			AND m.created_at BETWEEN date_sub(NOW(), INTERVAL 1 WEEK) AND NOW()
	LEFT JOIN
		posts p
		ON p.user_id = u.id 
			AND (p.created_at BETWEEN date_sub(NOW(), INTERVAL 1 WEEK) AND NOW()
				OR p.updated_at BETWEEN date_sub(NOW(), INTERVAL 1 WEEK) AND NOW())
-- 			AND p.is_public = 0 -- на усмотрение 
	LEFT JOIN
		likes l
		ON l.user_id = u.id
			AND l.created_at BETWEEN date_sub(NOW(), INTERVAL 1 WEEK) AND NOW()
GROUP BY
	u.id
ORDER BY
	activity, MIN(p.created_at), MIN(m.created_at), MIN(l.created_at)
LIMIT 100;







