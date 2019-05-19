-- 2019-05-18 phi
-- DATENBANK zu SMOCH

-- --------------------------------------------------------------
-- db
-- --------------------------------------------------------------
DROP   DATABASE IF EXISTS `smoch`  ;
CREATE DATABASE           `smoch`  ;
ALTER  DATABASE           `smoch`
  DEFAULT CHARACTER SET 'utf8'
	DEFAULT COLLATE 'utf8_general_ci';
USE                       `smoch`  ;

GRANT SELECT ON smoch.* TO smoch@'%' IDENTIFIED BY '123';

-- --------------------------------------------------------------
-- tables
-- --------------------------------------------------------------
CREATE TABLE `tbl_erfindung` (
  `IDurl`         varchar(200) NOT NULL PRIMARY KEY
                                        COMMENT 'withount *.php without *http://" without path. Wird ebenfalls verwendet für das Freitext-Prefix'
, `Titel`         varchar(30)  NOT NULL COMMENT 'visible title'
, `Jahrzahl`      varchar(20)  NOT NULL COMMENT 'sometimes as text (eg. 900 - 1200)'
);

INSERT INTO `tbl_erfindung`
(`IDurl`,          `Titel`                    , `Jahrzahl`           ) VALUES
('abakus'        , 'Abakus'                   , 'ca. 2500 v. Chr.'   ),
('rechenschieber', 'Rechenschieber'           ,     '1632'           ),
('pascaline'     , 'Pascaline'                ,     '1642'           ),

('amphore'       , 'Amphore'                  ,  'ca. 500 v. Chr.'   ),
('diskette'      , 'Diskette'                 ,     '1949??'         ),
('cd'            , 'CD - ROM'                 ,     '1979??'         ),

('keilschrift'   , 'Babylonische Keilschrift' , 'ca. 3000 v. Chr.???'),
('morsegeraet'   , 'Morsegerät/Relaisstation' , 'ca. 17?? '          );



-- --------------------------------------------------------------
CREATE TABLE `tbl_kategorie` (
  `ID` int PRIMARY KEY
, `titel` text
, `beschreibung` text
);

INSERT INTO `tbl_kategorie`
(`ID`, `titel`        , `beschreibung`                       )   VALUES
( 1  , 'Rechnen'      , 'Berechnungen aller Art'             ),
( 2  , 'Speichern'    , 'Speichern von Materialien und Daten'),
( 3  , 'Kommunizieren', 'Wie menschen Information übertragen');


-- --------------------------------------------------------------
CREATE TABLE `tbl_reihenfolge` (
 `IDurl`         varchar(200) NOT NULL PRIMARY KEY
,`kategorie_fk`  int
,`ordinal`       int
, FOREIGN KEY (`IDurl`       ) REFERENCES `tbl_erfindung` (`IDurl`)
, FOREIGN KEY (`kategorie_fk`) REFERENCES `tbl_kategorie` (`ID`   )
);

INSERT INTO `tbl_reihenfolge`
(`IDurl`         , `kategorie_fk`, `ordinal`) VALUES
('abakus'        ,   1           ,   1      ),
('rechenschieber',   1           ,   2      ),
('pascaline'     ,   1           ,   3      ),

('amphore'       ,   2           ,   1      ),
('diskette'      ,   2           ,   2      ),
('cd'            ,   2           ,   3      ),

('keilschrift'   ,   3           ,   1      ),
('morsegeraet'   ,   3           ,   2      );




-- --------------------------------------------------------------
CREATE TABLE `tbl_image` (
  `ID`           int PRIMARY KEY AUTO_INCREMENT
, `filename`     varchar(200)     COMMENT 'Jahr des ältesten Ausstellungsobjekts'
, `bildlegende`  text             COMMENT 'Auch als "title" zu verwenden beim <img>-Tag.'
, `alt_text`     text
);

INSERT INTO `tbl_image`
(`ID`, `filename`              , `bildlegende`                     , `alt_text`                 ) VALUES
(  1 , 'abakus.png'            , 'Chinesischen Abakus'             , 'Zählrahmen aus Holz'      ),
(  2 , 'rechenschieber.png'    , 'Rechenschieber'                  , 'Rechenschieber'           ),
(  3 , 'pascaline'             , 'Pascaline'                       , 'Pascaline'                ),
(  4 , 'amphore_etruskisch.png', 'Etruskische Amphore: Nachbildung', 'Amphore aus Ton'          ),
(  5 , 'amphore_3d_druck.png'  , 'Amphore aus dem 3D-Drucker'      , 'Amphore aus Plastik'      ),
(  6 , 'amphoren_wiki.png'     , 'Amphoren antik (Bild Wikimedia)' , 'Antike Amphoren Wikimedia'),
(  7 , 'diskette35.png'        , 'Diskette 3.5 Zoll'               , 'Diskette 3.5 Zoll'        ),
(  8 , 'cd.png'                , 'Compct Disk (CD)'                , 'Compact Disk'             ),
(  9 , 'keilschrift.png'       , 'Keilschrift selbst gerannt'      , 'Keilschrift auf Ton'      );

-- Mehrere Exponate zu einem Objekt sind möglich.
-- Es gibt auch Exponate, welche nur ein Bild haben.
-- Wenn kein Exponat vorhanden, dann soll hier auch kein Eintrag erscheinen.
-- Exponate sind effektiv ausgestellt, oder haben ein Foto im Schaukasten.
-- Im Gegensatz zu Bildern, die nur auf der Webseite vorkommen.
CREATE TABLE `tbl_exponat` (
  `ID`             int PRIMARY KEY AUTO_INCREMENT
, `IDurl_fk`       varchar(200) 
, `Exponat_Jahr`   varchar(20)   COMMENT 'Jahr des aktuellen Ausstellungsobjekts'
, `Exponat_Modell` text          COMMENT 'Modell/Marke Ausstellungsobjekts'
, `ausgestellt`    boolean       COMMENT 'Im Museum Vorhanden (bei TRUE, wird ein QR-Code generiert)'
, `inventarNr`     varchar(50)   COMMENT 'Wie wird das Exponat gefunden, sortiert, ... Die Inventarnummer beginnt mit S: speichern, K: kommunizieren bzw. R: rechnen'
, `Exponat_img_fk` int           NULL
, FOREIGN KEY (`IDurl_fk`      ) REFERENCES `tbl_erfindung` (`IDurl`)
, FOREIGN KEY (`Exponat_img_fk`) REFERENCES `tbl_image`  (`ID`   )
);

INSERT INTO `tbl_exponat`
(`IDurl_fk`      , `Exponat_Jahr`    , `Exponat_Modell`                                , `inventarNr`, `ausgestellt`, `Exponat_img_fk`) VALUES
('abakus'        , 'ca. 1960'        , 'Chinesischen Abakus'                           , 'R_1_a'     , true         ,  1              ),
('rechenschieber', 'ca. 1970'        , 'Aristo 75 ...??'                               , 'R_2_r'     , true         ,  2              ),
('pascaline'     , 'ca. 16..'        , 'Exponat steht im Deutschen Museum München'     ,  NULL       , false        ,  3              ),
('amphore'       , '2017'            , 'Nachbildung aus dem 3D-Drucker'                , 'S_1_a'     , true         ,  4              ),
('amphore'       , '2016'            , 'Nachbildung Etruskischer Amphore aus Popolonio', 'S_2_a'     , true         ,  5              ),
('amphore'       , '2016'            , 'Antike Amphoren (Bild Wikimedia)'              ,  NULL       , false        ,  6              ),
('diskette'      , '1987'            , '3.5 Zoll Diskette'                             , 'S_3_d'     , true         ,  7              ),
('cd'            , '2018'            , 'Vince Ebers Ur-Knaller'                        , 'S_4_c'     , true         ,  8              ),
('keilschrift'   , '2019'            , 'Tontäfelchen selbst gebrannt ;-)'              , 'K_1_k'     , true         ,  9              ),
('morsegeraet'   , 'ca ????'         , 'nur bild wikimedia'                            , NULL        , false        ,  NULL           );


-- Mehrere Exponate zu einem Objekt sind möglich.
-- Es gibt auch Exponate, welche nur ein Bild haben.
-- Wenn kein Exponat vorhanden, dann soll hier auch kein Eintrag erscheinen.
CREATE TABLE `tbl_keyword` (
  `ID`        int PRIMARY KEY AUTO_INCREMENT
, `IDurl_fk`  varchar(200) 
, `keyword`   text
, FOREIGN KEY (`IDurl_fk`  ) REFERENCES `tbl_erfindung` (`IDurl`)
);

INSERT INTO `tbl_keyword`
(`IDurl_fk`      , `keyword`             ) VALUES
('abakus'        , 'Abakus'              ),
('abakus'        , 'Zählrahmen'          ),
('abakus'        , 'Rechner'             ),
('abakus'        , 'Kugelzählrahmen'     ),
('abakus'        , 'Kugel'               ),
('abakus'        , 'Allee'               ),
('rechenschieber', 'Logarithmus'         ),
('rechenschieber', 'Rechenrechteck'      ),
('pascaline'     , 'Blaise Pascal'       ),
('pascaline'     , 'Pascal'              ),
('pascaline'     , 'Pascaline'           ),
('pascaline'     , 'Mechanischer Rechner'),
('amphore'       , 'Amphore'             ),
('amphore'       , 'Amphora'             ),
('amphore'       , 'Gefäß'               ),
('diskette'      , 'Diskette'            ),
('diskette'      , 'Magnetspeicher'      ),
('diskette'      , 'Wechseldatenträger'  ),
('cd'            , 'cd'                  ),
('cd'            , 'Compact Disk'        ),
('cd'            , 'Audio'               );


CREATE TABLE `tbl_autor` (
  `ID`        int PRIMARY KEY AUTO_INCREMENT
, `name`     text
);

INSERT INTO `tbl_autor`
(`name`) VALUES
('philipp gressly freimann (phi@smoch.ch)');

CREATE TABLE `tbl_editor` (
  `ID`        int PRIMARY KEY AUTO_INCREMENT
, `IDurl_fk`  varchar(200) 
, `autor_fk`  int
, FOREIGN KEY (`IDurl_fk`  ) REFERENCES `tbl_erfindung` (`IDurl`)
, FOREIGN KEY (`autor_fk`  ) REFERENCES `tbl_autor`     (`ID`   )
);

INSERT INTO `tbl_editor`
(`IDurl_fk`      , `autor_fk`) VALUES
('abakus'        , 1),
('rechenschieber', 1),
('pascaline'     , 1),

('amphore'       , 1),
('diskette'      , 1),
('cd'            , 1),
('keilschrift'   , 1),
('morsegeraet'   , 1);


-- --------------------------------------------------------
-- views
-- --------------------------------------------------------
-- Exponate, wo ein Kärtchen dazu erstellt werden soll.
-- Es existiert entweder ein Exponat, oder ein Photo ist im Schaukasten.
CREATE VIEW `vw_exponat` AS
SELECT     `tbl_erfindung`  . `IDurl`          AS `core`
,          `tbl_erfindung`  . `Titel`          AS `CoreTitel`
,			     `tbl_erfindung`  . `Jahrzahl`       AS `JahrErfindung`
,			     `tbl_exponat`    . `Exponat_Jahr`   AS `JahrExponat`
,			     `tbl_exponat`    . `Exponat_Modell` AS `ExponatTitel`
,			     `tbl_exponat`    . `ausgestellt`    AS `ausgestellt`
,          `tbl_image`      . `filename`       AS `IMG_Filename`
FROM       `tbl_exponat` 
LEFT  JOIN `tbl_erfindung` ON `tbl_exponat`.`IDurl_fk`       = `tbl_erfindung`.`IDurl`
INNER JOIN `tbl_image`     ON `tbl_exponat`.`Exponat_img_fk` = `tbl_image` .`ID`;


			 
CREATE VIEW `vw_nachfolger` AS
SELECT `tbl_1`.`IDurl` AS `core`, `tbl_2`.`IDurl` AS `core_nachfolger`
FROM `tbl_reihenfolge` AS `tbl_1`
LEFT JOIN `tbl_reihenfolge` AS `tbl_2`
ON (`tbl_1`.`kategorie_fk` = `tbl_2`.`kategorie_fk`) AND
   (`tbl_1`.`ordinal`      = `tbl_2`.`ordinal` - 1 );

CREATE VIEW `vw_vorgaenger` AS
SELECT `tbl_1`.`IDurl` AS `core`
,      `tbl_2`.`IDurl` AS `core_vorgaenger`
FROM `tbl_reihenfolge` AS `tbl_1`
LEFT JOIN `tbl_reihenfolge` AS `tbl_2`
ON (`tbl_1`.`kategorie_fk` = `tbl_2`.`kategorie_fk`) AND
   (`tbl_1`.`ordinal`      = `tbl_2`.`ordinal` + 1 );

CREATE VIEW `vw_reihenfolge` AS
SELECT `core_vorgaenger` AS `vor`
,      `vw_vorgaenger`.`core` AS `core`
,			 `core_nachfolger` AS `nach`
FROM `vw_vorgaenger`, `vw_nachfolger`
WHERE `vw_vorgaenger`.`core` = `vw_nachfolger`.`core`;


-- Im Gegensatz zum Exponat-View (wo die Exonate erscheinen), sind hier
-- die Webseiten aufgelistet.
CREATE VIEW `vw_webseite` AS
SELECT `tbl_erfindung`.`IDurl`    AS `core`
,      `tbl_erfindung`.`Titel`    AS `Titel`
,			 `tbl_erfindung`.`Jahrzahl` AS `JahrErfindung`
,			 `tbl_autor`    .`name`     AS `Autor`
,      `vw_reihenfolge`.`vor`     AS `vorgaenger`
,      `vw_reihenfolge`.`nach`    AS `nachfolger`
,      `tbl_kategorie`.`titel`    AS `Kategorie`
,      `tbl_kategorie`.`ID`       AS `KategorieID`
FROM `tbl_erfindung`
LEFT       JOIN `tbl_editor`      ON `tbl_editor`     .`IDurl_fk`     = `tbl_erfindung`.`IDurl`
LEFT       JOIN `tbl_autor`       ON `tbl_autor`      .`ID`           = `tbl_editor`   .`autor_fk`
LEFT OUTER JOIN `vw_reihenfolge`  ON `tbl_erfindung`  .`IDurl`        = `vw_reihenfolge`.`core`
           JOIN `tbl_reihenfolge` ON `tbl_reihenfolge`.`IDurl`        = `tbl_erfindung`.`IDurl`
           JOIN `tbl_kategorie`   ON `tbl_reihenfolge`.`kategorie_fk` = `tbl_kategorie`.`ID`;


