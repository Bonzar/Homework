--  Part 1. Task 4

DROP TABLE dates;
CREATE TABLE dates (id INT NOT NULL AUTO_INCREMENT PRIMARY KEY, created_at DATE);

INSERT INTO sample.dates (created_at ) VALUES 
	(DATE('2018-08-01')),
	(DATE('2016-08-04')),
	(DATE('2018-08-16')),
	(DATE('2018-08-17')),
	(DATE('2018-08-18')),
	(DATE('2018-08-19')),
	(DATE('2018-08-20')),
	(DATE('2018-08-21')),
	(DATE('2018-08-22'));
	
SELECT * FROM dates d ORDER BY created_at DESC; 

SELECT id FROM dates ORDER BY created_at DESC LIMIT 5;

DELETE FROM dates WHERE id NOT IN
	(SELECT * FROM
		(SELECT id FROM
						dates 
				ORDER BY created_at DESC
				LIMIT 5
		) AS fresh_id
	);

-- Не уверен в рациональности данного способа, так же не придумал как его можно решить с помощью JOIN
