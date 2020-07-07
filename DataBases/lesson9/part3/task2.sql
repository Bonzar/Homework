-- Part 1 Task 2

-- DESC products;
-- DROP TABLE products2;
-- CREATE TABLE products2 (
-- 	name VARCHAR(255),
-- 	description TEXT
-- );

-- INSERT INTO products2
-- 	SELECT name, description FROM products;

-- DELETE FROM products2 WHERE name IS NULL OR description IS NULL;

-- DESC products2;

SELECT * FROM products2;

ALTER TABLE products2
	MODIFY name TEXT;

DELIMITER //

DROP TRIGGER IF EXISTS products_ins //
CREATE TRIGGER products_ins BEFORE INSERT ON products2
FOR EACH ROW
BEGIN
	IF (NEW.name IS NULL AND NEW.description IS NULL) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'INSERT canceled (both of name and description is NULL)';
	END IF;
END//

DELIMITER ;

-- SHOW TABLES;
-- SHOW TRIGGERS;

INSERT INTO products2 VALUES 
	(NULL, NULL);
-- 
-- INSERT INTO products2 VALUES 
-- 	('Printer', NULL);
-- 
-- INSERT INTO products2 VALUES 
-- 	(NULL, 'For scanning documents');
