<?php
// TODO: Set the Prerequisites to include into the <head> from the request into the following variable:
require_once 'inc/session.php'          ;
require_once 'inc/dao/dao_erfindung.php';


function isErfindungsSeite() {
	return strpos($_SERVER['PHP_SELF'], 'erfindung.php') > 0;
}

/** 
 * Es wird hier davon ausgegangen, dass es sich um eine Erfindungsseite handelt.
 * S. isErfindungsSeite();
 */

function getErfindungsID() {
	$url = $_SERVER['PHP_SELF'];
	preg_match('/(.*)(\.php\/)([a-z_]*)(.*)/', $url, $matches, PREG_OFFSET_CAPTURE);
	if(sizeof($matches) >= 4) {
		$erfindungID = $matches[3][0];
	} else {
		$erfindungID = 'abakus'; // default get from DB the FIRST TODO
	}
	return $erfindungID;
}


$_PRE_KEYWORDS    = "key1, key2";
$_PRE_AUTHOR      = 'phi@smoch.ch';
$_PRE_TITLE       = 'Small Museum of Computing History';
$_PRE_DESCRIPTION = 'a small museum of computing history';
$_PRE_DATE        = '2019-05-23';


if(isErfindungsSeite()) {
	$tmpDaoErfindung    = new DAO_Erfindung();
	$tmpKategorie       = 1;
	if(array_key_exists($_SESSION['kategorie_id'])) {
		$tmpKategorie = $_SESSION['kategorie_id'];
	}
	$erfindung = $tmpDaoErfindung->getErfindungsObjekt(getErfindungsID(), $tmpKategorie);
	$keywordsString = "";
	foreach($erfindung->keywords AS $kw => $ww) {
		$keywordsString = $keywordsString . ', ' . $ww;
	}
	$_PRE_KEYWORDS = $keywordsString;
}


?>
