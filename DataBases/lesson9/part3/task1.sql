-- Part 3 Task 1

DELIMITER // 

DROP FUNCTION IF EXISTS hello//
CREATE FUNCTION hello()
RETURNS VARCHAR(100) NOT DETERMINISTIC
BEGIN
	DECLARE welcome VARCHAR(100);
	IF (TIME(now()) BETWEEN  '06:00:00' and '11:59:59') THEN
		SET welcome = "Доброе утро";
	ELSEIF (TIME(now()) BETWEEN  '12:00:00' and '17:59:59') THEN
		SET welcome = "Добрый день";
	ELSEIF (TIME(now()) BETWEEN  '18:00:00' and '23:59:59') THEN
		SET welcome = "Добрый вечер";
	ELSEIF (TIME(now()) BETWEEN  '00:00:00' and '5:59:59') THEN
		SET welcome = "Доброй ночи";
	END IF;
	RETURN welcome;
END//

DELIMITER ;

SELECT hello() as Welcome;
