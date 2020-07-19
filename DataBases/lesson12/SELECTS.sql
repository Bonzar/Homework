-- ВЫБОРКИ

-- ВЫБОРКА КОЛЧЕСТВА ЗАДАЧ НА ОДНОГО ПОЛЬЗОВАТЕЛЯ

SELECT
	u2.id AS `USER`,
	COUNT(t2.id) AS `Count tasks`
FROM
		users u2
	LEFT JOIN
		lists l2
		ON u2.id = l2.user_id
	LEFT JOIN 
		tasks t2
		ON t2.list_id = l2.id
GROUP BY u2.id
ORDER BY u2.id;

-- СТАТИСТИКА ПО ПОЛЬЗОВАТЕЛЯМ

SELECT DISTINCT u.id AS `user_id`,
	u.nickname AS `nickname`,
	COUNT(t2.id) OVER userr AS `total_tasks`,
	SUM(t2.completed) OVER userr as `complited`,
	COUNT(t2.id) OVER userr - SUM(t2.completed) OVER userr AS `uncomplited`,
	(SELECT COUNT(1) FROM lists l3 WHERE user_id = u.id) AS `total_lists`,
	(SELECT COUNT(1) FROM tags t3 WHERE user_id = u.id) AS `total_tags`,
	u.created_at AS `user_created_at`,
	FIRST_VALUE (t2.created_at) OVER (PARTITION BY u.id ORDER BY t2.created_at) AS `first_task_at`,
	FIRST_VALUE (t2.created_at) OVER (PARTITION BY u.id ORDER BY t2.created_at DESC) AS `last_task_at`
FROM 	
		users u
	LEFT JOIN
		lists l2
		ON l2.user_id = u.id
	LEFT JOIN 
		tasks t2 
		ON t2.list_id = l2.id
WINDOW userr AS (PARTITION BY u.id)
ORDER BY `total_tasks` DESC;

-- ВЫБОРКА СЧЁТА И УРОВНЕЙ ПОЛЬЗОВАТЕЛЕЙ (50 ОЧКОВ ЗА НЕЗАВЕРШЕННУЮ ЗАДАЧУ И 100 ОЧКОВ ЗА ЗАВЕРШЕННУЮ (МАКСИМУМ 100 ОЧКОВ ЗА ОДНУ ЗАДАЧУ))

SELECT DISTINCT 
		u.id AS 'user_id',
		COUNT(t.id) OVER `user` AS 'total_tasks',
		SUM(t.completed) OVER `user` as 'complited',
		COUNT(t.id) OVER `user` - SUM(t.completed) OVER `user` AS 'uncomplited',
		(SUM(t.completed) OVER `user` * 100) + (COUNT(t.id) OVER `user` - SUM(t.completed) OVER `user`) * 50 AS `score`,
		get_level((SUM(t.completed) OVER `user` * 100) + (COUNT(t.id) OVER `user` - SUM(t.completed) OVER `user`) * 50) AS `level`
FROM
		users u
	LEFT JOIN
		lists l
		ON u.id = l.user_id
	LEFT JOIN
		tasks t
		ON l.id = t.list_id
-- 			AND t.created_at BETWEEN date_sub(NOW(), INTERVAL 1 YEAR) AND NOW()		-- НАДСТРОКА НА ПРИОД ВЗЯТИЯ ВЫБОРКИ
WINDOW `user` AS (PARTITION BY u.id)
ORDER BY `SCORE` DESC
