-- Внешние ключи:
			
ALTER TABLE tasks 
	ADD CONSTRAINT tasks_user_id_fk
		FOREIGN KEY (user_id) REFERENCES users(id)
			ON UPDATE CASCADE
			ON DELETE CASCADE;

ALTER TABLE lists
	ADD CONSTRAINT lists_user_id_fk
		FOREIGN KEY (user_id) REFERENCES users(id)
			ON UPDATE CASCADE
			ON DELETE CASCADE;
			
ALTER TABLE tags
	ADD CONSTRAINT tags_user_id_fk
		FOREIGN KEY (user_id) REFERENCES users(id)
			ON UPDATE CASCADE
			ON DELETE CASCADE;
			
ALTER TABLE mediafiles
	ADD CONSTRAINT mediafiles_media_type_id_fk
		FOREIGN KEY (media_type_id) REFERENCES media_types(id)
			ON UPDATE CASCADE,
	ADD CONSTRAINT mediafiles_task_id_fk
		FOREIGN KEY (task_id) REFERENCES tasks(id)
			ON UPDATE CASCADE
			ON DELETE CASCADE;
		
ALTER TABLE reminders
	ADD CONSTRAINT reminders_task_id_fk
		FOREIGN KEY (task_id) REFERENCES tasks(id)
			ON DELETE CASCADE
			ON UPDATE CASCADE;
	
ALTER TABLE tasks_tags 
	ADD CONSTRAINT tasks_tags_task_id_fk
		FOREIGN KEY (task_id) REFERENCES tasks(id)
			ON DELETE CASCADE
			ON UPDATE CASCADE,
	ADD CONSTRAINT tasks_tags_tag_id_fk
		FOREIGN KEY (tag_id) REFERENCES tags(id)
			ON DELETE CASCADE
			ON UPDATE CASCADE;
	
ALTER TABLE lists_subscribers
	ADD CONSTRAINT lists_subscribers_list_id_fk
		FOREIGN KEY (list_id) REFERENCES lists(id)
			ON DELETE CASCADE
			ON UPDATE CASCADE,
	ADD CONSTRAINT lists_subscribers_user_id_fk
		FOREIGN KEY (user_id) REFERENCES users(id)
			ON DELETE CASCADE
			ON UPDATE CASCADE;
		
-- Удаление таблицы связи лист-задача и изменение внешнего ключа на задачи(пользователь) на задачи(листы)

UPDATE tasks SET user_id = 1 + FLOOR(user_id / 2.074688799); -- подмена значений id на id листов

DESC tasks

ALTER TABLE tasks DROP FOREIGN KEY tasks_user_id_fk;

ALTER TABLE tasks CHANGE COLUMN `user_id` `list_id` INT UNSIGNED NOT NULL;

ALTER TABLE tasks
	ADD CONSTRAINT tasks_list_id_fk
		FOREIGN KEY (list_id) REFERENCES lists(id);
	
DROP TABLE tasks_lists;

