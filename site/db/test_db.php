<?php

//require_once 'db_connection.php';
require_once 'dao.php';

$pdo = ConnectionSingleton::getThePDO();

echo "<h1>Debug DAO</h1>";

echo "<h2>dao: alle Webseiten:</h2>\n";

$alleSeiten = DAO::getAlleWebseiten();
foreach($alleSeiten as $row) {
	echo $row['KategorieName'] . '--- &gt;' .$row['ErfindungsTitel'] . '<br />';
}

echo "<h2>dao abakus: </h2>\n";

$website = DAO::getErfindungDaten('abakus', 1);

var_dump($website);


echo "<h2>dao amphore-bilder</h2>\n";

$bilder = DAO::getAlleBilderZuWebseite('amphore');
foreach($bilder as  $bild) {
	var_dump($bild);
	echo "<br/>\n";
}


echo "<h2>dao amphore-exponate</h2>\n";
$exponate = DAO::getAlleExponateZuWebseite('amphore');
foreach($exponate as $exponat) {
	var_dump($exponat);
	echo "<br/>\n";
}




?>