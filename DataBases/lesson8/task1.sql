-- task 1

-- решение из 6 урока с помощью подзапросов 

SELECT
	likes_mens.mens,
	likes_womens.womens,
	CONCAT('The most likes were given by ', if (likes_mens.mens > likes_womens.womens,'men','women'))
from 
	(select COUNT(*) as mens from likes where user_id in (select user_id from profiles where gender = 'M')) likes_mens,
	(select COUNT(*) as womens from likes where user_id in (select user_id from profiles where gender = 'F')) as likes_womens;
	

-- решение с помощью JOIN

SELECT
	p.gender AS GENDER,
	COUNT(l.id) AS `LIKE FROM GENDER`
FROM
		users u
	JOIN
		likes l
		ON u.id = l.user_id 
	JOIN
		profiles p
		ON u.id = p.user_id
GROUP BY 
	p.gender
ORDER BY
	`LIKE FROM GENDER` DESC
LIMIT 1;
	