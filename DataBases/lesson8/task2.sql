-- task 2

-- решение из 6 урока с помощью подзапросов 

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

-- решение с помощью JOIN

SELECT
	CONCAT(u2.first_name, ' ', u2.last_name) AS `user`,
	u2.id, 
	TIMESTAMPDIFF(YEAR, p.birthday, NOW()) AS age,
	COUNT(l.id) AS `likes`
FROM
		users u2
	JOIN
		profiles p
		ON u2.id = p.user_id 
	LEFT JOIN
		likes l
		ON u2.id = l.target_id 
			AND l.target_type_id = 2
GROUP BY 
	u2.id
ORDER BY 
	p.birthday desc
LIMIT 10;

	
	
