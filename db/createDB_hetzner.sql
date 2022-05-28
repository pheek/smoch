-- 2019-05-18 phi
-- DATENBANK zu SMOCH

-- --------------------------------------------------------------
-- db
-- --------------------------------------------------------------
-- --DROP   DATABASE IF EXISTS `smoch`  ;
-- --CREATE DATABASE           `smoch`  ;
ALTER  DATABASE           `smoch_db`
  DEFAULT CHARACTER SET 'utf8'
	DEFAULT COLLATE 'utf8_general_ci';

USE                      `smoch_db`  ;

-- USER SMOCH
DROP   USER 'smoch';
CREATE USER 'smoch' IDENTIFIED BY '123';
GRANT SELECT  ON `smoch_db`.* TO 'smoch'@'%';
