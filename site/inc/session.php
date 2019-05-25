<?php
session_start();

if(! array_key_exists('kategorie_id', $_SESSION)) {
	$_SESSION['kategorie_id'] = 1;
}

?>