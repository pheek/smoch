-- 2019-05-18 phi
-- DATENBANK zu SMOCH

DROP   DATABASE IF EXISTS `smoch`;
CREATE DATABASE           `smoch`;
ALTER  DATABASE           `smoch`
  DEFAULT CHARACTER SET 'utf8'
	DEFAULT COLLATE 'utf8_general_ci';


--
-- Table structure for table `content`
--

CREATE TABLE `tbl_objekt` (
  `IDurl`         varchar(200) NOT NULL PRIMARY KEY
                                        COMMENT 'withount *.php without *http://" without path. Wird ebenfalls verwendet für das Freitext-Prefix'
, `Titel`         varchar(30)  NOT NULL COMMENT 'visible title'
, `Jahrzahl`      varchar(20)  NOT NULL COMMENT 'sometimes as text (eg. 900 - 1200)'
, `Autor`         text         NOT NULL
, `Descriptions`  text         NOT NULL
);

INSERT INTO `tbl_objekt``
(`IDurl`,          `Titel`         , `Jahrzahl`        , `Autor`                   , `Descriptions`                       ) VALUES
('abakus'        , 'Abakus'        , 'ca. 2500 v. Chr.', 'Philipp Gressly Freimann', 'Die Geschichte des Abakus'          ),
('rechenschieber', 'Rechenschieber',     '1632'        , 'Philipp Gressly Freimann', 'Die Geschichte des Rechenschiebers' ),
('pascaline'     , 'Pascaline'     ,     '1642'        , 'Philipp Gressly Freimann', 'Mechanische Rechenmaschine'         ),

('amphore'       , 'Amphore'       ,  'ca. 500 v. Chr.', 'Philipp Gressly Freimann', 'Die Geschichte der Amphore'         ),
('kernspeicher'  , 'Kernspeicher'  ,     '1949'        , 'Philipp Gressly Freimann', 'Die Geschichte des Kernspeichers'   ),
('cd'            , 'CD - ROM'      ,     '1979'        , 'Philipp Gressly Freimann', 'Die Geschichte der CD-ROM'          );


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



CREATE TABLE `tbl_reihenfolge` (
 `IDurl`         varchar(200) NOT NULL PRIMARY KEY
,`kategorie_fk`  int
,`ordinal`       int
, FOREIGN KEY (`IDurl`       ) REFERENCES `tbl_exponat` (`IDurl`)
, FOREIGN KEY (`kategorie_fk`) REFERENCES `tbl_kategorie` (`ID`)
);




INSERT INTO `tbl_reihenfolge`
(`IDurl`         , `kategorie_fk`, `ordinal`) VALUES
('abakus'        ,   1           ,   1      ),
('rechenschieber',   1           ,   2      ),
('pascaline'     ,   1           ,   3      ),

('amphore'       ,   2           ,   1      ),
('kernspeicher'  ,   2           ,   2      ),
('cd'            ,   2           ,   3      );


CREATE TABLE `tbl_image` (
  `ID`           int PRIMARY KEY AUTO_INCREMENT
, `IDurl_fk`     varchar(200)
, `ordinal`      int              COMMENT 'Das vievielte Bild zum Exopnat?'
, `filename`     varchar(200)     COMMENT 'Jahr des ältesten Ausstellungsobjekts'
, `bildlegende`  text             COMMENT 'Auch als "title" zu verwenden beim <img>-Tag.'
, `alt_text`     text
, FOREIGN KEY (`IDurl_fk`) REFERENCES `tbl_objekt` (`IDurl`)
);


INSERT INTO `tbl_image`
(`IDurl_fk`      , `filename`          , `bildlegende`                   , `alt_text`                  ) VALUES
('abakus'        , 'abakus.png'        , 'Chinesischen Abakus'           , 'Rechenschieber aus Holz'   ),
('rechenschieber', 'rechenschieber.png', 'Logarithmischer Rechenschieber', 'Rechenschieber aus Plastik');

-- Mehrere Exponate zu einem Objekt sind möglich.
-- Es gibt auch Exponate, welche nur ein Bild haben.
-- Wenn kein Exponat vorhanden, dann soll hier auch kein Eintrag erscheinen.
CREATE TABLE `tbl_exponat` (
  `ID`             int PRIMARY KEY AUTO_INCREMENT
, `IDurl_fk`       varchar(200) 
, `Exponat_Jahr`   varchar(20)   COMMENT 'Jahr des ältesten Ausstellungsobjekts'
, `Exponat_Modell` text          COMMENT 'Modell  des ältesten Ausstellungsobjekts'
, `Exponat_img_fk` int           
, FOREIGN KEY (`IDurl_fk`      ) REFERENCES `tbl_objekt` (`IDurl`)
, FOREIGN KEY (`Exponat_img_fk`) REFERENCES `tbl_image`  (`ID`   )
);

INSERT INTO `tbl_exponat`
(`IDurl_fk`      , `Exponat_Jahr`    , `Exponat Modell`                                , `Exponat_img_fk`) VALUES
('abakus'        , 'ca. 1960'        , 'Chinesischen Abakus'                           ,  1),
('rechenschieber', 'ca. 1970'        , 'Aristo ...'                                    ,),
('pascaline'     , 'ca. 16..'        , 'Exponat (photo) im Deutschen Museum München'   ,),

('amphore'       , '2017'            , 'Nachbildung aus dem 3D-Drucker'                ,),
('amphore'       , '2016'            , 'Nachbildung Etruskischer Amphore aus Popolonio',),

('


CREATE TABLE `tbl_keyword` (
  `ID`        int PRIMARY KEY AUTO_INCREMENT
, `IDurl_fk`  varchar(200) 
, `keyword`   text
, FOREIGN KEY (`IDurl_fk`  ) REFERENCES `tbl_objekt` (`IDurl`)
, FOREIGN KEY (`keyword_fk`) REFERENCES `tbl_keyword` (`ID`);
);


INSERT INTO `tbl_keyword`
(`IDurl_fk`, `keyword`) VALUES
('abakus'        , 'Abakus'          ),
('abakus'        , 'Zählrahmen'      ),
('abakus'        , 'Rechner'         ),
('abakus'        , 'Kugelzählrahmen' ),
('abakus'        , 'Kugel'           ),
('abakus'        , 'Allee'           ),
('rechenschieber', 'Logarithmus'     ),
('rechenschieben', 'Rechenrechteck'  );
