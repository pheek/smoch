<?php

/**
 * phi@smoch.ch
 * 2019-05-19
 * Data Access Object für Exponate
 */

/* Just in case the includes are not found...*/
/*while (! file_exists('inc/domain') ) {
  chdir('..');
  }*/

require_once 'inc/db/sql.php';
require_once 'inc/domain/Exponat.php';

class DAO_Exponat {

	
	public static function getExponatViaID($exponatID) {
		$exponat = new Exponat();
		//...
		return $erfindung;
	}

	public static function getAlleExponateZuErfindung($erfindungsID) {
		$exponatListe = array();
		
		$exponateRecordset = SQL::getAlleExponateZuErfindungRecordset($erfindungsID);

		while($exponatRecord = $exponateRecordset->fetch(PDO::FETCH_ASSOC)) {
			$exponat = new Exponat();
			$exponat->DBId              = $exponatRecord['ExponatID'      ];
			$exponat->Jahr              = $exponatRecord['Modelljahr'     ];
			$exponat->Modellbezeichnung = $exponatRecord['Modell'         ];
			$exponat->ausgestellt       = $exponatRecord['ausgestelltBOOL'];
			$exponat->inventarNummer    = $exponatRecord['InventarNummer' ];

			$exponatListe[$exponat->DBId] = $exponat;
		} // end while
		return $exponatListe;
	} // 

	public static function getAlleBilderZuExponat($exponatID) {
		$bildListe = array();
		// ...
		return $bildListe;
	} // end fct getAlleBilder Zu Exponat
}