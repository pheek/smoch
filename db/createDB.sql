-- 2019-05-18 phi
-- DATENBANK zu SMOCH

-- --------------------------------------------------------------
-- db
-- --------------------------------------------------------------
DROP   DATABASE IF EXISTS `smocha_db`  ;
CREATE DATABASE           `smocha_db`  ;
ALTER  DATABASE           `smocha_db`
  DEFAULT CHARACTER SET 'utf8'
	DEFAULT COLLATE 'utf8_general_ci';

USE                      `smocha_db`  ;

-- USER SMOCH
DROP   USER 'smoch';
CREATE USER 'smoch' IDENTIFIED BY '123';
GRANT SELECT ON `smocha_db`.* TO 'smoch'@'%';
