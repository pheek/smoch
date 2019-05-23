<!DOCTYPE html>
<!-- Find the template for this website here: https: //github.com/pheek/HTMLTemplate  -->

<!-- Insert description of your website here... -->
<html lang="de">

	<head>
		<title>{{layout.header.title}}</title>

		<meta   charset = "utf-8" />
		<!-- change author and date -->
		<meta   name    = "author"
		        content = "Philipp Gressly Freimann phi@gress.ly" />
		<!-- date: Non standard attribute. (ev. remove): -->
		<meta   name    = "date"
		        content = "2019-05-23"
		        scheme  = "YYYY-MM-DD"/>
		<meta   name    = "description"
		        content = "{{layout.header.description}}" />
		<meta   name    = "keywords"
		        content = "{{layout.header.keywords}}" />

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
