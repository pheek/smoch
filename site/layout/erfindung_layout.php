<?php
//require_once 'db_connection.php';
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

?>


<div class='erfindung'>
	<div class='erfindungHeader'>
		<div>PREV</div>
		<div><?php echo $erfindung->titel;?>&nbsp;(<?php echo $erfindung->jahr; ?>)</div>
  	<div>NEXT</div>
	</div>
			                                    <div style='clear: both;' class='erfindungsBilder'>
	<?php include 'bildergalerie.php' ?>
	</div>
	<div class='erfindungsText'>
		<?php include 'erfindungen/artikel/_erfindung_template.php'; ?>
	</div>
	<div class='erfindungsExponate'>
			{{EXPONAT_GALERIE}}
	</div>
</div>