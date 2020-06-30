SELECT
	(SELECT CONCAT(first_name, ' ', last_name) 
     FROM users 
     WHERE id = user_id) AS name,
	TIMESTAMPDIFF(YEAR, birthday, NOW()) AS age,
	(select count(id) 
	 from likes 
	 where target_type_id = 2 and target_id = p2.user_id) as likes
FROM 
	profiles p2
order by 
	birthday desc
limit 10;



SELECT user_id AS name FROM profiles p2 order by birthday desc limit 10;


SELECT RAND();

select count(id) 
	 from likes
	 where target_type_id = 2 and target_id = 88;