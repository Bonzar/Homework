-- Task 1

SELECT DISTINCT
	(SELECT name FROM users WHERE id = user_id)
FROM
	orders;

INSERT INTO	orders (user_id)
VALUES (FLOOR(1 + RAND() * 6));

DELETE FROM shop.users 
WHERE id > 6;
