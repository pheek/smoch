<?php
/**
 * phi@smoch.ch
 * 2019-05-27
 *
 * Zeigt alle Infos zu einem Exponat inkl. eine Liste aller zugehörigen Bilder.
 */

require_once 'inc/dao/dao_exponat.php';
require_once 'inc/gui/BildImg.php'    ;

function printAlleExponatBilder($exponat) {
	$bilder = DAO_Exponat::getAlleBilderZuExponat($exponat->DBId);
	foreach($bilder as $bild) {
		$bildImg = BildImg::readBildImgViaID($bild->dbID);
		echo "<div class='small_image_rahmen'>"    .
			   $bildImg->createImgTag('small_image') .
			   "</div>";
	}
}


function createExponatTableRow($exponat) {
	echo "<tr class='exponatTabelle'>\n";
	echo "<td>" . $exponat->Modellbezeichnung . "</td>\n";
	echo "<td>" . $exponat->Jahr              . "</td>\n";
	echo "<td>" . $exponat->inventarNummer    . "</td>\n";
	if(0 != $exponat->ausgestellt) {
			echo "<td>Ja</td>\n";
	} else {
			echo "<td> - </td>\n";
	}
	echo "<td>";
	printAlleExponatBilder($exponat);
	echo "</td>\n";
	
	echo "</tr>\n";
		
}

function createExponatTableRows() {
	global $exponatListe;
	foreach($exponatListe as $exponat) {
		createExponatTableRow($exponat);
	}
}

?>

<div>
	<table>
	<tr class='exponatListeTitel'><td colspan='5'><h1 class='exponatListeTitel'>Exponate</h1>
</td></tr>
	<tr class='erfindungsExponat'><td>Modell</td><td>Jahr</td><td>Inventar Nr.</td><td>Ausgestellt?</td><td>Bilder</td></tr>
<?php createExponatTableRows(); ?>
	</table>
</div>
	