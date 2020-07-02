-- Part 1. Task 1

START TRANSACTION;

SELECT * FROM shop.users WHERE id = 1;

INSERT INTO sample.users (name, birthday_at, created_at, updated_at)
SELECT name, birthday_at, created_at, updated_at 
	FROM shop.users 
	WHERE id = 1;

COMMIT;
