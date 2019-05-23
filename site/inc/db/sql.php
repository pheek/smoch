<?php

/**
 * phi@smoch.ch
 * 2019-05-19
 * SQL Helper Function for the Data Access Objects
 */
require_once 'db_connection.php';

class SQL {

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
	public static function getErfindungsRecord($siteURL, $kategorie) {
		$SQL  = 'SELECT * FROM `vw_webseite` WHERE (`URL_Infix` = "' . $siteURL . '" AND `KategorieID` = "'.$kategorie.'")';
		return SQL::fetchSingle($SQL);
	}

	/**
	 * Liste aller Webseiten mit allen Infos (ohne Bilder und ohne Exponate).
	 */
	public static function getAlleWebseitenRecordset() {
		$SQL  = 'SELECT * FROM `vw_webseite`';
		return SQL::fetchRows($SQL);
	}

	/**
	 * Liefert alle Bilder zu einer gegebenen Erfindung
	 */
	public static function getAlleBilderZuWebseiteRecordset($siteUrl) {
		$SQL = 'SELECT * FROM `vw_image` WHERE `URL_Infix` = \'' . $siteUrl . '\' ORDER BY `ord`';
		return SQL::fetchRows($SQL);
	}


  /**
	 * Liefert alle Exponate zu einer gegebenen Erfindung
	 */
	public static function getAlleExponateZuWebseiteRecordset($siteUrl) {
		$SQL = 'SELECT * FROM `vw_exponat` WHERE `core` = \'' . $siteUrl . '\' ORDER BY `ord`';
		return SQL::fetchRows($SQL);
	}


	public static function getApplicationVariable($varName) {
		$SQL = 'SELECT `value` FROM `tbl_program_parameters` WHERE `name` = "' . $varName . '"';
		$val = SQL::fetchSingle($SQL);
		return $val['value'];
	}


	public static function getActBrowserPath() {
		$isDevel = SQL::getApplicationVariable('isDevelop');
		if('true' == $isDevel) {
			return SQL::getApplicationVariable('browser_path_develop');
		} else {
			return SQL::getApplicationVariable('browser_path');
		}
	}	
}
