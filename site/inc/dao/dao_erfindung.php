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
		if(! isset($siteURL) || strlen($siteURL) < 1) {
			$siteURL   = 'abakus';
			$kategorie =        1;
		}
		$erfindung = new Erfindung();
		$resultSet = SQL::getErfindungsRecordDefault($siteURL);

		$erfindung->IDurl      = $siteURL;
		$erfindung->titel      = $resultSet['ErfindungsTitel'   ];
		$erfindung->jahr       = $resultSet['ErfindungsJahrzahl'];
		$erfindung->defaultKat = $resultSet['defaultKategorie'  ];

		// Mögliche Nachfolger bestimmen
		$resultSetMitKat = SQL::getErfindungsRecordMitKategorie($siteURL, $kategorie);
/*		var_dump($resultSetMitKat);
		foreach($resultSetMitKat as $key => $value) {
			echo "DEBUG dao.php: " . $key . '---' . $value . "<br />\n";
		}
*/
		
		// ...
		return $erfindung;
	}

	

}