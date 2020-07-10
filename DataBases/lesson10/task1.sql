-- Task 1

CREATE INDEX users_email_idx ON users(email);

CREATE INDEX posts_created_at_idx ON posts(created_at);
CREATE INDEX communities_name_idx ON communities(name);
CREATE INDEX messages_body_idx ON messages(body);

DESC messages;

SELECT
	MAX(len)
FROM 
	(SELECT CHAR_LENGTH(body) AS len FROM messages m) len	
LIMIT 1;

ALTER TABLE messages MODIFY COLUMN body VARCHAR(500); 

CREATE INDEX messages_body_idx ON messages(body);

CREATE INDEX users_first_name_last_name_idx ON users(first_name, last_name);
