-- 2019-05-18 phi
-- DATENBANK zu SMOCH: DOMAIN Tabellen

USE `smoch`;

-- --------------------------------------------------------
CREATE TABLE `tbl_program_parameter` (
  `name`        varchar(20) PRIMARY KEY NOT NULL
, `value`       text
, `description` text
);


INSERT INTO `tbl_program_parameter`
(`name`                , `value`                            , `description`                                      ) VALUES
('isDevelop'           , 'true'                             , 'false = scharf; true=localhost o. ä.'             ),
('browser_path'        , '/'                                , 'url after "host:port" entry on targed host'       ),
('browser_path_develop', '/smoch/'                          , 'same as browser_path, but on development machine.'),
('server_root'         , '/var/www/smoch'                   , 'server root for php includes or file readings.'   ),
('server_root_develop' , '/var/www/html/smoch'              , 'server root on localhost for development'         ),
('erfindungen_pfad'    , 'erfindungen/'                     , 'Wo liegen die Artikel und die bilder?'            ),
('artikel_dir'         , 'artikel/'                         , 'Innerhalb von «erfindungen_pfad»'                 ),
('bilder_dir'          , 'bilder/'                          , 'Innerhalb von «erfindungen_pfad»'                 );

-- --------------------------------------------------------------
CREATE TABLE `tbl_session_variable` (
  `name`        varchar(20) PRIMARY KEY NOT NULL
, `description` text
);


INSERT INTO `tbl_session_variable`
(`name`         , `description`) VALUES
('userID'       , 'Bei Login: ID des aktuellen Users (=Login-Name)'),
('kategorie_id' , 'In welcher Tour befindet sich der User gerade'  );


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
( 3  , 'Kommunizieren', 'Wie Menschen Information übertragen');


-- -----------------------------------------------------------
-- Erfindungen
--
CREATE TABLE `tbl_erfindung` (
  `IDurl`            varchar(200) NOT NULL PRIMARY KEY
                                        COMMENT 'withount *.php without *http://" without path. Wird ebenfalls verwendet für das Freitext-Prefix'
, `Titel`            varchar(30)  NOT NULL COMMENT 'visible title'
, `Jahrzahl`         varchar(20)  NOT NULL COMMENT 'sometimes as text (eg. 900 - 1200)'
, `defaultKategorie` int          NOT NULL COMMENT 'Welche Kategorie ist Standard bei Verwendung mit QR Codes?'
, FOREIGN KEY (`defaultKategorie`) REFERENCES `tbl_kategorie` (`ID`)
);


INSERT INTO `tbl_erfindung`
(`IDurl`,          `Titel`                    , `Jahrzahl`        , `defaultKategorie` ) VALUES
-- rechnen
('abakus'        , 'Abakus'                   , 'ca. 2500 v. Chr.', 1                  ),
('pascaline'     , 'Pascaline'                ,     '1642'        , 1                  ),
('zahlenschieber', 'Addiator'                 , 'ca. 1730'        , 1                  ),
('rechenschieber', 'Rechenschieber'           ,     '1632'        , 1                  ),
('computer'      , 'Computer'                 ,     '1937'        , 1                  ),

-- speichern
('amphore'       , 'Amphore'                  ,  'ca. 500 v. Chr.', 2                  ),
('harddisk'      , 'Harddisk'                 ,     '1956'        , 2                  ),
('diskette'      , 'Diskette'                 ,     '1969'        , 2                  ),
('cd'            , 'CD - ROM'                 ,     '1977'        , 2                  ),

-- kommunizieren
('keilschrift'   , 'Babylonische Keilschrift' , 'ca. 3400 v. Chr.', 3                  ),
('morsetaste'    , 'Morsegerät/Relaisstation' ,     '1833'        , 3                  ),

-- diverse
('smartphone'    , 'Smartphone'               ,     '1994'        , 3                  ),
('chip'          , 'Rechner- / Speicherchip'  , 'ca. 1950'        , 1                  );


-- --------------------------------------------------------------
-- Reihnfolge der Erfindungen.
CREATE TABLE `tbl_reihenfolge` (
 `IDurl_fk`      varchar(200) NOT NULL
,`kategorie_fk`  int
,`ord`       int
, UNIQUE (`IDurl_fk`, `kategorie_fk`)
, UNIQUE (`kategorie_fk`, `ord`)
, FOREIGN KEY (`IDurl_fk`    ) REFERENCES `tbl_erfindung` (`IDurl`) -- Jede Erfindung nur einmal pro Tour
, FOREIGN KEY (`kategorie_fk`) REFERENCES `tbl_kategorie` (`ID`   ) -- Jede `ordnungszahl` nur einmal pro Tour
);


INSERT INTO `tbl_reihenfolge`
(`IDurl_fk`      , `kategorie_fk`, `ord`    ) VALUES

-- rechnen
('abakus'        ,   1           ,   1      ),
('zahlenschieber',   1           ,   2      ),
('rechenschieber',   1           ,   3      ),
('pascaline'     ,   1           ,   4      ),
('computer'      ,   1           ,   5      ),
('chip'          ,   1           ,   6      ),
('smartphone'    ,   1           ,   7      ),

-- speichern
('amphore'       ,   2           ,   1      ),
('chip'          ,   2           ,   2      ),
('harddisk'      ,   2           ,   3      ),
('diskette'      ,   2           ,   4      ),
('cd'            ,   2           ,   5      ),
('smartphone'    ,   2           ,   6      ),

-- kommunizieren
('keilschrift'   ,   3           ,   1      ),
('morsetaste'    ,   3           ,   2      ),
('smartphone'    ,   3           ,   3      );


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
( `ID`, `Exponat_Jahr` , `Exponat_Modell`                                     , `inventarNr`, `ausgestellt`) VALUES
-- rechnen
(1001 , 'ca. 1960'     , 'Chinesischen Abakus'                                , 'R_001_a'     , true       ),
(1002 , 'ca. 1975'     , 'Aristo 75 ...??'                                    , 'R_002_r'     , true       ),
(1003 , 'ca. 1970'     , 'Zahlenschieber Adimult'                             , 'R_003_z'     , true       ),

-- speichern
(2001 , '2016'         , 'Nachbildung Etruskischer Amphore aus Popolonio'     , 'S_001_a'     , true       ),
(2002 , '2019'         , 'Nachbildung aus dem 3D-Drucker'                     , 'S_002_a'     , false      ),
(2003 , '????'         , 'Harddisk offen'                                     , 'S_003_h'     , true       ),
(2004 , '1997'         , '3.5 Zoll Boot-Diskette S.U.s.E. Linux Kernel 2.0.3x', 'S_004_d'     , true       ),
(2005 , '2008'         , 'Ubuntu OS 8.10'                                     , 'S_005_u'     , true       ),
(2006 , '2004'         , 'Vince Ebers Ur-Knaller'                             , 'S_006_c'     , true       ),

-- kommunizieren
(3001 , '2019'         , 'Tontäfelchen selbst gebrannt ;-)'                   , 'K_001_k'     , false      ),

-- diverse
(9001 , 'ca 2004?'     , 'HTC Desire'                                         , 'K_002_s'     , true       );


-- --------------------------------------------------------------
-- Fotos in der Datenbank.
CREATE TABLE `tbl_bild` (
  `ID`           int PRIMARY KEY AUTO_INCREMENT
, `filename`     varchar(200)     COMMENT 'Bild Filename (inkl. "*.png" oder "*.jpg" ...)'
, `bildlegende`  text             COMMENT 'Auch als "title" zu verwenden beim <img>-Tag.'
, `bildrechte`   text             COMMENT 'Wer hat das Bild gemacht? Ist es frei? wikimedia?...'
, `alt_text`     text
);


INSERT INTO `tbl_bild`
(`ID`   , `filename`                       , `bildrechte`   , `bildlegende`                     , `alt_text`									) VALUES
-- RECHNEN
(  1001 , 'abakus.png'                     , 'phi@smoch.ch' , 'Chinesischen Abakus'             , 'Zählrahmen aus Holz'      ),
(  1002 , 'pascaline.jpg'                  , 'phi@smoch.ch' , 'Pascaline'                       , 'Pascaline'                ) ,
(  1003 , 'zahlenschieber.png'             , 'phi@smoch.ch' , 'Zahlenschieber Addimult'         , 'Zahlenschieber Addimult'   ),
(  1004 , 'rechenschieber.png'             , 'phi@smoch.ch' , 'Rechenschieber'                  , 'Rechenschieber'           ),
(  1005 , 'zuse_z3_a.jpg'                  , 'phi@smoch.ch' , 'Zuse Z3 Deutsches Museum'        , 'Zuse Z3'                   ),
(  1006 , 'zuse_z3_b.jpg'                  , 'phi@smoch.ch' , 'Zuse Z3 Deutsches Museum'        , 'Zuse Z3'                   ),
(  1007 , 'zuse_z4.jpg'                    , 'phi@smoch.ch' , 'Zuse Z4 Deutsches Museum'        , 'Zuse Z4'                   ),
(  1008 , 'zuse_z4_eingabetastatur.jpg'    , 'phi@smoch.ch' , 'Zuse Z4 Deutsches Museum'        , 'Zuse Z4'                   ),
(  1009 , 'notRelaisNachbau_schema.png'    , 'phi@smoch.ch' , 'Schema, für das NOT-Gatter mit Relais', 'Schema (elektronisch), für ein NOT-Gatter mittels Relais'),
(  1010 , 'notTransistorNachbau_schema.png', 'phi@smoch.ch' ,  'Schema, um ein NOT-Gatter mit Transistoren zu bauen', 'Schema (elektronisch), um ein NOT-Gatter mittels Tranistoren zu bauen.'),
(  1011 , 'differenzenmaschine.png'        , 'phi@smoch.ch' , 'Ch. Babbage: Differenzenmaschine im Da Vinci Museum in Mailand', 'Foto: Differenzenmaschine'),
(  1012 , 'volladdiererNachbau_schema.png ', 'phi@smoch.ch' , 'Schema, um einen Volladdierer zu bauen', 'Schema, um einen Volladdierer zu bauen.'),

-- speichern
(  2001 , 'amphore_etruskisch.png'         , 'phi@smoch.ch' , 'Etruskische Amphore: Nachbildung aus Popolonio', 'Amphore aus Ton'          ),
(  2002 , 'amphore_3d_druck.png'           , 'phi@smoch.ch' , 'Amphore aus dem 3D-Drucker'      , 'Amphore aus Plastik'      ),
(  2003 , 'amphoren_wiki.png'              , 'http://www.wikimedia.org' , 'Amphoren antik (Bild Wikimedia)' , 'Antike Amphoren Wikimedia'),
(  2004 , 'diskette35.png'                 , 'phi@smoch.ch' , 'Diskette 3.5 Zoll'               , 'Diskette 3.5 Zoll'        ),
(  2005 , 'cd-ubuntu.png'                  , 'phi@smoch.ch' , 'Compct Disk (CD)'                , 'Compact Disk (Daten)'     ),
(  2006 , 'cd-vince.png'                   , 'phi@smoch.ch' , 'Compct Disk (CD)'                , 'Audio CD'                 ),
(  2008 , 'bitRelaisNachbau_schema.png'    , 'phi@smoch.ch' , 'Schema, um ein Bit mit Relais zu speichern',  'Schema (elektronisch), um ein Bit mittels Relais zu speichern'),
(  2009 , 'bitTransistorNachbau_schema.png', 'phi@smoch.ch' , 'Schema, um ein Bit mittels Transistoren zu speichern', 'Schema (elektronisch), um ein Bit mittels Relais zu speichern'),

-- kommunizieren
(  3001 , 'keilschrift.png'                , 'phi@smoch.ch' , 'Keilschrift selbst gebannt'      , 'Keilschrift auf Ton'      ),

-- diverse
(  9001 , 'smartphone_htc_desire.jpg'      , 'phi@smoch.ch' , 'Smartphone HTC Desire'           , 'Smartphone'                ),
(  9002 , 'halbleiter.png'                 , 'phi@smoch.ch' , 'Silizium, eines der häufigsten Elemente: Daraus werden die meisten Halbleiter gebaut.', 'Siliziumkristall'),
(  9003 , 'wafer.png'                      , 'phi@smoch.ch' , 'Wafer'                           , 'Waferplatte'               ),
(  9004 , 'wafer_mikroskop.jpg'            , 'phi@smoch.ch' , 'Wafer Mikroskopausschnitt'       , 'Mikroskopier eines Wafers (Ausschnitt)' );


-- -----------------------------------------------------
-- Erfindungsbilder sind die Bilder auf der Webseite.
-- Ein Bild kann theoretisch zu mehreren Erfindungen gehören, wie z.B. das Smartphone.
CREATE TABLE `tbl_erfindungsbild` (
  `IDurl_fk`  varchar(200)
, `ord`       int             COMMENT 'Bildreihenfolge auf der Webseite'
, `bild_fk`   int
, PRIMARY KEY (IDurl_fk, `ord`)
, FOREIGN KEY (`IDurl_fk`) REFERENCES `tbl_erfindung` (`IDurl`)
, FOREIGN KEY (`bild_fk` ) REFERENCES `tbl_bild`     (`ID`   )
);


INSERT INTO `tbl_erfindungsbild`
(`IDurl_fk`      , `ord`, `bild_fk`) VALUES
-- rechnen
('abakus'        ,  1   ,   1001    ),  -- abakus
('pascaline'     ,  1   ,   1002    ),  -- foto pascaline deutsches Museum
('zahlenschieber',  1   ,   1003    ),  -- Zahlenschieber
('rechenschieber',  1   ,   1004    ),  -- rechenschieber deutsches Museum
('computer'      ,  1   ,   1005    ),  -- Zuse
('computer'      ,  2   ,   1006    ),  -- Zuse
('computer'      ,  3   ,   1007    ),  -- Zuse 
('computer'      ,  4   ,   1008    ),  -- Zuse Eingabegerät

-- spechern
('amphore'       ,  1   ,   2001    ),  -- Amphora Etruskisch Popolonio
('amphore'       ,  2   ,   2002    ),  -- 3D-Drucker Amhpore
('amphore'       ,  3   ,   2003    ),  -- Bild Wikipedia von Amphoren
('diskette'      ,  1   ,   2004    ),  -- Diskette S.U.s.E
('cd'            ,  1   ,   2005    ),  -- Ubuntu CD
('cd'            ,  2   ,   2006    ),  -- Vince Eberts CD "ur Knaller"

-- kommunizieren
('keilschrift'   ,  1   ,   3001    ),  -- bild von eigenen schriftZeichnen

-- diverse
('smartphone'    ,  1   ,   9001    );  -- htc desire smartphone


-- ---------------------------------------------------
-- Welche Bilder gehören zu welchen Exponaten
-- Theoretisch wären mehrere Bilder zum selben Exponat möglich.
CREATE TABLE `tbl_exponatbild` (
  `exponat_fk`  int
, `bild_fk`     int
, `ord`         int  DEFAULT 1 COMMENT 'Reihenfolge der Bilder der Exponate (Nur, falls einmal ein Exponat mehrere Fotos in der DB haben sollte)'
, FOREIGN KEY (`exponat_fk`) REFERENCES `tbl_exponat` (`ID`)
, FOREIGN KEY (`bild_fk`  ) REFERENCES `tbl_bild`   (`ID`)
);


INSERT INTO `tbl_exponatbild`
( `exponat_fk`, `bild_fk`, `ord`) VALUES
-- rechnen
(  1001       ,   1001    ,  1   ), -- abakus
(  1002       ,   1004    ,  1   ), -- rechenschieber
(  1003       ,   1003    ,  1   ), -- zahlenschieber

-- speichern
(  2001       ,   2001    ,  1   ), -- Etruskische Amphoore Popolonio
(  2002       ,   2002    ,  1   ), -- Amphore Bild aus dem 3DDrucker
-- ( 2003     ,  not yet  ,  1   ), -- Harddisk offen
(  2004       ,   2004    ,  1   ), -- Diskette S.U.s.E.
(  2005       ,   2005    ,  1   ), -- CD (Ubuntu OS 2008 Oktober (10)
(  2006       ,   2006    ,  1   ), -- CD (Audio : "Vince Eberts Ur-Knaller")

-- kommunizieren
(  3001       ,   3001    ,  1   ), -- Tontäfelchen selbt gebrannt

-- diverses
(  9001       ,   9001    ,  1   ); -- smartphone


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
-- rechnen
('abakus'        ,  1001        ,  1   ),
('rechenschieber',  1002        ,  1   ),
('zahlenschieber',  1003        ,  1   ),

-- speichern
('amphore'       ,  2001        ,  1   ),
('amphore'       ,  2002        ,  2   ),
('harddisk'      ,  2003        ,  1   ),
('diskette'      ,  2004        ,  1   ),
('cd'            ,  2005        ,  1   ),
('cd'            ,  2006        ,  2   ),

-- kommunizieren
('keilschrift'   ,  3001        ,  1   ),

-- diveses
('smartphone'    ,  9001        ,  1   );


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


-- --------------------------------------------------------------
CREATE TABLE `tbl_autor` (
  `ID`        int PRIMARY KEY AUTO_INCREMENT
, `name`     text
);


INSERT INTO `tbl_autor`
(`name`) VALUES
('philipp gressly freimann (phi@smoch.ch)');


-- --------------------------------------------------------------
CREATE TABLE `tbl_editor` (
  `ID`        int PRIMARY KEY AUTO_INCREMENT
, `IDurl_fk`  varchar(200) 
, `autor_fk`  int
, FOREIGN KEY (`IDurl_fk`  ) REFERENCES `tbl_erfindung` (`IDurl`)
, FOREIGN KEY (`autor_fk`  ) REFERENCES `tbl_autor`     (`ID`   )
);


INSERT INTO `tbl_editor`
(`IDurl_fk`      , `autor_fk`) VALUES

-- rechnen
('abakus'        , 1),
('zahlenschieber', 1),
('rechenschieber', 1),
('pascaline'     , 1),
('computer'      , 1),

-- speichern
('amphore'       , 1),
('harddisk'      , 1),
('diskette'      , 1),
('cd'            , 1),

-- kommmunizieren
('keilschrift'   , 1),
('morsetaste'    , 1),

-- diverse
('smartphone'    , 1),
('chip'          , 1);
