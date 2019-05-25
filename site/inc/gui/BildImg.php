<?php

/**
 * Domain Klasse "Bild"
 * 2019-05-23
 * phi@smoch.ch
 */


class BildImg {
	
	public function __construct() {
	}

	public $bild;

	public function createImgTag($imgPath, $width) {
		$imgTag = "";
		$imgTag .= '<img ';
		$imgTag .= 'src="'  . $imgPath . $this->bild->filename . '" ';
		$imgTag .= 'alt="'  . $this->bild->altText . '" ';
		$imgTag .= 'title="' . $this->bild->bildlegende . '" ';
		$imgTag .= 'width="' . $width . '" ';
		$imgTag .= ' />';
		return $imgTag;
	}

} // end class BildImg

?>
