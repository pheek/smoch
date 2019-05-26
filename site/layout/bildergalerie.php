<?php
include_once 'inc/db/sql.php';
include_once 'inc/gui/BildImg.php';
include_once 'inc/dao/dao_bild.php';


function createAlleBilder() {
	global $erfindungID;
	$alleBilder = DAO_Bild::getAlleBilderZuErfindung($erfindungID);

	foreach($alleBilder as $bild) {
		$bildImg = BildImg::readBildImgViaID($bild->dbID);
		echo "<div class='erfindung_image'>" . $bildImg->createImgTag('normal_image') . "<br/>" . $bildImg->bild->bildlegende . " &nbsp; (" . $bildImg->bild->bildrechte . ")</div>\n";
	} // end foreach
} // end function createAlleBilder

if(sizeof(DAO_Bild::getAlleBilderZuErfindung($erfindungID)) >=1) {
	echo "<div class='erfindungsBilder'>";
	createAlleBilder();
	echo "</div>";
}
?>
