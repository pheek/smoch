<?php

/**
 * phi@smoch.ch
 * 2019-05-19
 * Data Access Object
 */
require_once 'db_connection.php';

class DAO {

	private static function fetchSingle($SQL) {
		$pdo  = ConnectionSingleton::getThePDO();
		$stmt = $pdo->query($SQL);
		$row  = $stmt->fetch(PDO::FETCH_ASSOC);
		return $row;		
	}

	private static function fetchRows($SQL) {
		$pdo  = ConnectionSingleton::getThePDO();
		$stmt = $pdo->query($SQL);
		return $stmt;
	}
	
	/**
	 * Alle Informationen zu einer Erfindung = zu einer Webseite.
	 * Achtung: Smartphone kommt mehrmals vor in verschiedenen Kategorien.
	 *          Dabei ist alles gleich, aber Vorgänger und Nachfolger sind von der 
	 *          Kategorie abängig!
	 */
	public static function getErfindungDaten($siteURL, $kategorie) {
		$SQL  = 'SELECT * FROM `vw_webseite` WHERE (`URL_Infix` = "' . $siteURL . '" AND `KategorieID` = "'.$kategorie.'")';
		return DAO::fetchSingle($SQL);
	}

	/**
	 * Liste aller Webseiten mit allen Infos (ohne Bilder und ohne Exponate).
	 */
	public static function getAlleWebseiten() {
		$SQL  = 'SELECT * FROM `vw_webseite`';
		return DAO::fetchRows($SQL);
	}

	/**
	 * Liefert alle Bilder zu einer gegebenen Erfindung
	 */
	public static function getAlleBilderZuWebseite($siteUrl) {
		$SQL = 'SELECT * FROM `vw_image` WHERE `URL_Infix` = \'' . $siteUrl . '\' ORDER BY `ord`';
		return DAO::fetchRows($SQL);
	}


  /**
	 * Liefert alle Exponate zu einer gegebenen Erfindung
	 */
	public static function getAlleExponateZuWebseite($siteUrl) {
		$SQL = 'SELECT * FROM `vw_exponat` WHERE `core` = \'' . $siteUrl . '\' ORDER BY `ord`';
		return DAO::fetchRows($SQL);
	}

}