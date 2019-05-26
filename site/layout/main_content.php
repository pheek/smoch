<?php

if(strpos($_SERVER['PHP_SELF'], 'erfindung.php') > 0) {
	include 'layout/tour_layout.php';
} else {
	include 'introseite.php';
}
	
?>