<?php

/**
 * phi@smoch.ch
 * 2019-05-19
 * Data Access Object für Bilder
 */

/* Just in case the includes are not found...*/
/*while (! file_exists('inc/domain') ) {
  chdir('..');
  }*/

require_once 'inc/db/sql.php';
require_once 'inc/domain/Bild.php';

class DAO_Bild {

	/**
	 * Alle Informationen zu einer Erfindung = zu einer Webseite.
	 * Achtung: Smartphone kommt mehrmals vor in verschiedenen Kategorien.
	 *          Dabei ist alles gleich, aber Vorgänger und Nachfolger sind von der Kategorie abängig!
	 */
	public static function getBildViaID($bildID) {
		$bild = new Bild();
		$resultSet = SQL::getBildInfo($bildID);

		$bild->dbID        = $bildID;
		$bild->filename    = $resultSet['filename'   ];
		$bild->bildlegende = $resultSet['bildlegende'];
		$bild->bildrechte  = $resultSet['bildrechte' ];
		$bild->altText     = $resultSet['alt_text'   ];

		//var_dump ($bild);
		return $bild;
	}

	private static function enrichErfindungsBild($eb, $b) {
		$eb->dbID = $b->dbID;
		$eb->filename = $b->filename;
		$eb->bildlegende = $b->bildlegende;
		$eb->bildrechte = $b->bildrechte;
		$eb->altText = $b->altText;
	}
	
	public static function getAlleBilderZuErfindung($erfindungID) {
		$alleErfindungsBilder = array();
		
		$alleBilderResultSet = SQL::getAlleBilderZuErfindungRecordset($erfindungID);
		
		while ($bildRecord = $alleBilderResultSet->fetch(PDO::FETCH_ASSOC))   { 
			$bildID = $bildRecord['BildID'];
			$bildInfo = DAO_Bild::getBildViaID($bildID);
			$erfindungsBild = new ErfindungsBild();
			DAO_Bild::enrichErfindungsBild($erfindungsBild, $bildInfo);
			$erfindungsBild->ord = $bildRecord['ord'];
			$alleErfindungsBilder[$bildID] = $erfindungsBild;
		} // end while
		return $alleErfindungsBilder;	
	}
	
} // end class DAO_Bild