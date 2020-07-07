CREATE USER shop_read;
GRANT SELECT ON shop.* TO shop_read;

CREATE USER shop;
GRANT ALL ON shop.* TO shop;

SELECT user FROM user;

SHOW GRANTS FOR shop;
SHOW GRANTS FOR shop_read;