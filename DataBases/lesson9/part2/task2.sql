-- Part 2 Task 2

CREATE DATABASE P2T2;

CREATE TABLE accounts (
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(255) NOT NULL,
	`password` VARCHAR(255) DEFAULT NULL
)

INSERT INTO accounts (name, `password`) VALUES
	('Vova', '12345'),
	('vLaDiMiR', '13579'),
	('ANONIMUS', DEFAULT);
	
SELECT * FROM accounts a;

CREATE VIEW username AS 
	SELECT
		id, name
	FROM
		accounts a;
		
SELECT * FROM username;

CREATE USER user_read;
GRANT SELECT ON P2T2.username TO user_read;

SHOW GRANTS FOR user_read;

