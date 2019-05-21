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

-- -----------------------------------------------------------
-- Erfindungen
--
CREATE TABLE `tbl_erfindung` (
  `IDurl`         varchar(200) NOT NULL PRIMARY KEY
                                        COMMENT 'withount *.php without *http://" without path. Wird ebenfalls verwendet für das Freitext-Prefix'
, `Titel`         varchar(30)  NOT NULL COMMENT 'visible title'
, `Jahrzahl`      varchar(20)  NOT NULL COMMENT 'sometimes as text (eg. 900 - 1200)'
);

INSERT INTO `tbl_erfindung`
(`IDurl`,          `Titel`                    , `Jahrzahl`           ) VALUES
-- rechnen
('abakus'        , 'Abakus'                   , 'ca. 2500 v. Chr.'   ),
('rechenschieber', 'Rechenschieber'           ,     '1632'           ),
('pascaline'     , 'Pascaline'                ,     '1642'           ),
('computer'      , 'Computer'                 ,     '1940'           ),
('smartphone'    , 'Smartphone'               ,     'ca 1990'        ),

-- speichern
('amphore'       , 'Amphore'                  ,  'ca. 500 v. Chr.'   ),
('diskette'      , 'Diskette'                 ,     '1949??'         ),
('cd'            , 'CD - ROM'                 ,     '1979??'         ),

-- kommunizieren
('keilschrift'   , 'Babylonische Keilschrift' , 'ca. 3000 v. Chr.???'),
('morsegeraet'   , 'Morsegerät/Relaisstation' , 'ca. 17?? '          );



-- --------------------------------------------------------------
-- Reihnfolge der Erfindungen.
CREATE TABLE `tbl_reihenfolge` (
 `IDurl`         varchar(200) NOT NULL PRIMARY KEY
,`kategorie_fk`  int
,`ord`       int
, FOREIGN KEY (`IDurl`       ) REFERENCES `tbl_erfindung` (`IDurl`)
, FOREIGN KEY (`kategorie_fk`) REFERENCES `tbl_kategorie` (`ID`   )
);

INSERT INTO `tbl_reihenfolge`
(`IDurl`         , `kategorie_fk`, `ord`    ) VALUES
-- rechnen
('abakus'        ,   1           ,   1      ),
('rechenschieber',   1           ,   2      ),
('pascaline'     ,   1           ,   3      ),
('computer'      ,   1           ,   4      ),
('smartphone'    ,   1           ,   5      ),

-- speichern
('amphore'       ,   2           ,   1      ),
('diskette'      ,   2           ,   2      ),
('cd'            ,   2           ,   3      ),

-- kommunizieren
('keilschrift'   ,   3           ,   1      ),
('morsegeraet'   ,   3           ,   2      );


-- Mehrere Exponate zu einem Objekt sind möglich.
-- Es gibt auch Exponate, welche nur ein Bild haben.
-- Wenn kein Exponat vorhanden, dann soll hier auch kein Eintrag erscheinen.
-- Exponate, die temporär weg sind (in Revision ...) sollten bei "ausgestellt" «false» angeben.
-- Exponate sind effektiv ausgestellt, oder haben ein Foto im Schaukasten.
-- Im Gegensatz zu Bildern, die nur auf der Webseite vorkommen.
CREATE TABLE `tbl_exponat` (
  `ID`             int PRIMARY KEY AUTO_INCREMENT
, `Exponat_Jahr`   varchar(20)   COMMENT 'Jahr des aktuellen Ausstellungsobjekts'
, `Exponat_Modell` text          COMMENT 'Modell/Marke Ausstellungsobjekts'
, `ausgestellt`    boolean       COMMENT 'Im Museum Vorhanden (bei TRUE, wird ein QR-Code generiert)'
, `inventarNr`     varchar(50)   COMMENT 'Wie wird das Exponat gefunden, sortiert, ... Die Inventarnummer beginnt mit S: speichern, K: kommunizieren bzw. R: rechnen'
);

INSERT INTO `tbl_exponat`
(`ID`, `Exponat_Jahr` , `Exponat_Modell`                                     , `inventarNr`, `ausgestellt`) VALUES
(  1 , 'ca. 1960'     , 'Chinesischen Abakus'                                , 'R_001_a'     , true         ),
(  2 , 'ca. 1970'     , 'Aristo 75 ...??'                                    , 'R_002_r'     , true         ),
(  3 , 'ca 2004?'     , 'HTC Desire'                                         , 'R_003_s'     , true         ),
(  4 , '2016'         , 'Nachbildung Etruskischer Amphore aus Popolonio'     , 'S_002_a'     , true         ),
(  5 , '2017'         , 'Nachbildung aus dem 3D-Drucker'                     , 'S_001_a'     , false        ),
(  6 , '1997'         , '3.5 Zoll Boot-Diskette S.U.s.E. Linux Kernel 2.0.3x', 'S_003_d'     , true         ),
(  7 , '2018'         , 'Vince Ebers Ur-Knaller'                             , 'S_004_c'     , true         ),
(  8 , '2019'         , 'Tontäfelchen selbst gebrannt ;-)'                   , 'K_001_k'     , false        );


-- --------------------------------------------------------------
-- Fotos in der Datenbank. 
CREATE TABLE `tbl_image` (
  `ID`           int PRIMARY KEY AUTO_INCREMENT
, `filename`     varchar(200)     COMMENT 'Bild Filename (inkl. "*.png" oder "*.jpg" ...)'
, `bildlegende`  text             COMMENT 'Auch als "title" zu verwenden beim <img>-Tag.'
, `bildrechte`   text             COMMENT 'Wer hat das Bild gemacht? Ist es frei? wikimedia?...'
, `alt_text`     text
);

INSERT INTO `tbl_image`
(`ID`, `filename`                       , `bildlegende`                     , `bildrechte`   , `alt_text`									) VALUES
(  1 , 'abakus.png'                     , 'Chinesischen Abakus'             , 'phi@smoch.ch' , 'Zählrahmen aus Holz'      ),
(  2 , 'rechenschieber.png'             , 'Rechenschieber'                  , 'phi@smoch.ch' , 'Rechenschieber'           ),
(  3 , 'pascaline.jpg'                  , 'Pascaline'                       , 'phi@smoch.ch' , 'Pascaline'                ) ,
(  4 , 'smartphone_htc_desire.jpg'      , 'Smartphone HTC Desire' , 'phi@smoch.ch', 'Smartphone'),

(  5 , 'amphore_etruskisch.png'         , 'Etruskische Amphore: Nachbildung aus Popolonio', 'phi@smoch.ch' , 'Amphore aus Ton'          ),
(  6 , 'amphore_3d_druck.png'           , 'Amphore aus dem 3D-Drucker'      , 'phi@smoch.ch' , 'Amphore aus Plastik'      ),
(  7 , 'amphoren_wiki.png'              , 'Amphoren antik (Bild Wikimedia)' , 'wikimedia.org', 'Antike Amphoren Wikimedia'),
(  8 , 'diskette35.png'                 , 'Diskette 3.5 Zoll'               , 'phi@smoch.ch' , 'Diskette 3.5 Zoll'        ),
(  9 , 'cd-ubuntu.png'                  , 'Compct Disk (CD)'                , 'phi@smoch.ch' , 'Compact Disk (Daten)'     ),
( 10 , 'cd-vince.png'                   , 'Compct Disk (CD)'                , 'phi@smoch.ch' , 'Audio CD'                 ),
( 11 , 'keilschrift.png'                , 'Keilschrift selbst gebannt'      , 'phi@smoch.ch' , 'Keilschrift auf Ton'      ),
( 12 , 'bitRelaisNachbau_schema.png'    , 'Schema, um ein Bit mit Relais zu speichern', 'phi@smoch.ch', 'Schema (elektronisch), um ein Bit mittels Relais zu speichern'),
( 13 , 'bitTransistorNachbau_schema.png', 'Schema, um ein Bit mittels Transistoren zu speichern', 'phi@smoch.ch', 'Schema (elektronisch), um ein Bit mittels Relais zu speichern'),
( 14 , 'differenzenmaschine.png'        , 'Ch. Babbage: Differenzenmaschine im Da Vinci Museum in Mailand', 'phi@smoch.ch', 'Foto: Differenzenmaschine'),
( 15 , 'halbleiter.png'                 , 'Silizium, eines der häufigsten Elemente: Daraus werden die meisten Halbleiter gebaut.', 'phi@smoch.ch', 'Siliziumkristall'),
( 16 , 'notRelaisNachbau_schema.png'    , 'Schema, für das NOT-Gatter mit Relais', 'phi@smoch.ch', 'Schema (elektronisch), für ein NOT-Gatter mittels Relais'),
( 17 , 'notTransistorNachbau_schema.png', 'Schema, um ein NOT-Gatter mit Transistoren zu bauen', 'phi@smoch.ch', 'Schema (elektronisch), um ein NOT-Gatter mittels Tranistoren zu bauen.'),
( 18 , 'volladdiererNachbau_schema.png', 'Schema, um einen Volladdierer zu bauen', 'phi@smoch.ch', 'Schema, um einen Volladdierer zu bauen.'),
( 19 , 'wafer.png'                     , 'Wafer'                           , 'phi@smoch.ch', 'Waferplatte'                ),
( 20 , 'wafer_mikroskop.jpg'           , 'Wafer Mikroskopausschnitt'       , 'phi@smoch.ch', 'Mikroskopier eines Wafers (Ausschnitt)' ),
( 21 , 'zahlenschieber.png'            , 'Zahlenschieber Addimult'         , 'phi@smoch.ch', 'Zahlenschieber Addimult'    ),
( 22 , 'zuse_z3_a.jpg'                 , 'Zuse Z3 Deutsches Museum'        , 'phi@smoch.ch', 'Zuse Z3'                    ),
( 23 , 'zuse_z3_b.jpg'                 , 'Zuse Z3 Deutsches Museum'        , 'phi@smoch.ch', 'Zuse Z3'                    ),
( 24 , 'zuse_z4.jpg'                   , 'Zuse Z4 Deutsches Museum'        , 'phi@smoch.ch', 'Zuse Z4'                    ),
( 25 , 'zuse_z4_eingabetastatur.jpg'   , 'Zuse Z4 Deutsches Museum'        , 'phi@smoch.ch', 'Zuse Z4'                    );



-- -----------------------------------------------------
-- Erfindungsbilder sind die Bilder auf der Webseite.
-- Ein Bild kann theoretisch zu mehreren Erfindungen gehören, wie z.B. das Smartphone.


CREATE TABLE `tbl_erfindungsbild` (
  `IDurl_fk`            varchar(200)
, `ord`                 int             COMMENT 'Bildreihenfolge auf der Webseite'
, `img_fk`              int
, PRIMARY KEY (IDurl_fk, `ord`)
, FOREIGN KEY (`IDurl_fk`) REFERENCES `tbl_erfindung` (`IDurl`)
, FOREIGN KEY (`img_fk`  ) REFERENCES `tbl_image`     (`ID`   )
);


INSERT INTO `tbl_erfindungsbild`
(`IDurl_fk`      , `ord`, `img_fk`) VALUES
('abakus'        ,  1   ,   1     ),  -- abakus
('rechenschieber',  1   ,   2     ),  -- rechenschieber
('pascaline'     ,  1   ,   3     ),  -- foto pascaline deutsches museum
('smartphone'    ,  1   ,   4     ),  -- htc desire smartphone
('amphore'       ,  1   ,   5     ),  -- Amphora Etruskisch Popolonio
('amphore'       ,  2   ,   6     ),  -- 3D-Drucker Amhpore
('amphore'       ,  3   ,   7     ),  -- Bild Wikipedia von Amphoren
('diskette'      ,  1   ,   8     ),  -- Diskette S.U.s.E
('cd'            ,  1   ,   9     ),  -- Ubuntu CD
('cd'            ,  2   ,  10     ),  -- Vince Eberts CD "ur Knaller"
('keilschrift'   ,  1   ,  11     );  -- bild von eigenen schriftZeichnen


-- ---------------------------------------------------
-- Welche Bilder gehören zu welchen Exponaten
-- Theoretisch wären mehrere Bilder zum selben Exponat möglich.
CREATE TABLE `tbl_exponatbild` (
  `exponat_fk`  int
, `image_fk`    int
, FOREIGN KEY (`exponat_fk`) REFERENCES `tbl_exponat` (`ID`)
, FOREIGN KEY (`image_fk`  ) REFERENCES `tbl_image`   (`ID`)
);


INSERT INTO `tbl_exponatbild`
( `exponat_fk`, `image_fk` ) VALUES
(  1          ,   1        ), -- abakus
(  2          ,   2        ), -- rechenschieber
(  3          ,   4        ), -- smartphone HTC Desire
(  4          ,   5        ), -- amphore Etruskisch 
(  5          ,   6        ), -- amphore 3D Druck
(  6          ,   8        ), -- 3.5 Zoll Diskette
(  7          ,  10        ), -- Ur Knaller
(  8          ,  11        ); -- Tontäfelchen	




-- ---------------------------------------------------
-- Welche Exponate gehören zu welchen Erfindungen.
-- Gewisse Exponate können zu mehreren Erfindungen gehören (Smartphone).
CREATE TABLE `tbl_erfindungsexponat` (
  `IDurl_fk`    varchar(200)
, `exponat_fk`  int
, `ord`         int  -- Reihenfolge
, FOREIGN KEY (`IDurl_fk`  ) REFERENCES `tbl_erfindung` (`IDurl`)
, FOREIGN KEY (`exponat_fk`) REFERENCES `tbl_exponat`   (`ID`   )
);

INSERT INTO `tbl_erfindungsexponat`
(`IDurl_fk`      , `exponat_fk` , `ord`) VALUES
('abakus'        ,  1           ,  1   ),
('rechenschieber',  2           ,  1   ),
('smartphone'    ,  3           ,  1   ),
('amphore'       ,  4           ,  1   ),
('amphore'       ,  5           ,  2   ),
('diskette'      ,  6           ,  1   ),
('cd'            ,  7           ,  1   ),
('keilschrift'   ,  8           ,  1   );



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
-- Es handelt sich nicht um die Erfindug, mehr jedoch um das aktuell ausgestellte Objekt.
-- CREATE VIEW `vw_exponat` AS
-- SELECT     `tbl_erfindung`  . `IDurl`          AS `core`
-- ,          `tbl_erfindung`  . `Titel`          AS `CoreTitel`
-- ,			     `tbl_erfindung`  . `Jahrzahl`       AS `JahrErfindung`
-- ,			     `tbl_exponat`    . `Exponat_Jahr`   AS `JahrExponat`
-- ,			     `tbl_exponat`    . `Exponat_Modell` AS `ExponatTitel`
-- ,			     `tbl_exponat`    . `ausgestellt`    AS `ausgestellt`
-- ,          `tbl_exponat`    . `inventarNr`     AS `InventarNummer`
-- ,          `tbl_image`      . `filename`       AS `IMG_Filename`
-- FROM       `tbl_exponat` 
-- LEFT  JOIN `tbl_erfindung` ON `tbl_exponat`.`IDurl_fk`       = `tbl_erfindung`.`IDurl`
-- INNER JOIN `tbl_image`     ON `tbl_exponat`.`Exponat_img_fk` = `tbl_image` .`ID`
-- WHERE `ausgestellt` > 0;

CREATE VIEW `vw_exponat` AS
SELECT `tbl_erfindung`.`IDurl`          AS `core`
,      `tbl_erfindung`.`Titel`          AS `Erfindung`
,      `tbl_erfindung`.`Jahrzahl`       AS `Erfindungsjahr`
,      `tbl_exponat`  .`Exponat_Jahr`   AS `Modelljahr`
,      `tbl_exponat`  .`Exponat_Modell` AS `Modell`
,      `tbl_exponat`  .`inventarNr`     AS `InvetarNummer`
,      `tbl_exponat`  .`ausgestellt`    AS `ausgestelltBOOL`
FROM `tbl_exponat`
INNER  JOIN `tbl_erfindungsexponat` ON `tbl_exponat`  .`ID`    = `tbl_erfindungsexponat`.`exponat_fk`
LEFT JOIN `tbl_erfindung`         ON `tbl_erfindung`.`IDurl` = `tbl_erfindungsexponat`.`IDurl_fk`;

-- Synthetische Reihenfolge (nach tbl_reihenfolge)
CREATE VIEW `tmp_vw_nachfolger` AS
SELECT `tbl_1`.`IDurl` AS `core`,
       `tbl_2`.`IDurl` AS `core_nachfolger`
FROM `tbl_reihenfolge` AS `tbl_1`
LEFT JOIN `tbl_reihenfolge` AS `tbl_2`
ON (`tbl_1`.`kategorie_fk` = `tbl_2`.`kategorie_fk`) AND
   (`tbl_1`.`ord`      = `tbl_2`.`ord` - 1 );

CREATE VIEW `tmp_vw_vorgaenger` AS
SELECT `tbl_1`.`IDurl` AS `core`
,      `tbl_2`.`IDurl` AS `core_vorgaenger`
FROM `tbl_reihenfolge` AS `tbl_1`
LEFT JOIN `tbl_reihenfolge` AS `tbl_2`
ON (`tbl_1`.`kategorie_fk` = `tbl_2`.`kategorie_fk`) AND
   (`tbl_1`.`ord`      = `tbl_2`.`ord` + 1 );

CREATE VIEW `tmp_vw_reihenfolge` AS
SELECT `core_vorgaenger`            AS `vor`
,      `tmp_vw_vorgaenger`.`core`   AS `core`
,			 `core_nachfolger`            AS `nach`
FROM `tmp_vw_vorgaenger`, `tmp_vw_nachfolger`
WHERE `tmp_vw_vorgaenger`.`core` = `tmp_vw_nachfolger`.`core`;


-- Im Gegensatz zum Exponat-View (wo die Exonate erscheinen), sind hier
-- die Webseiten aufgelistet.
CREATE VIEW `vw_webseite` AS
SELECT `tbl_erfindung`     .`IDurl`    AS `core`
,      `tbl_erfindung`     .`Titel`    AS `Titel`
,			 `tbl_erfindung`     .`Jahrzahl` AS `JahrErfindung`
,			 `tbl_autor`         .`name`     AS `Autor`
,      `tmp_vw_reihenfolge`.`vor`      AS `vorgaenger`
,      `tmp_vw_reihenfolge`.`nach`     AS `nachfolger`
,      `tbl_kategorie`     .`titel`    AS `Kategorie`
,      `tbl_kategorie`     .`ID`       AS `KategorieID`
FROM `tbl_erfindung`
LEFT       JOIN `tbl_editor`         ON `tbl_editor`     .`IDurl_fk`     = `tbl_erfindung`     .`IDurl`
LEFT       JOIN `tbl_autor`          ON `tbl_autor`      .`ID`           = `tbl_editor`        .`autor_fk`
LEFT OUTER JOIN `tmp_vw_reihenfolge` ON `tbl_erfindung`  .`IDurl`        = `tmp_vw_reihenfolge`.`core`
           JOIN `tbl_reihenfolge`    ON `tbl_reihenfolge`.`IDurl`        = `tbl_erfindung`     .`IDurl`
           JOIN `tbl_kategorie`      ON `tbl_reihenfolge`.`kategorie_fk` = `tbl_kategorie`     .`ID`;
