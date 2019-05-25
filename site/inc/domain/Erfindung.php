<?php

/**
 * Domain Klasse "Erfindung"
 * Alles, was mit der Erfindung zu tun hat, incl. default Kategorie.
 * Nicht dazu gehört, in welcher Tour (Kategorie) sich der Betrachter gerade
 * befindet: Diese Informtaion steht in der Session_variable.
 * 2019-05-23
 * phi@smoch.ch
 */


class Erfindung {
	public function __construct() {
	}

	public $IDurl;
	public $titel;
	public $jahr;
	public $defaultKat;

	/**
	 * Alle möglichen Nachfolger pro Tour
	 *
	 * Dieser array beinhaltet für jede mögliche Tour (Kategorie)
	 * den Nachfolger oder "NULL", falls dort die Tour zu Ende ist
	 *
	 * Beispiel $smartphone->nachfolgerArray[1] == NULL
	 *          $abakus->nachfolger[2] == 'rechenschieber'
	 */ 
	public $nachfolgerArray; // Alle nachfolger


	public function getLink() {
		return "<a href='/index.php/".    $IDurl   . "'> ".$titel." </a>";
	}

	public function getNachfolgerInTour($kat) {
		return $nachfolgerArray[$kat];
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