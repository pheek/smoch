<?php
$CLIENT_ROOT = SQL::getActBrowserPath();

$ERFINDUNG_PREFIX = "./";
if(strpos($_SERVER['PHP_SELF'], 'ndex.php') > 0) {
	$ERFINDUNG_PREFIX = $CLIENT_ROOT . 'erfindung.php/';
}

?>

<div class='tourHeader'>
	 <a href='<?php echo $ERFINDUNG_PREFIX; ?>abakus&kategorie=1'     >Rechnen</a>
<a href='<?php echo $ERFINDUNG_PREFIX; ?>amphore&kategorie=2'    >Speichern</a>
	<a href='<?php echo $ERFINDUNG_PREFIX; ?>keilschrift&kategorie=3'>Kommunizieren</a>
	</div>
