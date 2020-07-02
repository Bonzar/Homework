-- Part 1. Task 2

CREATE VIEW names AS 
SELECT 
	p.name AS products,
	c.name AS catalogs
FROM 
		products p
	JOIN
		catalogs c 
		ON p.catalog_id = c.id;
		
SELECT * FROM names;