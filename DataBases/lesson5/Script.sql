
-- LESSON 5 --

CREATE database task5;

use task5;

SELECT * FROM users3 limit 10;

describe users2;

-- task 1

UPDATE users set created_at = NOW(); #if have update on updeted_at

UPDATE users set created_at = NOW(), updated_at = NOW(); -- without update on updeted_at

-- task 2

SELECT STR_TO_DATE('20.10.2017','%d.%m.%Y');

SELECT STR_TO_DATE("06.01.2020 8:10",'%d.%m.%Y %H:%i');

SELECT STR_TO_DATE(created_at,'%d.%m.%Y %H:%i') FROM users2;

CREATE TABLE users2
    (`created_at` varchar(20), `updated_at` varchar(20));

INSERT INTO users2 (created_at, updated_at) VALUES
    ("06.01.2020 8:10", "06.01.2020 8:10"),
    ("07.01.2020 8:10", "07.01.2020 8:10"),
    ("08.01.2020 8:10", "08.01.2020 8:10"),
    ("09.01.2020 8:10", "09.01.2020 8:10");

ALTER TABLE users2 ADD COLUMN created_at2 DATETIME, ADD COLUMN updated_at2 DATETIME;

UPDATE users2 set created_at2 = STR_TO_DATE(created_at,'%d.%m.%Y %H:%i'), updated_at2 = STR_TO_DATE(updated_at,'%d.%m.%Y %H:%i');

ALTER TABLE users2 DROP created_at, DROP updated_at;

ALTER TABLE users2 CHANGE created_at2 created_at DATETIME, CHANGE updated_at2 updated_at DATETIME;

-- task 3

CREATE TABLE warehouse (
	value int(50)
);

INSERT INTO warehouse (value) VALUES 
	(0), (2500), (0), (30), (500), (1);

SELECT value FROM warehouse ORDER BY value = 0, value;

SELECT value FROM warehouse ORDER BY IF(value  0, 0, 1), value;

-- task 4

CREATE TABLE users3
    (`birthday` varchar(20));

INSERT INTO users3 (birthday) VALUES
    ("2020-06-21"),
    ("2020-06-21"),
    ("2020-06-21"),
    ("1997-05-12"),
    ("1997-05-12"),
    ("1997-05-12"),
    ("1987-08-27"),
    ("1954-08-11"),
    ("1984-08-10"),
    ("1963-07-14"),
    ("1963-07-14"),
    ("1963-07-14");
   
SELECT * FROM users3 where DATE_FORMAT(birthday, "%M") IN ("May", "August");

-- task 5

SELECT * FROM users WHERE id IN (5, 1, 2) ORDER BY id = 2, id = 1, id = 5;

SELECT * FROM users WHERE id IN (5, 1, 2) ORDER BY FIELD(id, 5,1,2); 






