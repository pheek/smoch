<?php

/**
 * phi@smoch.ch
 * 2019-05-19
 * Data Access Object
 */

require_once 'db/sql.php';
require_once 'domain/Erfindung.php';

class DAO {
	
	/**
	 * Alle Informationen zu einer Erfindung = zu einer Webseite.
	 * Achtung: Smartphone kommt mehrmals vor in verschiedenen Kategorien.
	 *          Dabei ist alles gleich, aber Vorgänger und Nachfolger sind von der 
	 *          Kategorie abängig!
	 */
	public static function getErfindungsObjekt($siteURL, $kategorie) {
		$erfindung = new Erfindung();
		$resultSet = SQL::getErfindungsRecord($siteURL, $kategorie);
		
		$erfindung->IDurl = $siteURL;
		$erfindung->titel = $resultSet['ErfindungsTitel'];
		$erfindung->jahr  = $resultSet['ErfindungsJahrzahl'];

		// ...
		return $erfindung;
	}

	/**
	 * Liste aller Webseiten mit allen Infos (ohne Bilder und ohne Exponate).
	 */
	public function getAlleErfindungen() {

	}

	/**
	 * Liefert alle Bilder zu einer gegebenen Erfindung
	 */
	public function getAlleBilderZuWebseite($siteUrl) {

	}


  /**
	 * Liefert alle Exponate zu einer gegebenen Erfindung
	 */
	public function getAlleExponateZuWebseite($siteUrl) {

	}

	

}