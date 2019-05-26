<?php
/**
 * phi@smoch.ch
 * 2019-05-26
 */
$CLIENT_ROOT = SQL::getActBrowserPath();

$ERFINDUNG_PREFIX = "./";

if(strpos($_SERVER['PHP_SELF'], 'ndex.php') > 0) {
	$ERFINDUNG_PREFIX = $CLIENT_ROOT . 'erfindung.php/';
}

function navLinkToKategorie($linkKategorieNr) {
	global $ERFINDUNG_PREFIX;
	$actKat        = $_SESSION['kategorie_id'];
	$kategorieName = SQL::getKategorieName($linkKategorieNr);


	if(($actKat == $linkKategorieNr) && (strpos($_SERVER['PHP_SELF'], 'rfindung.php') > 0)) {
		return "<span class='unLink'>" . $kategorieName . "</span>";
	}
	
	$ersteErfindungInTourID = SQL::getErsteErfindungUrlInKategorie($linkKategorieNr);
	$katLink = "<a href='" . $ERFINDUNG_PREFIX . $ersteErfindungInTourID . '?kategorie=' . $linkKategorieNr . "' > " . $kategorieName . "</a>";
	return $katLink;
}

?>

<div class='tourHeader'>
<?php
$katNr = 1;
while($katNr <= 3) {
	echo navLinkToKategorie($katNr) . "\n";
	$katNr = $katNr + 1;
}
?>
</div>
