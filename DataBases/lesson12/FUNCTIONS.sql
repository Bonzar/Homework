-- ФУНКЦИИ и ПРОЦЕДУРЫ

-- ФУНКЦИЯ ПОЛУЧЕНИЯ УРОВНЯ

DELIMITER $$

DROP FUNCTION IF EXISTS get_level $$
CREATE FUNCTION get_level(score INT UNSIGNED)
RETURNS INT UNSIGNED NO SQL
BEGIN
	IF score BETWEEN 1 AND 1000 THEN
		RETURN 1;
	ELSEIF score BETWEEN 1001 AND 2000 THEN 
		RETURN 2;
	ELSEIF score BETWEEN 2001 AND 3500 THEN
		RETURN 3;
	ELSEIF score BETWEEN 3501 AND 5500 THEN 
		RETURN 4;
	ELSEIF score BETWEEN 5501 AND 8000 THEN 
		RETURN 5;
	ELSEIF score BETWEEN 8001 AND 11000 THEN 
		RETURN 6;
	ELSEIF score BETWEEN 11001 AND 14500 THEN 
		RETURN 7;
	ELSEIF score >= 14501 THEN
		RETURN 8;
	ELSE
		RETURN 0;
	END IF;
END

DELIMITER ;

-- SELECT get_level(0)

-- ПРОЦЕДУРА ПЕРЕНОСА ЗАДАЧИ ИЗ ОДНОГО ЛИСТА В ДРУГОЙ (С ПРОВЕРКОЙ НА ПРИНАДЛЕЖНОСТЬ НОВОГО СПИСКА ТОМУ ЖЕ ПОЛЬЗОВАТЕЛЮ ЧТО И ЗАДАЧА)

DELIMITER $$

DROP PROCEDURE IF EXISTS task_list_change $$
CREATE PROCEDURE task_list_change (task_id INT UNSIGNED, new_list_id INT UNSIGNED)
BEGIN
	DECLARE task_user_id INT UNSIGNED;
	DECLARE new_list_user_id INT UNSIGNED;
	SELECT l2.user_id FROM tasks t JOIN lists l2 ON t.list_id = l2.id WHERE t.id = task_id INTO task_user_id;
	SELECT user_id FROM lists l2 WHERE l2.id = new_list_id INTO new_list_user_id;
	IF task_user_id != new_list_user_id THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Task's user id does not match the new list's user id!";
	ELSE
		UPDATE tasks SET list_id = new_list_id WHERE id = task_id;
	END IF;
END $$

DELIMITER ;

-- CALL task_list_change(1,39);
