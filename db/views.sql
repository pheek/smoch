-- 2019-05-18 phi
-- DATENBANK zu SMOCH (Views)

USE `smoch`;

-- Exponate, wo ein Kärtchen dazu erstellt werden soll.
-- Es existiert entweder ein Exponat, oder ein Photo ist im Schaukasten.
-- Es handelt sich nicht um die Erfindug, mehr jedoch um das aktuell ausgestellte Objekt.
-- CREATE VIEW `vw_exponat` AS
-- SELECT     `tbl_erfindung`  . `IDurl`          AS `core`
-- ,          `tbl_erfindung`  . `Titel`          AS `CoreTitel`
-- ,			     `tbl_erfindung`  . `Jahrzahl`       AS `JahrErfindung`
-- ,			     `tbl_exponat`    . `Exponat_Jahr`   AS `JahrExponat`
-- ,			     `tbl_exponat`    . `Exponat_Modell` AS `ExponatTitel`
-- ,			     `tbl_exponat`    . `ausgestellt`    AS `ausgestellt`
-- ,          `tbl_exponat`    . `inventarNr`     AS `InventarNummer`
-- ,          `tbl_bild`      . `filename`       AS `IMG_Filename`
-- FROM       `tbl_exponat` 
-- LEFT  JOIN `tbl_erfindung` ON `tbl_exponat`.`IDurl_fk`       = `tbl_erfindung`.`IDurl`
-- INNER JOIN `tbl_bild`     ON `tbl_exponat`.`Exponat_img_fk` = `tbl_bild` .`ID`
-- WHERE `ausgestellt` > 0;
CREATE VIEW `vw_exponat` AS
SELECT `tbl_erfindung`.`IDurl`          AS `core`
,      `tbl_erfindung`.`Titel`          AS `Erfindung`
,      `tbl_erfindung`.`Jahrzahl`       AS `Erfindungsjahr`
,      `tbl_exponat`  .`Exponat_Jahr`   AS `Modelljahr`
,      `tbl_exponat`  .`Exponat_Modell` AS `Modell`
,      `tbl_exponat`  .`inventarNr`     AS `InvetarNummer`
,      `tbl_exponat`  .`ausgestellt`    AS `ausgestelltBOOL`
,      `tbl_erfindungsexponat`.`ord`    AS `ord`
FROM `tbl_exponat`
INNER  JOIN `tbl_erfindungsexponat` ON `tbl_exponat`  .`ID`    = `tbl_erfindungsexponat`.`exponat_fk`
LEFT JOIN `tbl_erfindung`         ON `tbl_erfindung`.`IDurl` = `tbl_erfindungsexponat`.`IDurl_fk`;


-- Synthetische Reihenfolge (nach tbl_reihenfolge)
CREATE VIEW `tmp_vw_nachfolger` AS
SELECT DISTINCT
     `tbl_1`.`IDurl_fk`     AS `core`
,		 `tbl_1`.`ord`          AS `ord`
,    `tbl_1`.`kategorie_fk` AS `kat`
,    `tbl_2`.`IDurl_fk`     AS `core_nachfolger`
FROM `tbl_reihenfolge` AS `tbl_1`
LEFT JOIN `tbl_reihenfolge` AS `tbl_2`
ON (`tbl_1`.`kategorie_fk` = `tbl_2`.`kategorie_fk`) AND
   (`tbl_1`.`ord`      = `tbl_2`.`ord` - 1 );


CREATE VIEW `tmp_vw_vorgaenger` AS
SELECT DISTINCT
   `tbl_1`.`IDurl_fk`     AS `core`
,  `tbl_1`.`ord`          AS `ord`
,  `tbl_1`.`kategorie_fk` AS `kat`
,  `tbl_2`.`IDurl_fk`     AS `core_vorgaenger`
FROM `tbl_reihenfolge` AS `tbl_1`
LEFT JOIN `tbl_reihenfolge` AS `tbl_2`
ON (`tbl_1`.`kategorie_fk` = `tbl_2`.`kategorie_fk`) AND
   (`tbl_1`.`ord`      = `tbl_2`.`ord` + 1 );


CREATE VIEW `tmp_vw_reihenfolge` AS
SELECT `core_vorgaenger`            AS `vor`
,      `tmp_vw_vorgaenger`.`core`   AS `core`
,			 `core_nachfolger`            AS `nach`
,      `tmp_vw_vorgaenger`.`kat`    AS `Kategorie`
FROM `tmp_vw_vorgaenger`
LEFT OUTER JOIN `tmp_vw_nachfolger` ON
(`tmp_vw_vorgaenger`.`core` = `tmp_vw_nachfolger`.`core`) AND (`tmp_vw_vorgaenger`.`kat` = `tmp_vw_nachfolger`.`kat`);


-- Im Gegensatz zum Exponat-View (wo die Exonate erscheinen), sind hier
-- die Webseiten aufgelistet.
CREATE VIEW `vw_erfindung` AS
SELECT
  `tmp_vw_reihenfolge`.`core`        AS `URL_Infix`
,	`tbl_erfindung`.`Titel`            AS `ErfindungsTitel`
, `tbl_erfindung`.`Jahrzahl`         AS `ErfindungsJahrzahl`
, `tbl_erfindung`.`defaultKategorie` AS	`defaultKategorie`
, `tmp_vw_reihenfolge`.`vor`         AS `vorgaenger_URL_Infix`
, `tmp_vw_reihenfolge`.`nach`        AS `nachfolger_URL_Infix`
, `tmp_vw_reihenfolge`.`Kategorie`   AS `KategorieID`
, `tbl_kategorie`.`titel`            AS `KategorieName`
, `tbl_kategorie`.`beschreibung`     AS `KategorieBeschreibung`
, `tbl_autor`.`name` AS `Editor`
FROM `tmp_vw_reihenfolge`
LEFT JOIN `tbl_kategorie` ON `tmp_vw_reihenfolge`.`Kategorie` = `tbl_kategorie`.`ID`
LEFT JOIN `tbl_erfindung` ON `tmp_vw_reihenfolge`.`core`      = `tbl_erfindung`.`IDurl`
LEFT OUTER JOIN `tbl_editor`    ON `tmp_vw_reihenfolge`.`core`      = `tbl_editor`.`IDurl_fk`
LEFT JOIN `tbl_autor`     ON `tbl_editor`.`autor_fk`          = `tbl_autor`.`ID`;


CREATE VIEW `vw_erfindungsbild` AS
SELECT
  `tbl_erfindungsbild`.`IDurl_fk` AS `URL_Infix`
, `tbl_bild`.`ID`                 AS `BildID`
, `tbl_bild`.`filename`           AS `Filename`
, `tbl_bild`.`bildlegende`        AS `BildlegendeTitel`
, `tbl_bild`.`alt_text`           AS `alt`
, `tbl_bild`.`bildrechte`         AS `rechte`
, `tbl_erfindungsbild`.`ord`      AS `ord`
FROM `tbl_bild`
JOIN `tbl_erfindungsbild` ON `tbl_erfindungsbild`.`bild_fk` = `tbl_bild`.`ID`;


CREATE VIEW `vw_exponatbilder` AS
SELECT `tbl_exponat`.`id` AS `exponat_ID`, `ord`, `filename`, `bildrechte`, `bildlegende`, `alt_text`, `Exponat_Jahr`, `Exponat_Modell`, `ausgestellt`, `inventarNr`
FROM `tbl_exponatbild`
LEFT JOIN `tbl_exponat` ON `tbl_exponat`.`ID` = `tbl_exponatbild`.`exponat_fk`
LEFT JOIN `tbl_bild`    ON `tbl_bild`.`ID` = `tbl_exponatbild`.`bild_fk`;


-- Testabfragen:

CREATE VIEW `TEST_VIEW_keywordsAbakus` AS
SELECT `keyword` FROM `tbl_keyword` WHERE 'abakus' = `IDurl_fk`;
