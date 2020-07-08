-- Task 2 

-- SELECT DISTINCT media_types.name, 
--   SUM(media.size) OVER(PARTITION BY media.media_type_id) AS total_by_type,
--   SUM(media.size) OVER() AS total,
--   SUM(media.size) OVER(PARTITION BY media.media_type_id) / SUM(media.size) OVER() * 100 AS "%%"
--     FROM media
--       JOIN media_types
--         ON media.media_type_id = media_types.id;
        
SELECT DISTINCT 
	c.name,
	cu.user_id,
	p.birthday
FROM 
		communities c
	LEFT JOIN
		communities_users cu
		ON c.id = cu.community_id
	JOIN profiles p
		ON p.user_id = cu.user_id;
	
SELECT COUNT(cu.user_id) FROM communities_users cu; 
		
SELECT first_name FROM users JOIN profiles p WHERE p.birthday = MIN(p.birthday)

SELECT DISTINCT c.name as `group`,
	COUNT(cu.user_id) OVER () / (SELECT COUNT(c2.id) FROM communities c2) AS `avg_subscribbers`,
	MIN(p.birthday) OVER community AS `Younger_user`,
	MAX(p.birthday) OVER community AS `Older_user`,
	COUNT(cu.user_id) OVER community AS `Subscribbers`,
	COUNT(p.user_id) OVER() AS `ALL_Users`,
	COUNT(cu.user_id) OVER community / COUNT(p.user_id) OVER() * 100 AS `%%%` 
FROM 
		communities c
	LEFT JOIN
		communities_users cu
		ON c.id = cu.community_id
	JOIN profiles p
		ON p.user_id = cu.user_id
WINDOW community AS (PARTITION BY c.name);	


-- Надеюсь я правильно понял все необходимые столбцы. Потому что вначале, для столбцов `Younger_user` и `Older_user`, мне захотелось вывести
-- не саму дату, а id пользователя с этой датой рождения.
-- Мне очень интересно, возможно ли выводить соответствующее значение другого столбца, как например имя или id, после нахождения значения 
-- агрегирующей или оконной функции, как если бы мы сделали запрос с условием  where.
-- К примеру, я хочу вывести имя самого молодого пользователя из каждой группы.
