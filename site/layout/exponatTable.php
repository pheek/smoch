<?php

require_once 'inc/dao/dao_exponat.php';

function printAlleExponatBilder($exponat) {
	$bilder = DAO_Exponat::getAlleBilderZuExponat($exponat->DBId);
	foreach($bilder as $bild) {
		echo "BILD: " . $bild->filename . ", " . $bild->altText . "<br />";
	}
}

function createExponatTableRow($exponat) {
	echo "<tr style='vertical-align: top;'>\n";
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
<div class='exonatTable'>
	<table>
	<tr><td>Modell</td><td>Jahr</td><td>Inventar Nr.</td><td>Ausgestellt?</td><td>Bilder</td></tr>
<?php createExponatTableRows(); ?>
	</table>
</div>
	