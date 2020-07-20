-- DROP DATABASE IF EXISTS TickTick;
-- CREATE DATABASE TickTick;
-- USE TickTick;

DROP TABLE IF EXISTS users;
CREATE TABLE users (										-- ТАБЛИЦА ПОЛЬЗОВАТЕЛЕЙ
	`id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,	-- id пользователя
	`nickname` VARCHAR(100) NOT NULL UNIQUE,				-- nickname пользователя
	`email` VARCHAR(255) NOT NULL UNIQUE,					-- email пользователя
	`created_at` DATETIME DEFAULT NOW(),					-- время создание
	`updated_at` DATETIME DEFAULT NOW() ON UPDATE NOW()		-- время обновления
);

DROP TABLE IF EXISTS tasks;
CREATE TABLE tasks (										-- ТАБЛИЦА ЗАДАЧ
	`id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,	-- id задачи
	`title` VARCHAR(150) DEFAULT NULL,						-- заголовок задачи
	`body` TEXT DEFAULT NULL,								-- тело задачи (описание)
	`subtasks` BOOL NOT NULL DEFAULT 0,						-- режим обычного текста (0) или подзадач (1)
	`time_start` DATETIME DEFAULT NULL,						-- запланированное время задачи (если указан конец, то это начало)
	`time_end` DATETIME DEFAULT NULL,						-- запланированный конец задачи
	`completed` BOOL NOT NULL DEFAULT 0,					-- завершена ли задача 0/1
	`user_id` INT UNSIGNED NOT NULL,						-- id владельца задачи
	`created_at` DATETIME DEFAULT NOW(),					-- время создание
	`updated_at` DATETIME DEFAULT NOW() ON UPDATE NOW()		-- время обновления	
);

DROP TABLE IF EXISTS lists;
CREATE TABLE lists (										-- ТАБЛИЦА СПИСКОВ
	`id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,	-- id списка
	`name` VARCHAR(100) NOT NULL,							-- название списка
	`kanban` BOOL NOT NULL DEFAULT 0,						-- вид канбан (нет/да)
	`completed` BOOL NOT NULL DEFAULT 0,					-- закрыт ли список (нет/да)
	`user_id` INT UNSIGNED NOT NULL,						-- id владельца списка
	`created_at` DATETIME DEFAULT NOW(),					-- время создание
	`updated_at` DATETIME DEFAULT NOW() ON UPDATE NOW()		-- время обновления
);

DROP TABLE IF EXISTS tags;
CREATE TABLE tags (											-- ТАБЛИЦА ТЕГОВ
	`id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,	-- id тега
	`name` VARCHAR(100) NOT NULL,							-- название тега
	`user_id` INT UNSIGNED NOT NULL,						-- id владельца тега
	`created_at` DATETIME DEFAULT NOW(),					-- время создание
	`updated_at` DATETIME DEFAULT NOW() ON UPDATE NOW()		-- время обновления
);

DROP TABLE IF EXISTS mediafiles;
CREATE TABLE mediafiles (									-- ТАБЛИЦА МЕДИАФАЙЛОВ
	`id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,	-- id медиафайла
	`name` VARCHAR(100) NOT NULL,							-- название медиафайла
	`media_type_id` INT UNSIGNED NOT NULL,					-- id типа медиафайла 
	`link` VARCHAR(500) NOT NULL,							-- ссылка на медиафайл
	`size` INT UNSIGNED NOT NULL,							-- размер медиафайла
	`task_id` INT UNSIGNED NOT NULL,						-- id задачи для медиафайла
	`created_at` DATETIME DEFAULT NOW(),					-- время создание
	`updated_at` DATETIME DEFAULT NOW() ON UPDATE NOW()		-- время обновления
);

DROP TABLE IF EXISTS media_types;
CREATE TABLE media_types (
	`id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,	-- id типа медиафайла 
	`name` VARCHAR(150) NOT NULL,							-- название типа медиафайла
	`created_at` DATETIME DEFAULT NOW()						-- время создание
);

DROP TABLE IF EXISTS reminders;
CREATE TABLE reminders (									-- ТАБЛИЦА НАПОМИНАНИЙ
	`id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,	-- id напоминания
	`task_id` INT UNSIGNED NOT NULL,						-- id задачи для напоминания
	`reminder_at` DATETIME NOT NULL 						-- время напоминания
);

-- эта таблица будет удалена далее (в связи с ненадобностью)

DROP TABLE IF EXISTS tasks_lists;
CREATE TABLE tasks_lists (									-- ТАБЛИЦА СВЯЗИ ЗАДАЧ И СПИСКОВ КОТОРЫМ ОНИ ПРИНАДЛЕЖАТ
	`id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,	-- id связи
	`task_id` INT UNSIGNED NOT NULL,						-- id задачи 
	`list_id` INT UNSIGNED NOT NULL,						-- id листа, которому принадлежит задача
	`created_at` DATETIME DEFAULT NOW(),					-- время создания связи
);

DROP TABLE IF EXISTS tasks_tags;
CREATE TABLE tasks_tags (									-- ТАБЛИЦА СВЯЗИ ЗАДАЧ И ТЕГОВ КОТОРЫМ ОНИ ПРИНАДЛЕЖАТ
	`id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,	-- id связи 
	`task_id` INT UNSIGNED NOT NULL,						-- id задачи
	`tag_id` INT UNSIGNED NOT NULL,							-- id тега, которому принадлежит задача
	`created_at` DATETIME DEFAULT NOW(),					-- время создания связи
);	

DROP TABLE IF EXISTS lists_subscribers; 
CREATE TABLE lists_subscribers (							-- ТАБЛИЦА СВЯЗИ ПОДПИСАВШЕГОСЯ НА СПИСОК ПОЛЬЗОВАТЕЛЯ И ЛИСТА НА КОТОРЫЙ ПОДПИСАЛИСЬ
	`id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,	-- id связи
	`list_id` INT UNSIGNED NOT NULL,						-- id листа на который подписываются
	`user_id` INT UNSIGNED NOT NULL,						-- id пользователя который подписался
	`created_at` DATETIME DEFAULT NOW(),					-- время создания связи
);

DROP TABLE IF EXISTS log_activity;
CREATE TABLE log_activity (									-- ТАБЛЦА ЛОГОВ ВСЕХ ДЕЙСТВИЙ ПО БАЗАМ ДАННЫХ						
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,	-- id действия
	table_name VARCHAR(150) NOT NULL,						-- название таблицы над которой производят действие
	row_id INT UNSIGNED NOT NULL,							-- id строки над которой проводят действие
	type_activity VARCHAR(50) NOT NULL,						-- id типа действия
	created_at DATETIME NOT NULL
) ENGINE = 'archive';
