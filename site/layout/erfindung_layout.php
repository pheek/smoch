<?php
//require_once 'db_connection.php';
require_once 'inc/preRequisites.php'    ;
require_once 'inc/db/sql.php'           ;
require_once 'inc/dao/dao_erfindung.php';
//require_once 'inc/session.php'          ;

/*
$url = $_SERVER['PHP_SELF'];
preg_match('/(.*)(\.php\/)([a-z_]*)(.*)/', $url, $matches, PREG_OFFSET_CAPTURE);
if(sizeof($matches) >= 4) {
	$erfindungID = $matches[3][0];
} else {
	$erfindungID = 'abakus'; // default get from DB the FIRST TODO
}
*/

$daoErfindung    = new DAO_Erfindung();
$erfindung = $daoErfindung->getErfindungsObjekt(getErfindungsID(), $_SESSION['kategorie_id']);

function prevLink() {
	global $_SESSION;
//	echo $_SESSION['kategorie_id'];
	$first = SQL::getErsteErfindungUrlInKategorie($_SESSION['kategorie_id']);
	$vorg =  SQL::getVorgaenger(getErfindungsID(), $_SESSION['kategorie_id']);

	if(! isset($vorg) || strlen($vorg) < 1) {
		return "";
	}
	$linkFirst = "<a href='./" . $first . "'><img src='../layout/img/first.png'    alt='Doppelpfeil nach links' title='Erste Erfindung dieser Kategorie'/></a>";
	$linkNext  = "<a href='./" . $vorg  . "'><img src='../layout/img/previous.png' alt='Pfeil nach links'       title='Vorgänger'/></a>";
	return $linkFirst . $linkNext;
}

function nextLink() {
	global $_SESSION;
//	echo $_SESSION['kategorie_id'];
	$nachf =  SQL::getNachfolger(getErfindungsID(), $_SESSION['kategorie_id']);

	if(! isset($nachf) || strlen($nachf) < 1) {
		return "";
	}
	$link = "<a href='./" . $nachf . "'><img src='../layout/img/next.png' alt='Pfeil nach rechts' title='Nachfolger'/></a>";
	return $link;
}


?>


<div class='erfindung'>
	<div class='erfindungHeader'>
		<div class='backback'><?php echo prevLink(); ?></div>
		<div><?php echo $erfindung->titel;?> (<?php echo $erfindung->jahr; ?>)</div>
		<div class='forfor'><?php echo nextLink(); ?></div>
	</div>

	<?php include 'bildergalerie.php' ?>

	<div class='erfindungsText'>
		<?php include 'erfindungen/artikel/' . $erfindung->IDurl . '.php'; ?>
	</div>

	<div class='erfindungsExponate'>
		<?php include 'exponat_liste.php'; ?>
	</div>
</div>
