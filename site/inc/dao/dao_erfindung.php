<?php

/**
 * phi@smoch.ch
 * 2019-05-19
 * Data Access Object für Erfindungen
 */

/* Just in case the includes are not found...*/
/*while (! file_exists('inc/domain') ) {
  chdir('..');
  }*/

require_once 'inc/db/sql.php';
require_once 'inc/domain/Erfindung.php';

class DAO_Erfindung {

	/**
	 * Alle Informationen zu einer Erfindung = zu einer Webseite.
	 * Achtung: Smartphone kommt mehrmals vor in verschiedenen Kategorien.
	 *          Dabei ist alles gleich, aber Vorgänger und Nachfolger sind von der 
	 *          Kategorie abängig!
	 */
	public static function getErfindungsObjekt($siteURL, $kategorie) {
		$erfindung = new Erfindung();
		$resultSet = SQL::getErfindungsRecordDefault($siteURL);

		$erfindung->IDurl      = $siteURL;
		$erfindung->titel      = $resultSet['ErfindungsTitel'   ];
		$erfindung->jahr       = $resultSet['ErfindungsJahrzahl'];
		$erfindung->defaultKat = $resultSet['defaultKategorie'  ];

		// Mögliche Nachfolger bestimmen
		$resultSetMitKat = SQL::getErfindungsRecordMitKategorie($siteURL, $kategorie);
		foreach($resultSetMitKat as $entry) {
			echo "DEBUG dao.php: " . $entry . "<br />\n";
		}
		
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
	public function getAlleExponateZuErfindung($siteUrl) {

	}


}