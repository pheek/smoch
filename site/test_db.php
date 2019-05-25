<?php

//require_once 'db_connection.php';
require_once 'inc/dao/dao_erfindung.php';

$pdo = ConnectionSingleton::getThePDO();

echo "<h1>Debug DAO</h1>";

echo "<h2>dao: alle Webseiten:</h2>\n";

echo "<h2>dao abakus: </h2>\n";

$daoErfindung    = new DAO_Erfindung();

$abakus = $daoErfindung->getErfindungsObjekt('abakus', 1);

var_dump($abakus);

echo '<h1>BildTest</h1>';

include_once 'inc/gui/BildImg.php';
include_once 'inc/dao/dao_bild.php';

$bildImg = new BildImg();
$bild    = DAO_Bild::getBildViaID("1002"); // nur ein Test pascaline
$bildImg->bild = $bild;

//var_dump( $bildImg->bild);

echo $bildImg->createImgTag("erfindungen/images/", 144);


?>