-- ПРАВКИ БАЗЫДАННЫХ

UPDATE tags t SET created_at = 
	(SELECT created_at FROM users u WHERE u.id = t.user_id)
WHERE t.created_at < (SELECT created_at FROM users u WHERE u.id = t.user_id);

UPDATE lists t SET created_at =
	(SELECT created_at FROM users u WHERE u.id = t.user_id)
WHERE t.created_at < (SELECT created_at FROM users u WHERE u.id = t.user_id);

UPDATE tasks t SET created_at = 
	(SELECT created_at FROM users u WHERE u.id = t.user_id)
WHERE t.created_at < (SELECT created_at FROM users u WHERE u.id = t.user_id);

UPDATE users SET updated_at = NOW() WHERE created_at > updated_at;

UPDATE tasks SET updated_at = NOW() WHERE created_at > updated_at;

UPDATE tasks SET time_end = NOW() WHERE time_start > time_end;

UPDATE tags SET updated_at = NOW() WHERE created_at > updated_at;

UPDATE mediafiles SET updated_at = NOW() WHERE created_at > updated_at;

UPDATE lists SET updated_at = NOW() WHERE created_at > updated_at;

UPDATE media_types SET created_at = NOW();

UPDATE lists_subscribers ls SET created_at = 
	(SELECT created_at FROM users u WHERE u.id = ls.user_id) 
WHERE ls.created_at < (SELECT created_at FROM users u WHERE u.id = ls.user_id);

UPDATE tasks_tags tt SET created_at = 
	(SELECT created_at FROM tasks t WHERE t.id = tt.task_id) 
WHERE tt.created_at < (SELECT created_at FROM tasks t WHERE t.id = tt.task_id);

-- SELECT 
-- 	time_start, time_end, rem_time
-- FROM
-- 		tasks t
-- 	JOIN
-- 		reminders r2 
-- 		ON t.id = r2.task_id AND t.time_end IS NOT NULL
-- LIMIT 50;

UPDATE reminders r SET rem_time = 
	(SELECT time_end FROM tasks t WHERE t.id = r.task_id) 
WHERE r.rem_time < (SELECT time_start FROM tasks t WHERE t.id = r.task_id)
	AND (SELECT time_end FROM tasks t WHERE t.id = r.task_id) IS NOT NULL;

UPDATE reminders r SET rem_time = 
	(SELECT time_end FROM tasks t WHERE t.id = r.task_id)
WHERE r.rem_time > (SELECT time_end FROM tasks t WHERE t.id = r.task_id)
	AND (SELECT time_end FROM tasks t WHERE t.id = r.task_id) IS NOT NULL;

-- SELECT name, link, media_type_id FROM mediafiles m;

UPDATE mediafiles SET link = CONCAT(link, name, '.mp3') WHERE media_type_id = 1;

UPDATE mediafiles SET link = CONCAT(link, name, '.png') WHERE media_type_id = 2;

UPDATE mediafiles SET link = CONCAT(link, name, '.avi') WHERE media_type_id = 3;

-- ДОБАВИЛ СТОБЛБЕЦ РАЗМЕРА К МЕДИАФАЙЛАМ

-- ALTER TABLE mediafiles ADD COLUMN `size` INT UNSIGNED NOT NULL AFTER link;
-- 
-- UPDATE mediafiles SET `size` = FLOOR(1200 + RAND() * 1203042); 

