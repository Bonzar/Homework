
DELIMITER $$

-- ТРИГЕР НА ПРОВЕРКУ id ПОЛЬЗОВАТЕЛЯ ПРИ ПОПЫТКЕ ВСТАВКИ ИЛИ ОБНОВЛЕНИЯ ЗАПИСЕЙ В ТАБЛИЦЕ tasks_tags

DROP TRIGGER IF EXISTS tasks_tags_check_user_id_BEF_INS $$
CREATE TRIGGER tasks_tags_check_user_id_BEF_INS BEFORE INSERT ON tasks_tags
FOR EACH ROW BEGIN 
	DECLARE list_user_id INT UNSIGNED;
	DECLARE tag_user_id INT UNSIGNED;
	SELECT 
		user_id
	FROM 
			lists l
		JOIN
			tasks t2
			ON t2.list_id = l.id
	WHERE t2.id = NEW.task_id 
	INTO list_user_id;
	SELECT user_id FROM tags t2 WHERE id = NEW.tag_id INTO tag_user_id;
	IF list_user_id != tag_user_id THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "The tag's user id does not match the list's user id!";
	END IF;
END $$

DROP TRIGGER IF EXISTS tasks_tags_check_user_id_BEF_UPD $$
CREATE TRIGGER tasks_tags_check_user_id_BEF_UPD BEFORE UPDATE ON tasks_tags
FOR EACH ROW BEGIN 
	DECLARE list_user_id INT UNSIGNED;
	DECLARE tag_user_id INT UNSIGNED;
	SELECT 
		user_id
	FROM 
			lists l
		JOIN
			tasks t2
			ON t2.list_id = l.id
	WHERE t2.id = NEW.task_id 
	INTO list_user_id;
	SELECT user_id FROM tags t2 WHERE id = NEW.tag_id INTO tag_user_id;
	IF list_user_id != tag_user_id THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "The tag's user id does not match the list's user id!";
	END IF;
END $$

-- ТРИГЕРЫ ВЕДЕНИЯ ЛОГА ДЕЙСТВИЙ

-- lists

DROP TRIGGER IF EXISTS lists_log_activity_AFT_INS $$
CREATE TRIGGER lists_log_activity_AFT_INS AFTER INSERT ON lists
FOR EACH ROW BEGIN 
	INSERT INTO log_activity VALUES (NULL, 'lists', NEW.id, 'INSERT', NOW());
END $$

DROP TRIGGER IF EXISTS lists_log_activity_AFT_UPD $$
CREATE TRIGGER lists_log_activity_AFT_UPD AFTER UPDATE ON lists
FOR EACH ROW BEGIN 
	INSERT INTO log_activity VALUES (NULL, 'lists', NEW.id, 'UPDATE', NOW());
END $$

DROP TRIGGER IF EXISTS lists_log_activity_AFT_DEL $$
CREATE TRIGGER lists_log_activity_AFT_DEL AFTER DELETE ON lists
FOR EACH ROW BEGIN 
	INSERT INTO log_activity VALUES (NULL, 'lists', OLD.id, 'DELETE', NOW());
END $$

-- lists_subscibers

DROP TRIGGER IF EXISTS lists_subscribers_log_activity_AFT_INS $$
CREATE TRIGGER lists_subscribers_log_activity_AFT_INS AFTER INSERT ON lists_subscribers
FOR EACH ROW BEGIN 
	INSERT INTO log_activity VALUES (NULL, 'lists_subscribers', NEW.id, 'INSERT', NOW());
END $$

DROP TRIGGER IF EXISTS lists_subscribers_log_activity_AFT_UPD $$
CREATE TRIGGER lists_subscribers_log_activity_AFT_UPD AFTER UPDATE ON lists_subscribers
FOR EACH ROW BEGIN 
	INSERT INTO log_activity VALUES (NULL, 'lists_subscribers', NEW.id, 'UPDATE', NOW());
END $$

DROP TRIGGER IF EXISTS lists_subscribers_log_activity_AFT_DEL $$
CREATE TRIGGER lists_subscribers_log_activity_AFT_DEL AFTER DELETE ON lists_subscribers
FOR EACH ROW BEGIN 
	INSERT INTO log_activity VALUES (NULL, 'lists_subscribers', id, 'DELETE', NOW());
END $$

-- media_types

DROP TRIGGER IF EXISTS media_types_log_activity_AFT_INS $$
CREATE TRIGGER media_types_log_activity_AFT_INS AFTER INSERT ON media_types
FOR EACH ROW BEGIN 
	INSERT INTO log_activity VALUES (NULL, 'media_types', NEW.id, 'INSERT', NOW());
END $$

DROP TRIGGER IF EXISTS media_types_log_activity_AFT_UPD $$
CREATE TRIGGER media_types_log_activity_AFT_UPD AFTER UPDATE ON media_types
FOR EACH ROW BEGIN 
	INSERT INTO log_activity VALUES (NULL, 'media_types', NEW.id, 'UPDATE', NOW());
END $$

DROP TRIGGER IF EXISTS media_types_log_activity_AFT_DEL $$
CREATE TRIGGER media_types_log_activity_AFT_DEL AFTER DELETE ON media_types
FOR EACH ROW BEGIN 
	INSERT INTO log_activity VALUES (NULL, 'media_types', id, 'DELETE', NOW());
END $$

-- mediafiles

DROP TRIGGER IF EXISTS mediafiles_log_activity_AFT_INS $$
CREATE TRIGGER mediafiles_log_activity_AFT_INS AFTER INSERT ON mediafiles
FOR EACH ROW BEGIN 
	INSERT INTO log_activity VALUES (NULL, 'mediafiles', NEW.id, 'INSERT', NOW());
END $$

DROP TRIGGER IF EXISTS mediafiles_log_activity_AFT_UPD $$
CREATE TRIGGER mediafiles_log_activity_AFT_UPD AFTER UPDATE ON mediafiles
FOR EACH ROW BEGIN 
	INSERT INTO log_activity VALUES (NULL, 'mediafiles', NEW.id, 'UPDATE', NOW());
END $$

DROP TRIGGER IF EXISTS mediafiles_log_activity_AFT_DEL $$
CREATE TRIGGER mediafiles_log_activity_AFT_DEL AFTER DELETE ON mediafiles
FOR EACH ROW BEGIN 
	INSERT INTO log_activity VALUES (NULL, 'mediafiles', id, 'DELETE', NOW());
END $$

-- reminders

DROP TRIGGER IF EXISTS reminders_log_activity_AFT_INS $$
CREATE TRIGGER reminders_log_activity_AFT_INS AFTER INSERT ON reminders
FOR EACH ROW BEGIN 
	INSERT INTO log_activity VALUES (NULL, 'reminders', NEW.id, 'INSERT', NOW());
END $$

DROP TRIGGER IF EXISTS reminders_log_activity_AFT_UPD $$
CREATE TRIGGER reminders_log_activity_AFT_UPD AFTER UPDATE ON reminders
FOR EACH ROW BEGIN 
	INSERT INTO log_activity VALUES (NULL, 'reminders', NEW.id, 'UPDATE', NOW());
END $$

DROP TRIGGER IF EXISTS reminders_log_activity_AFT_DEL $$
CREATE TRIGGER reminders_log_activity_AFT_DEL AFTER DELETE ON reminders
FOR EACH ROW BEGIN 
	INSERT INTO log_activity VALUES (NULL, 'reminders', id, 'DELETE', NOW());
END $$

-- tags

DROP TRIGGER IF EXISTS tags_log_activity_AFT_INS $$
CREATE TRIGGER tags_log_activity_AFT_INS AFTER INSERT ON tags
FOR EACH ROW BEGIN 
	INSERT INTO log_activity VALUES (NULL, 'tags', NEW.id, 'INSERT', NOW());
END $$

DROP TRIGGER IF EXISTS tags_log_activity_AFT_UPD $$
CREATE TRIGGER tags_log_activity_AFT_UPD AFTER UPDATE ON tags
FOR EACH ROW BEGIN 
	INSERT INTO log_activity VALUES (NULL, 'tags', NEW.id, 'UPDATE', NOW());
END $$

DROP TRIGGER IF EXISTS tags_log_activity_AFT_DEL $$
CREATE TRIGGER tags_log_activity_AFT_DEL AFTER DELETE ON tags
FOR EACH ROW BEGIN 
	INSERT INTO log_activity VALUES (NULL, 'tags', id, 'DELETE', NOW());
END $$

-- tasks

DROP TRIGGER IF EXISTS tasks_log_activity_AFT_INS $$
CREATE TRIGGER tasks_log_activity_AFT_INS AFTER INSERT ON tasks
FOR EACH ROW BEGIN 
	INSERT INTO log_activity VALUES (NULL, 'tasks', NEW.id, 'INSERT', NOW());
END $$

DROP TRIGGER IF EXISTS tasks_log_activity_AFT_UPD $$
CREATE TRIGGER tasks_log_activity_AFT_UPD AFTER UPDATE ON tasks
FOR EACH ROW BEGIN 
	INSERT INTO log_activity VALUES (NULL, 'tasks', NEW.id, 'UPDATE', NOW());
END $$

DROP TRIGGER IF EXISTS tasks_log_activity_AFT_DEL $$
CREATE TRIGGER tasks_log_activity_AFT_DEL AFTER DELETE ON tasks
FOR EACH ROW BEGIN 
	INSERT INTO log_activity VALUES (NULL, 'tasks', id, 'DELETE', NOW());
END $$

-- tasks_tags

DROP TRIGGER IF EXISTS tasks_tags_log_activity_AFT_INS $$
CREATE TRIGGER tasks_tags_log_activity_AFT_INS AFTER INSERT ON tasks_tags
FOR EACH ROW BEGIN 
	INSERT INTO log_activity VALUES (NULL, 'tasks_tags', NEW.id, 'INSERT', NOW());
END $$

DROP TRIGGER IF EXISTS tasks_tags_log_activity_AFT_UPD $$
CREATE TRIGGER tasks_tags_log_activity_AFT_UPD AFTER UPDATE ON tasks_tags
FOR EACH ROW BEGIN 
	INSERT INTO log_activity VALUES (NULL, 'tasks_tags', NEW.id, 'UPDATE', NOW());
END $$

DROP TRIGGER IF EXISTS tasks_tags_log_activity_AFT_DEL $$
CREATE TRIGGER tasks_tags_log_activity_AFT_DEL AFTER DELETE ON tasks_tags
FOR EACH ROW BEGIN 
	INSERT INTO log_activity VALUES (NULL, 'tasks_tags', id, 'DELETE', NOW());
END $$

-- users

DROP TRIGGER IF EXISTS users_log_activity_AFT_INS $$
CREATE TRIGGER users_log_activity_AFT_INS AFTER INSERT ON users
FOR EACH ROW BEGIN 
	INSERT INTO log_activity VALUES (NULL, 'users', NEW.id, 'INSERT', NOW());
END $$

DROP TRIGGER IF EXISTS users_log_activity_AFT_UPD $$
CREATE TRIGGER users_log_activity_AFT_UPD AFTER UPDATE ON users
FOR EACH ROW BEGIN
	INSERT INTO log_activity VALUES (NULL, 'users', NEW.id, 'UPDATE', NOW());
END $$

DROP TRIGGER IF EXISTS users_log_activity_AFT_DEL $$
CREATE TRIGGER users_log_activity_AFT_DEL AFTER DELETE ON users
FOR EACH ROW BEGIN 
	INSERT INTO log_activity VALUES (NULL, 'users', id, 'DELETE', NOW());
END $$


DELIMITER ;
