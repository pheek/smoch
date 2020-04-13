<?php

if (PHP_SESSION_NONE == session_status()) {
	session_start();
}

if(! array_key_exists('kategorie_id', $_SESSION)) {
	$_SESSION['kategorie_id'] = 1;
}

if(array_key_exists('kategorie', $_REQUEST)) {
	$_SESSION['kategorie_id'] = $_REQUEST['kategorie'];
}

?>
