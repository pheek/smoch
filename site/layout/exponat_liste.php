<?php

require_once 'inc/dao/dao_exponat.php';

$exponatListe = DAO_Exponat::getAlleExponateZuErfindung($erfindungID);

if(sizeof($exponatListe) >= 1) {
	include 'layout/exponatTable.php';
}

?>