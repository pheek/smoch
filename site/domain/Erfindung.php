<?php

/**
 * Domain Klasse "Erfindung"
 * 2019-05-23
 * phi@smoch.ch
 */


class Erfindung {
	public function __construct() {
	}

	public $IDurl;
	public $titel;
	public $jahr;

	public function getLink() {
		return "<a href='/index.php/".    $IDurl   . "'> ".$titel." </a>";
	}

	/*
	public function setIDurl($IDurl) {
		$this->IDurl = $IDurl;
	}

	public function setTitel($titel) {
		$this->titel = $titel;
	}

	public function setJahr($jahr) {
		$this->jahr = $jahr;
	}

	public function getIDurl() {
		return $this->IDurl;
	}
	*/

} // end class Erfindung

?>

