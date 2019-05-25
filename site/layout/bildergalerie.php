<?php
include_once 'inc/gui/BildImg.php';
include_once 'inc/dao/dao_bild.php';

$bildImg = BildImg::readBildViaID('1002');
?>


BILDERGALERIE... z, B.

				<?php echo $bildImg->createImgTag('small_image'); ?>
