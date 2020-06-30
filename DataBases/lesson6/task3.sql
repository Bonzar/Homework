-- Решение 1

SELECT
	(select COUNT(*) from likes where user_id in (select user_id from profiles where gender = 'M')) as likes_mens,
	(select COUNT(*) from likes where user_id in (select user_id from profiles where gender = 'F')) as likes_womens,
	CONCAT('The most likes were put by ', if ((select COUNT(*) from likes where user_id in (select user_id from profiles where gender = 'M')) > (select COUNT(*) from likes where user_id in (select user_id from profiles where gender = 'F')),'men','women'))
from 
	users limit 1;
	
-- Добрый день, на этом задании возникли вопросы.
-- 1. При изучении я где то слышал, но теперь не могу найти не в методичках не в интернете, что можно использовать какую-то виртуальную 
--    таблицу для запросов SELECT (вместо users limit 1, из которого я ни одного столбца то и не взял).
-- 2. Я хотел использовать псевдонимы команд (likes_mens и likes_womens), вместо повторения поиска количества лайков, но так запрос не работал.
--    Есть ли возможность не повторять команды в такой реализации?


-- Решение 2

SELECT
	likes_mens.mens,
	likes_womens.womens,
	CONCAT('The most likes were given by ', if (likes_mens.mens > likes_womens.womens,'men','women'))
from 
	(select COUNT(*) as mens from likes where user_id in (select user_id from profiles where gender = 'M')) likes_mens,
	(select COUNT(*) as womens from likes where user_id in (select user_id from profiles where gender = 'F')) as likes_womens;
	
-- Вроде как подразобрался с псевдонимами, если есть замечания и дополнения, прошу указать
-- Насчёт виртуальной таблицы так и не понял