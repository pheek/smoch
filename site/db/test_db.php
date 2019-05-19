<?php

//require_once 'db_connection.php';
require_once 'dao.php';

$pdo = ConnectionSingleton::getThePDO();


$alleSeiten = DAO::getAlleWebseitenCore();
foreach($alleSeiten as $row) {
	echo $row['Titel'] . '<br />';
}

echo "dao: <br >";

$website = DAO::getObjektDaten('abakus');

var_dump($website);


?>