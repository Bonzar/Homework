-- CREATE TABLE logs (
-- 	table_name VARCHAR(50) NOT NULL,
-- 	row_primary_id INT NOT NULL,
-- 	row_name VARCHAR(255),
-- 	row_created_at DATETIME DEFAULT now()
-- ) ENGINE=ARCHIVE; 
-- 
-- DESC products;
DESC users;
DESC catalogs;
-- 
-- ALTER TABLE logs MODIFY COLUMN row_primary_id BIGINT UNSIGNED;
-- 
-- DESC logs;

DELIMITER $$

DROP TRIGGER IF EXISTS products_to_logs_ins $$
CREATE TRIGGER products_to_logs_ins BEFORE INSERT ON products
FOR EACH ROW BEGIN
	DECLARE row_id BIGINT UNSIGNED;
	SELECT id FROM products p ORDER BY created_at DESC LIMIT 1 INTO row_id;
	INSERT INTO logs VALUES ('products', row_id, NEW.name, NEW.created_at);
END $$

DROP TRIGGER IF EXISTS users_to_logs_ins $$
CREATE TRIGGER users_to_logs_ins BEFORE INSERT ON users
FOR EACH ROW BEGIN
	DECLARE row_id BIGINT UNSIGNED;
	SELECT id FROM users u ORDER BY created_at DESC LIMIT 1 INTO row_id;
	INSERT INTO logs VALUES ('users', row_id, NEW.name, NEW.created_at);
END $$

DROP TRIGGER IF EXISTS catalogs_to_logs_ins $$
CREATE TRIGGER catalogs_to_logs_ins BEFORE INSERT ON catalogs
FOR EACH ROW BEGIN
	DECLARE row_id BIGINT UNSIGNED;
	SELECT id FROM catalogs c ORDER BY id DESC LIMIT 1 INTO row_id;
	INSERT INTO logs VALUES ('catalogs', row_id, NEW.name, DEFAULT);
END $$

DELIMITER ;

-- DELETE FROM products WHERE name = 'name'; 

-- INSERT INTO products (name, description, price, catalog_id) VALUES ('1', 'DESC', 123, 2), ('2', 'DESC', 123, 2), ('3', 'DESC', 123, 2), ('4', 'DESC', 123, 2);
INSERT INTO users (name, birthday_at) VALUES ('vlad2', '11-11-11'), ('masha2', '11-11-11');
INSERT INTO catalogs (name) VALUES ('printer2'), ('scanner2');

-- SELECT * FROM products p ;
SELECT * FROM logs;
