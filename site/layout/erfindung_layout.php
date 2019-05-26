<?php
//require_once 'db_connection.php';
require_once 'inc/db/sql.php';
require_once 'inc/dao/dao_erfindung.php';
require_once 'inc/session.php';


$url = $_SERVER['PHP_SELF'];
preg_match('/(.*)(\.php\/)([a-z]*)(.*)/', $url, $matches, PREG_OFFSET_CAPTURE);
if(sizeof($matches) >= 4) {
	$erfindungID = $matches[3][0];
} else {
	$erfindungID = 'abakus'; // default get from DB the FIRST TODO
}
 
$daoErfindung    = new DAO_Erfindung();
$erfindung = $daoErfindung->getErfindungsObjekt($erfindungID, $_SESSION['kategorie_id']);


function prevLink() {
	global $erfindungID;
	global $_SESSION;
//	echo $_SESSION['kategorie_id'];
	$vorg =  SQL::getVorgaenger($erfindungID, $_SESSION['kategorie_id']);

	if(! isset($vorg) || strlen($vorg) < 1) {
		return "";
	}
	$link = "<a href='./" . $vorg . "'>&lt;&lt</a>";
	return $link;	
}

function nextLink() {
	global $erfindungID;
	global $_SESSION;
//	echo $_SESSION['kategorie_id'];
	$nachf =  SQL::getNachfolger($erfindungID, $_SESSION['kategorie_id']);

	if(! isset($nachf) || strlen($nachf) < 1) {
		return "";
	}
	$link = "<a href='./" . $nachf . "'>&gt;&gt</a>";
	return $link;	
}


?>


<div class='erfindung'>
	<div class='erfindungHeader'>
	<div><?php echo prevLink(); ?></div>
		<div><?php echo $erfindung->titel;?>&nbsp;(<?php echo $erfindung->jahr; ?>)</div>
<div><?php echo nextLink(); ?></div>
	</div>

<?php include 'bildergalerie.php' ?>

	<div class='erfindungsText'>
		<?php include 'erfindungen/artikel/' . $erfindung->IDurl . '.php'; ?>
	</div>
	<div class='erfindungsExponate'>
			{{EXPONAT_GALERIE}}
	</div>
</div>