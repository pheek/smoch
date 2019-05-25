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
	public static function getErfindungsRecordMitKategorie($siteURL, $kategorie) {
		$SQL  = 'SELECT * FROM `vw_erfindung` WHERE (`URL_Infix` = "' . $siteURL . '" AND `KategorieID` = "'.$kategorie.'")';
		return SQL::fetchSingle($SQL);
	}

	public static function getErfindungsRecordDefault($siteURL) {
		$SQL  = 'SELECT * FROM `vw_erfindung` WHERE `URL_Infix` = "' . $siteURL . '" LIMIT 1';
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

	public static function getAlleBilderZuExponat($exponatID) {
		$SQL = 'SELECT * FROM `vw_exponatbilder` WHERE `exponat_ID` = "' . $exponatID . '"';
		return SQL::fetchRows($SQL);
	}

	public static function getBildInfo($bildID) {
		$SQL = 'SELECT * FROM `tbl_bild` WHERE `ID` = "' . $bildID . '"';
		return SQL::fetchSingle($SQL);
	}


	public static function getProgramParameter($varName) {
		$SQL = 'SELECT `value` FROM `tbl_program_parameter` WHERE `name` = "' . $varName . '"';
		$val = SQL::fetchSingle($SQL);
		if(!isset($val) || !isset($val['value'])) {
			var_dump($val);
			echo "ERROR in sql.php: Progarmm parameter " . $varName . " not found!";
			return "ERROR in sql.php";
		}
		return $val['value'];
	}


	public static function getActBrowserPath() {
		$isDevel = SQL::getProgramParameter('isDevelop');
		if('true' == $isDevel) {
			return SQL::getProgramParameter('browser_path_develop');
		} else {
			return SQL::getProgramParameter('browser_path'        );
		}
	}
	
	public static function getErfindungenPath() {
		return SQL::getActBrowserPath() . SQL::getProgramParameter('erfindungen_pfad');
	}
		
	
	public static function getArtikelDir() {
		return '' . SQL::getErfindungenPath() . SQL::getProgramParameter('artikel_dir');
	}
	public static function getBilderDir() {
		return '' . SQL::getErfindungenPath() . SQL::getProgramParameter('bilder_dir');
	}
	
}
