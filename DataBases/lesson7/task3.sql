-- task 3

DROP DATABASE IF EXISTS airport;
CREATE DATABASE airport;
USE airport;

CREATE TABLE flights (
	`id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	`from` VARCHAR(250) NOT NULL,
	`to` VARCHAR(250) NOT NULL
);

CREATE TABLE cities (
	`label` VARCHAR(250) NOT NULL,
	`name` VARCHAR(250) NOT NULL
);

INSERT INTO 
	flights (`from`,`to`)
VALUES
	('moscow', 'omsk'),
	('novgorod', 'kazan'),
	('irkutsk', 'kazan'),
	('omsk', 'irkutsk'),
	('moscow', 'kazan');

INSERT INTO 
	cities
VALUES
	('moscow', 'Москва'),
	('irkutsk', 'Иркутск'),
	('novgorod', 'Новгород'),
	('kazan', 'Казань'),
	('omsk', 'Омск');


SELECT
	(SELECT name FROM cities c2 WHERE label = f.`from`) as откуда,
	(SELECT name FROM cities c2 WHERE label = f.`to`) as куда
FROM
	flights f;
	

