<!DOCTYPE html>
<!-- Find the template for this website here: https: //github.com/pheek/HTMLTemplate  -->

<!-- Insert description of your website here... -->
<html lang="de">

	<head>
		<title><?php echo $_PRE_TITLE;?></title>

		<meta   charset = "utf-8" />
		<!-- change author and date -->
		<meta   name    = "author"
		        content = "<?php echo $_PRE_AUTHOR; ?>" />
		<!-- date: Non standard attribute. (ev. remove): -->
		<meta   name    = "date"
		        content = "<?php echo $_PRE_DATE;?>"
		        scheme  = "YYYY-MM-DD"/>
		<meta   name    = "description"
		        content = "<?php echo $_PRE_DESCRIPTION;?>" />
		<meta   name    = "keywords"
		        content = "computing history, computing, history, museum, swiss, small, <?php echo $_PRE_KEYWORDS; ?>" />
<?php
 require_once __DIR__ . '/../inc/db/sql.php';
 $browserPath = SQL::getActBrowserPath();
?>
		<link   rel     = "stylesheet"
		        href    = "<?php echo $browserPath;?>layout/css/style.css" />
		<script src     = "<?php echo $browserPath;?>js/dom/asyncLoader.js" async></script>
	</head>

	<body>
		<div id='mainHeader'> SMOCH </div>
			<?php include 'main_content.php'; ?>
		<div id='mainFooter'>φ ⓒ</div>
	</body>

</html>
