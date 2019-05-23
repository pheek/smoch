<?php

//require_once 'db_connection.php';
require_once 'dao.php';

$pdo = ConnectionSingleton::getThePDO();

echo "<h1>Debug DAO</h1>";

echo "<h2>dao: alle Webseiten:</h2>\n";

echo "<h2>dao abakus: </h2>\n";

$dao    = new DAO();

$abakus = $dao->getErfindungsObjekt('abakus');

var_dump($abakus);



?>