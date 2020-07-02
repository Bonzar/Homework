-- task 2

SELECT
	p.name AS product, c.name AS 'catalog' 
FROM
	products p
JOIN
	catalogs c
ON
	p.catalog_id = c.id;


SELECT * FROM products p;
	
