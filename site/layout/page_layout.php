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
		        content = "computing history, computing, history, museum, swiss, small<?php echo $_PRE_KEYWORDS; ?>" />
<?php
 require_once 'inc/db/sql.php';
 $browserPath = SQL::getActBrowserPath();
?>
		<link   rel     = "stylesheet"
		        href    = "<?php echo $browserPath;?>layout/css/style.css" />
		<link   rel     = "stylesheet"
		        href    = "<?php echo $browserPath;?>layout/css/artikel.css" />
		<link   rel     = "stylesheet"
		        href    = "<?php echo $browserPath;?>layout/css/erfindung.css" />
		<script src     = "<?php echo $browserPath;?>js/dom/asyncLoader.js" async></script>
	</head>

<?php
	require_once 'inc/db/sql.php';
	$CLIENT_ROOT = SQL::getActBrowserPath();
?>

	<body>
		<div id='mainHeader'>
	 <div><a href='<?php echo $CLIENT_ROOT; ?>'><img src='<?php echo $CLIENT_ROOT; ?>layout/img/home.png' height="48" /></a></div>
	   <div>SMOCH</div>
	 <div><img src='<?php echo $CLIENT_ROOT; ?>layout/img/swiss-made.png' height="48" /></div>
    </div>
			<?php include 'layout/main_content.php'; ?>
		<div id='mainFooter'>ⓒ φ</div>
	</body>

</html>
