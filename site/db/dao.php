<?php

/**
 * phi@smoch.ch
 * 2019-05-19
 * Data Access Object
 */
require_once 'db_connection.php';

class DAO {
	public static function getObjektDaten($siteURL) {
		$SQL  = 'SELECT * FROM `vw_webseite` WHERE (`core` = "' . $siteURL . '")';
		$pdo  = ConnectionSingleton::getThePDO();
		$stmt = $pdo->query($SQL);
		$row  = $stmt->fetch(PDO::FETCH_ASSOC);
		return $row;
	}

	public static function getAlleWebseitenCore() {
		$SQL  = 'SELECT * FROM `vw_webseite`';
		$pdo  = ConnectionSingleton::getThePDO();
		$stmt = $pdo->query($SQL);
		return $stmt;
	}
	
}