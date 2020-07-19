
-- ПРЕДСТВАЛЕНИЕ ВСЕХ ЗАДАЧ ПОЛЬЗОВАТЕЛЯ С ТЕМИ НА КОТОРЫЕ ОН ПОДПИСАЛСЯ

CREATE VIEW user_5 AS SELECT DISTINCT
	u.nickname AS `user_nickname`,
	t.title AS `task_title`,
	t.body AS `task_body`,
	t.time_start AS `task_time_start`,
	t.time_end AS `task_time_end`,
	MIN(r.rem_time) OVER w_task AS `nearest_reminder`,
	t.subtasks AS `task_subtasks`,
	t.completed AS `task_complited`,
	l.name AS `list_name`,
	l.kanban AS `kanban_view`,
	l.colmpleted AS `list_complited`, 
	COUNT(tt.id) OVER w_task AS `tags_count`,
	COUNT(m.id) OVER w_task AS `mediafiles_count`
FROM
		tasks t
	JOIN
		lists l
		ON l.id = t.list_id AND l.user_id = 5
	JOIN
		users u
		ON u.id = l.user_id
	LEFT JOIN
		reminders r
		ON r.task_id = t.id
	LEFT JOIN
		tasks_tags tt
		ON tt.task_id = t.id
	LEFT JOIN
		mediafiles m 
		ON m.task_id = t.id
WINDOW w_task AS (PARTITION BY t.id)
UNION
SELECT DISTINCT
	u.nickname AS `user_nickname`,
	t.title AS `task_title`,
	t.body AS `task_body`,
	t.time_start AS `task_time_start`,
	t.time_end AS `task_time_end`,
	MIN(r.rem_time) OVER w_task AS `nearest_reminder`,
	t.subtasks AS `task_subtasks`,
	t.completed AS `task_complited`,
	l.name AS `list_name`,
	l.kanban AS `kanban_view`,
	l.colmpleted AS `list_complited`, 
	COUNT(tt.id) OVER w_task AS `tags_count`,
	COUNT(m.id) OVER w_task AS `mediafiles_count`
FROM
		tasks t
	JOIN
		lists l
		ON l.id = t.list_id AND l.id = 222
	JOIN
		users u
		ON u.id = l.user_id
	LEFT JOIN
		reminders r
		ON r.task_id = t.id
	LEFT JOIN
		tasks_tags tt
		ON tt.task_id = t.id
	LEFT JOIN
		mediafiles m 
		ON m.task_id = t.id
WINDOW w_task AS (PARTITION BY t.id);

SELECT * FROM user_5;
	
-- ПРЕДСТАВЛЕНИЕ ВЫБОРКИ ВРЕМЕНИ СОЗДАНИЯ ВСЕХ ПЕРВЫХ ОБЪЕКТОВ ДЛЯ ПОЛЬЗОВАТЕЛЯ

DROP VIEW IF EXISTS view_created_at; 
CREATE VIEW view_created_at AS SELECT DISTINCT
	u.created_at AS `user_created_at`,
	MIN(l.created_at) OVER w_user AS `first_list_at`,
	MIN(t.created_at) OVER w_user AS `first_task_at`,
	MIN(t2.created_at) OVER w_user AS `first_tag_at`,
	MIN(tt.created_at) OVER w_user AS `first_task_tag_connect_at`,
	MIN(r.rem_time) OVER w_user AS `first_reminder_at`,
	MIN(m.created_at) OVER w_user AS `first_mediafile_at`,
	MIN(ls.created_at) OVER w_user AS `first_list_subscriber_connect_at`
FROM
		users u
	LEFT JOIN
		lists l
		ON l.user_id = u.id
	LEFT JOIN
		tasks t
		ON t.list_id = l.id
	LEFT JOIN
		tags t2 
		ON t2.user_id = u.id
	LEFT JOIN
		tasks_tags tt
		ON tt.task_id = t.id
	LEFT JOIN
		reminders r
		ON r.task_id = t.id
	LEFT JOIN
		mediafiles m 
		ON m.task_id = t.id
	LEFT JOIN 
		lists_subscribers ls
		ON ls.user_id = u.id
WINDOW w_user AS (PARTITION BY u.id);
	
	
SELECT * FROM view_created_at;