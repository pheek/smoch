<?php

/**
 * Domain Klasse "Bild"
 * 2019-05-23
 * phi@smoch.ch
 */

include_once 'inc/db/sql.php';
include_once 'inc/dao/dao_bild.php';

class BildImg {

	public function __construct() {
	}


	public $bild; // domain Bild (nicht GUI-BildImg!)


	public static function readBildImgViaID($bild_id) {
		$bildImg = new BildImg();
		$bild    = DAO_Bild::getBildViaID($bild_id);
		$bildImg->bild = $bild;
		return $bildImg;
	}

	public function createImgTag($CSS_class) {
		$IMG_PATH = SQL::getBilderDir();
		$imgTag = "";
		$imgTag .= '<img ';
		$imgTag .= 'src="'   . $IMG_PATH . $this->bild->filename . '" ';
		$imgTag .= 'alt="'   . $this->bild->altText . '" '             ;
		$imgTag .= 'title="' . $this->bild->bildlegende . '" '         ;
		$imgTag .= 'class="' . $CSS_class . '" '                       ;
		$imgTag .= ' />';
		return $imgTag;
	}

} // end class BildImg

?>
