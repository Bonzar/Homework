-- task 2
-- CREATE PROCEDURE my_version ()
-- BEGIN
--   SELECT VERSION();
-- END

DELIMITER $$

DROP FUNCTION IF EXISTS get_version $$
CREATE FUNCTION get_version ()
BEGIN
  INSERT INTO users (name) VALUES ('user');
END $$

DELIMITER ;


SELECT BENCHMARK(10, get_version ());
-- 
SELECT * FROM users u ORDER BY created_at DESC LIMIT 15;
