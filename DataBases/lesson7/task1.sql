-- Task 1

SELECT DISTINCT
	(SELECT name FROM users WHERE id = user_id) as name
FROM
	orders;

SELECT DISTINCT 
	u2.name
FROM
	orders o2
JOIN
	users u2
ON
	o2.user_id = u2.id;

INSERT INTO	orders (user_id)
VALUES (FLOOR(1 + RAND() * 6));

DELETE FROM shop.users 
WHERE id > 6;
