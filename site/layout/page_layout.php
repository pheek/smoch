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

		<link   rel     = "stylesheet"
		        href    = "layout/css/style.css" />
		<script src     = "js/dom/asyncLoader.js" async></script>
	</head>

	<body>
		<div id='mainHeader'> SMOCH (header kommt hier)</div>
<?php include 'main_content.php'; ?>
	  <div id='mainFooter'>φ ⓒ</div>                              
	</body>

</html>