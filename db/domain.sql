-- 2019-05-18 phi
-- DATENBANK zu SMOCH: DOMAIN Tabellen

USE `smocha_db`;

-- --------------------------------------------------------
CREATE TABLE `tbl_program_parameter` (
  `name`        varchar(20) PRIMARY KEY NOT NULL
, `value`       text
, `description` text
);


INSERT INTO `tbl_program_parameter`
(`name`                , `value`               , `description`                                      ) VALUES
('isDevelop'           , 'false'               , 'false = scharf; true=localhost o. ä.'             ),
('browser_path'        , '/'                   , 'url after "host:port" entry on targed host'       ),
('browser_path_develop', '/smoch/'             , 'same as browser_path, but on development machine.'),
('server_root'         , '/var/www/smoch'      , 'server root for php includes or file readings.'   ),
('server_root_develop' , '/var/www/html/smoch' , 'server root on localhost for development'         ),
('erfindungen_pfad'    , 'erfindungen/'        , 'Wo liegen die Artikel und die bilder?'            ),
('artikel_dir'         , 'artikel/'            , 'Innerhalb von «erfindungen_pfad»'                 ),
('bilder_dir'          , 'bilder/'             , 'Innerhalb von «erfindungen_pfad»'                 );


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
  `IDurl`            varchar(200)  NOT NULL PRIMARY KEY
                                            COMMENT 'withount *.php without *http://" without path. Wird ebenfalls verwendet für das Freitext-Prefix'
, `Titel`            Text          NOT NULL COMMENT 'visible title'
, `Jahrzahl`         varchar(20)   NOT NULL COMMENT 'sometimes as text (eg. 900 - 1200)'
, `defaultKategorie` int           NOT NULL COMMENT 'Welche Kategorie ist Standard bei Verwendung mit QR Codes?'
, FOREIGN KEY (`defaultKategorie`) REFERENCES `tbl_kategorie` (`ID`)
);


INSERT INTO `tbl_erfindung`
(`IDurl`,          `Titel`                             , `Jahrzahl`        , `defaultKategorie` ) VALUES
-- rechnen
('abakus'             , 'Abakus'                            , 'ca. 2500 v. Chr.', 1                  ),
('rechenschieber'     , 'Rechenschieber'                    ,     '1632'        , 1                  ),
('pascaline'          , 'Pascaline'                         ,     '1642'        , 1                  ),
('neperstaebchen'     , 'Neperstäbchen'                     ,     '17. Jh.'     , 1                  ),
('binaersystem'       , 'Binärsystem'                       ,     '1692'        , 1                  ),
('zahlenschieber'     , 'Zahlenschieber (Addiator)'         , 'ca. 1700'        , 1                  ),
('differenzenmaschine', 'Differenzenmaschine'               ,     '1822'        , 1                  ),
('monkey'             , 'Educated Monkey'                   ,     '1916'        , 1                  ),
('elektr_rechner'     , 'Elektromechanischer Rechner'       , 'ca. 1925'        , 1                  ),
('computer'           , 'Computer'                          ,     '1937'        , 1                  ),
('not_relais'         , 'NOT realisiert mit Relais'         ,     '1941'        , 1                  ),
('roehren'            , 'Röhrenrechner'                     ,     '1942'        , 1                  ),
('transistor'         , 'Bipolartransistor'                 ,     '1948'        , 1                  ),
('taschenrechner'     , 'Taschenrechner'                    ,     '1967'        , 1                  ),
('rpn_tr'             , 'Wissenschaftlicher Taschenrechner' ,     '1972'        , 1                  ),
('not_transistor'     , 'NOT realisiert mit Transistror'    , '????'            , 1                  ),
('volladdierer'       , 'Volladdierer'                      , '????'            , 1                  ),

-- speichern
('amphore'            , 'Amphore'                           ,  'ca. 500 v. Chr.', 2                  ),
('lochkarte'          , 'Lochkarte'                         , '18. Jahrhundert' , 2                  ),
('magnetband'         , 'Magnetband'                        ,     '1898'        , 2                  ),
('kernspeicher'       , 'Kernspeicher'                      ,     '1949'        , 2                  ),
('harddisk'           , 'Harddisk'                          ,     '1956'        , 2                  ),
('diskette'           , 'Diskette'                          ,     '1969'        , 2                  ),
('cd'                 , 'CD - ROM'                          ,     '1977'        , 2                  ),
('flash'              , 'Flash Speicher'                    ,     'ca. 1985'    , 2                  ),
('bit_relais'         , 'Bit realisiert mit Relais'         ,     '????'        , 2                  ),
('bit_transistor'     , 'Bit realisiert mit Transistor'     ,     '????'        , 2                  ),


-- kommunizieren
('schrift'            , 'Schriften'                         , 'ca. 4000 v. Chr.', 3                  ),
('brief'              , 'Briefe'                            , 'ca 1800 v. Chr.' , 3                  ),
('buchdruck'          , 'Buchdruck'                         ,      '868'        , 3                  ),
('morsetaste'         , 'Morsegerät/Relaisstation'          ,     '1833'        , 3                  ),
('enigma'             , 'Enigma'                            ,     '1918'        , 3                  ),
('glasfaser'          , 'Lichtwellenleiter'                 ,     '1960'        , 3                  ),
('telephon'           , 'Telefon'                           ,     '1861'        , 3                  ),
('ascii'              , 'ASCII'                             ,     '1963'        , 3                  ),

-- diverse Kategorien
('smartphone'         , 'Smartphone'                        ,     '1994'        , 3                  ),
('chip'               , 'Rechner- / Speicherchip'           , 'ca. 1950'        , 1                  ),
('wafer'              , 'Wafer'                             ,     '1960'        , 2                  ),
('halbleiter'         , 'Halbleiter (Silicium)'             ,     '1874'        , 1                  );



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
(`IDurl_fk`           , `kategorie_fk`, `ord`    ) VALUES

-- rechnen
('abakus'             ,             1 ,   1      ),
('rechenschieber'     ,             1 ,   2      ),
('pascaline'          ,             1 ,   3      ),
('neperstaebchen'     ,             1 ,   4      ),
('binaersystem'       ,             1 ,   5      ),
('zahlenschieber'     ,             1 ,   6      ),
('differenzenmaschine',             1 ,   7      ),
('halbleiter'         ,             1 ,   8      ),
('monkey'             ,             1 ,   9      ),
('elektr_rechner'     ,             1 ,  10      ),
('not_relais'         ,             1 ,  11      ),
('computer'           ,             1 ,  12      ),
('roehren'            ,             1 ,  13      ),
('volladdierer'       ,             1 ,  14      ),
('transistor'         ,             1 ,  15      ),
('not_transistor'     ,             1 ,  16      ),
('chip'               ,             1 ,  17      ),
('wafer'              ,             1 ,  18      ),
('taschenrechner'     ,             1 ,  19      ),
('rpn_tr'             ,             1 ,  20      ),
('smartphone'         ,             1 ,  21      ),

-- speichern
('amphore'            ,             2 ,   1      ),
('buchdruck'          ,             2 ,   2      ),
('lochkarte'          ,             2 ,   3      ),
('halbleiter'         ,             2 ,   4      ),
('magnetband'         ,             2 ,   5      ),
('bit_relais'         ,             2 ,   6      ),
('bit_transistor'     ,             2 ,   7      ),
('kernspeicher'       ,             2 ,   8      ),
('chip'               ,             2 ,   9      ),
('harddisk'           ,             2 ,  10      ),
('wafer'              ,             2 ,  11      ),
('diskette'           ,             2 ,  12      ),
('cd'                 ,             2 ,  13      ),
('flash'              ,             2 ,  14      ),
('smartphone'         ,             2 ,  15      ),

-- kommunizieren
('schrift'            ,             3 ,   1      ),
('brief'              ,             3 ,   2      ),
('buchdruck'          ,             3 ,   3      ),
('morsetaste'         ,             3 ,   4      ),
('telephon'           ,             3 ,   5      ),
('enigma'             ,             3 ,   6      ),
('glasfaser'          ,             3 ,   7      ),
('ascii'              ,             3 ,   8      ),
('smartphone'         ,             3 ,   9      );



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
(1001 , 'ca. 1960'     , 'Chinesischer Abakus'                                , 'R_001_a'     , true       ),
(1002 , 'ca. 1960'     , 'Aristo Nr. 89 '                                     , 'R_002_r'     , true       ),
(1003 , 'ca. 1970'     , 'Zahlenschieber Adimult'                             , 'R_003_z'     , true       ),
(1004 , 'ca. 2010'     , 'C074HCT68E: Rechnerchip XOR'                        , 'R_004_c'     , true       ),
(1005 , '2020'         , 'NOT Realais Nachbau Omron-Relais 8V'                , 'R_005_r'     , true       ),
(1006 , 'ca. 2005'     , 'Educated Monkey (Barcelona)'                        , 'R_006_m'     , false      ),
(1007 , 'ca. 2010'     , 'Verstärkerröhre'                                    , 'R_007_r'     , false      ),
(1008 , '2025'         , 'NOT nachgebaut mit Transistoren'                    , 'R_008_n'     , true       ),
(1009 , '1975'         , 'Taschenrechner Privileg 853 M'                      , 'R_009_t'     , true       ),
(1010 , '1981'         , 'Pocket Computer (PC)'                               , 'R_010_s'     , true       ),
(1011 , 'ca 1950'      , 'Teil eines Röhrenrechners'                          , 'R_007_e'     , true       ),
(1012 , 'ca 1982'      , 'Wissenschaftlicher Taschenrechner HP 15C'           , 'R_011_h'     , false      ),
(1013 , '1972'         , 'Wissenschaftlicher Taschenrechner HP 35'            , 'R_012_h'     , true       ),
(1014 , '????'         , 'Elektromechanischer Tischrechner'                   , 'R_013_e'     , true       ),
-- speichern
(2001 , '2016'         , 'Nachbildung Etruskischer Amphore aus Popolonio'     , 'S_001_a'     , true       ),
(2002 , '2019'         , 'Nachbildung aus dem 3D-Drucker'                     , 'S_002_a'     , true       ),
(2003 , '60er Jahre'   , 'Harddisk, IBM 360'                                  , 'S_003_h'     , true       ),
(2004 , '1997'         , '3.5 Zoll Boot-Diskette S.U.s.E. Linux Kernel 2.0.3x', 'S_004_d'     , true       ),
(2005 , '2008'         , 'Ubuntu OS 8.10'                                     , 'S_005_u'     , false      ),
(2006 , '2004'         , 'Vince Ebers Ur-Knaller'                             , 'S_006_c'     , false      ),
(2007 , '1964'         , 'Lochkarte 80-Spalten f. EBCDIC (ungelocht)'         , 'S_007_l'     , true       ),
(2008 , 'ca. 2010'     , 'Speicherchip C04040BE: Flip Flop'                   , 'S_008_c'     , true       ),
(2009 , 'ca 1970'      , 'Kernspeicher DELL'                                  , 'S_009_k'     , true       ),
(2010 , 'ca. 1970'     , 'Magnetband Storage-Master'                          , 'S_010_m'     , true       ),
(2011 , '2020'         , 'Bit nachgebaut mit Transitoren'                     , 'S_011_b'     , true       ),
(2012 , '1999'         , 'Compact Flash SanDisk 8MB'                          , 'S_012_f'     , true       ),
(2013 , 'ca. 1998'     , 'Harddisk offen'                                     , 'S_003_d'     , false      ),
(2014 , 'anf. 20. Jh'  , 'Buch «Petra»'                                       , 'S_013_b'     , true       ),
-- kommunizieren
-- (3001 , '2019'         , 'Tontäfelchen selbst gebrannt ;-)'                , 'K_001_k'     , false      ),
(3002 , 'ca. 1930/40'  , 'Kurbeltelephon 30er Jahre'                          , 'K_002_t'     , true       ),
(3003 , '????'         , 'Morsetaste'                                         , 'K_003_m'     , true       ),
(3004 , '1920'         , 'Brief'                                              , 'K_004_b'     , true       ),

-- diverse
(9001 , '2010'         , 'HTC Desire'                                         , 'D_001_s'     , true       ),
(9002 , '-0'           , 'Halbleiter Silicium'                                , 'D_002_h'     , true       ),
(9003 , 'unbekannt'    , 'Wafer'                                              , 'D_003_w'     , true       ),
(9004 , 'ca 2005'      , 'BC 548C, bipolar Transistor'                        , 'D_005_a'     , true       ),
(9005 , '1997'         , 'Easy Driver CD-ROM'                                 , 'D_006_e'     , true       ),
(9006 , '1998'         , 'Nokia Smartphone (Modell 6150 SAT)'                 , 'D_007_s'     , true       );


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
(`ID`   , `filename`                                    , `bildrechte`   , `alt_text`                                                  , `bildlegende`                                                                                            )
VALUES
-- RECHNEN
(  1001 , 'abakus.png'                                  , 'phi@smoch.ch' , 'Abakus (Zählrahmen aus Holz)'                               , 'Chinesischer Abakus neu'                                                                                ),
(  1002 , 'pascaline.jpg'                               , 'phi@smoch.ch' , 'Pascaline'                                                  , 'Pascaline: Diese Rechenmaschine nach Blaise Pascal steht im Deutschen Museum in München (Foto 2018)'    ),
(  1003 , 'zahlenschieber.png'                          , 'phi@smoch.ch' , 'Zahlenschieber Addimult'                                    , 'Mechanischer Zahlenschieber "Addimult" aus Metall'                                                      ),
(  1004 , 'rechenschieber.png'                          , 'phi@smoch.ch' , 'Rechenschieber'                                             , 'Logarithmischer Rechenschieber (Aristo Nr. 69)'                                                         ),
(  1005 , 'zuse/zuse_z3_a.jpg'                          , 'phi@smoch.ch' , 'Zuse Z3'                                                    , 'Zuse Z3 Deutsches Museum (Foto 2018)'                                                                   ),
(  1006 , 'zuse/zuse_z3_b.jpg'                          , 'phi@smoch.ch' , 'Zuse Z3'                                                    , 'Zuse Z3 Deutsches Museum (Foto 2018)'                                                                   ),
(  1007 , 'zuse/zuse_z4.jpg'                            , 'phi@smoch.ch' , 'Zuse Z4'                                                    , 'Zuse Z4 Deutsches Museum (Foto 2018)'                                                                   ),
(  1008 , 'zuse/zuse_z4_eingabetastatur.jpg'            , 'phi@smoch.ch' , 'Zuse Z4 Eingabetastatur'                                    , 'Zuse Z4 Eingabetastatur (Deutsches Museum in München / Foto 2018)'                                      ),
(  1009 , 'not/relais_nachbau_schema.png'               , 'phi@smoch.ch' , 'Schema (elektronisch) für das NOT-Gatter mit Relais'        , 'Schema für ein NOT-Gatter mittels Relais'                                                               ),
(  1010 , 'not/transistor_nachbau_schema.png'           , 'phi@smoch.ch' , 'Schema (elektronisch) für das NOT-Gatter mit Transistoren'  , 'Schema (elektronisch), um ein NOT-Gatter mittels Tranistoren zu bauen.'                                 ),
(  1011 , 'differenzenmaschine.png'                     , 'phi@smoch.ch' , 'Foto Differenzenmaschine'                                   , 'Ch. Babbage: Differenzenmaschine im Da Vinci Museum in Mailand'                                         ),
(  1012 , 'volladdierer/schema.png '                    , 'phi@smoch.ch' , 'Schema (elektronisch) für den Volladdierer'                 , 'Schema, um einen Volladdierer zu bauen.'                                                                ),
(  1013 , 'transistor.png '                             , 'phi@smoch.ch' , 'Transistoren'                                               , 'Transistoren'                                                                                           ),
(  1014 , 'not/relais_nachbau.png '                     , 'phi@smoch.ch' , 'NOT Nachbau mit Relais'                                     , 'NOT Nachbau mit Relais'                                                                                 ),
(  1015 , 'monkey.png '                                 , 'phi@smoch.ch' , 'The educated Monkey'                                        , 'The educated Monkey'                                                                                    ),
(  1016 , 'rechnerchip.png'                             , 'phi@smoch.ch' , 'Rechnerchip CD74HCT86E (xor)'                               , 'Computerchip im Gehäuse'                                                                                ),
(  1017 , 'roehren/roehre.png'                          , 'phi@smoch.ch' , 'Verstärkerröhre'                                            , 'Verstärkerröhre'                                                                                        ),
(  1018 , 'not/transistor_nachbau.png'                  , 'phi@smoch.ch' , 'elektronische Schaltung (NOT)'                              , 'Nachbau einer NOT-Schaltung mit Transistoren'                                                           ),
(  1019 , 'neperstaebchen.png'                          , 'phi@smoch.ch' , 'Holzstäbe mit Zahlen'                                       , 'Neperstäbchen (Foto aus dem Deutschen Museum)'                                                          ),
(  1020 , 'binaer.png'                                  , 'phi@smoch.ch' , 'Nullen und Einsen'                                          , 'Binäre Darstellung von Zahlen und Zeichen'                                                              ),
(  1021 , 'volladdierer/transistor_nachbau.png'         , 'phi@smoch.ch' , 'Schlatung'                                                  , 'Volladdierer mit Transistoren nachgebaut'                                                               ),
(  1022 , 'taschenrechner.png'                          , 'phi@smoch.ch' , 'Taschenrechner'                                             , 'Taschenrechner'                                                                                         ),
(  1023 , 'pc1500.png'                                  , 'phi@smoch.ch' , 'Pocket Computer'                                            , 'PC 1500 (Sharp): Pocket Computer'                                                                       ),
(  1024 , 'roehren/RoehrenAlt.png'                      , 'phi@smoch.ch' , 'Röhren'                                                     , 'Röhren aus einem «Elektronengehirn»'                                                                    ),
(  1025 , 'HP15C.png'                                   , 'phi@smoch.ch' , 'Wissenschaftlicher Taschenrechner'                          , 'Wissenschaftlicher Taschenrechner HP-15C'                                                               ),
(  1026 , 'HP35.png'                                    , 'phi@smoch.ch' , 'Wissenschaftlicher Taschenrechner'                          , 'Wissenschaftlicher Taschenrechner HP-35'                                                                ),
(  1027 , 'elektr_rechner.png'                          , 'phi@smoch.ch' , 'Elektromechanischer Tischrechner'                           , 'Elektromechanischer Tischrechner'                                                                       ),

-- speichern
(  2001 , 'amphora/amphore_etruskisch.png'              , 'phi@smoch.ch' , 'Amphore aus Ton'                                            , 'Etruskische Amphore: Nachbildung aus Popolonio'                                                         ),
(  2002 , 'amphora/amphore_3d_druck.png'                , 'phi@smoch.ch' , 'Amphore aus Plastik'                                        , 'Amphore dem 3D-Drucker (Prusa)'                                                                         ),
(  2003 , 'amphora/Athena_Herakles_Staatliche_Antikensammlungen_2301.jpg', 'http://www.wikimedia.org' , 'Athena Herakles Staatliche Antikensammlungen' , 'Athena Herakles Staatliche Antikensammlungen (Bild wikimedia.org)'                       ),
(  2004 , 'diskette35.png'                              , 'phi@smoch.ch' , 'Diskette 3.5 Zoll'                                          , 'Diskette 3.5 Zoll (S.u.S.E Linux Install Disk)'                                                         ),
(  2005 , 'cd-ubuntu.png'                               , 'phi@smoch.ch' , 'Compct Disk (CD)'                                           , 'Compact Disk (Daten: Ubuntu V8.10 Install CD)'                                                          ),
(  2006 , 'cd-vince.png'                                , 'phi@smoch.ch' , 'Compct Disk (CD)'                                           , 'Audio CD (Vince Eberts: Ur-Knaller)'                                                                    ),
(  2008 , 'bit/relais_nachbau_schema.png'               , 'phi@smoch.ch' , 'Schema (elektronisch) für den Bitspeicher mit Relais'       , 'Schema  um ein Bit mittels Relais zu speichern'                                                         ),
(  2009 , 'bit/transistor_nachbau_schema.png'           , 'phi@smoch.ch' , 'Schema (elektronisch) für den Bitspeicher mit Transistoren' , 'Schema um ein Bit mittels Transistoren zu speichern'                                                    ),
(  2010 , 'harddisk/harddisk.png'                       , 'phi@smoch.ch' , 'Harddisk offen'                                             , 'Harddisk geöffnet (Speicherkapazität unbekannt)'                                                        ),
(  2011 , 'lochkarte.png'                               , 'phi@smoch.ch' , 'Lochkarte'                                                  , 'Lochkarte'                                                                                              ),
(  2012 , 'kernspeicher/kernspeicher_ringe.jpg'         , 'phi@smoch.ch' , 'Kernspeicher Ringe'                                         , 'Ringe eines Kenrspeichers'                                                                              ),
(  2013 , 'kernspeicher/kernspeicher_modul.png'         , 'phi@smoch.ch' , 'Kernspeichermodul'                                          , 'Kernspeichermodul'                                                                                      ),
(  2014 , 'kernspeicher/kernspeicher_seitenansicht.jpg' , 'phi@smoch.ch' , 'Kernspeicher'                                               , 'Kernspeicher'                                                                                           ),
(  2015 , 'magnetband.png'                              , 'phi@smoch.ch' , 'Magnetband'                                                 , 'Magentband'                                                                                             ),
(  2016 , 'speicherchip.png'                            , 'phi@smoch.ch' , 'Speicherchip C04040BE (Flip-Flop)'                          , 'Speicherchip im Gehäuse'                                                                                ),
(  2017 , 'bit/transistor_nachbau.png'                  , 'phi@smoch.ch' , 'Elektronische Schaltung'                                    , 'Bit nachgebaut mittels Transistoner (Flip-Flop)'                                                        ),
(  2018 , 'flash/compactFlash8mb.png'                   , 'phi@smoch.ch' , 'Compact Flash 8MB'                                          , 'Flash Speicherkarte'                                                                                    ),
(  2019 , 'flash/compactFlash8mbTop.png'                , 'phi@smoch.ch' , 'Compact Flash 8MB'                                          , 'Flash Speicherkarte'                                                                                    ),
(  2020 , 'kernspeicher/kernspeicher_ringe2.jpg'        , 'phi@smoch.ch' , 'Kernspeicher'                                               , 'Kernspeicher'                                                                                           ),
(  2021 , 'harddisk/HardDiskGross.png'                  , 'phi@smoch.ch' , 'Harddisk'                                                   , 'Harddisk'                                                                                               ),
(  2022 , 'buch_petra.jpg'                              , 'phi@smoch.ch' , 'Buch'                                                       , '«Petra»'                                                                                                ),

-- kommunizieren
(  3001 , 'keilschrift.jpg'                             , 'phi@smoch.ch' , 'Keilschrift auf Ton'                                        , 'Keilschrift auf Ton; Auszug Gesetzbuch Hammurabis (Bild: Erik Nitsche «In Wort und Bild»)'              ),
(  3002 , 'telephon.png'                                , 'phi@smoch.ch' , 'Telephon'                                                   , 'Kurbeltelephon'                                                                                         ),
(  3003 , 'morsetaste.png'                              , 'phi@smoch.ch' , 'Morsetaste'                                                 , 'Morsetaste'                                                                                             ),
(  3005 , 'enigma1.png'                                 , 'phi@smoch.ch' , 'Rotor-Schlüsselmaschine'                                    , 'Enigma'                                                                                                 ),
(  3006 , 'enigma2.png'                                 , 'phi@smoch.ch' , 'Walzen zur Rotor-Schlüsselmaschine'                         , 'Enigma'                                                                                                 ),
(  3007 , 'brief.png'                                   , 'phi@smoch.ch' , 'Brief Dr. Wander 1920'                                      , 'Brief'                                                                                                  ),

-- diverse
(  9001 , 'smartphone/smartphone_htc_desire.png'        , 'phi@smoch.ch' , 'Smartphone'                                                 , 'Smartphone HTC Desire'                                                                                  ),
(  9002 , 'halbleiter.png'                              , 'phi@smoch.ch' , 'Siliziumkristall'                                           , 'Silizium: Eines der häufigsten Elemente: Daraus werden die meisten Halbleiter gebaut.'                  ),
(  9003 , 'wafer/wafer.png'                             , 'phi@smoch.ch' , 'Waferplatte'                                                , 'Waferplatte, wie sie für die Chip Herstellung verwendet wird.'                                          ),
(  9004 , 'wafer/wafer_mikroskop.jpg             '      , 'phi@smoch.ch' , 'Mikroskopie eines Wafers (Ausschnitt)'                      , 'Auschnitt Mikroskopier (Wafer)'                                                                         ),
(  9005 , 'gutenbergBibel.jpg'                          , 'wikimedia.org (2020)', 'Gedruckte Buchseite'                                 , 'Auschnitt aus der Gutenberg-Bibel (Quelle: Wikimedia.org 2020)'                                         ),
(  9006 , 'smartphone/nokia.png'                        , 'phi@smoch.ch' , 'Smartphone'                                                 , 'Nokia 6150 SAT Smartphone'                                                                              );


-- -----------------------------------------------------
-- Erfindungsbilder sind die Bilder auf der Webseite, die zu einer Erfindung gehören.
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
('computer'      ,  5   ,   1023    ),  -- PC 1500 (Pocket Computer)
('differenzenmaschine', 1,  1011    ),  -- Differenzenmaschine
('volladdierer'  ,  1   ,   1012    ),  -- Volladdierer Schema
('volladdierer'  ,  2   ,   1021    ),  -- Volladdierer mit Transistoren
('not_relais'    ,  1   ,   1009    ),  -- NOT mit Relais (schema)
('not_relais'    ,  2   ,   1014    ),  -- NOT Realais Nachbau
('not_transistor',  1   ,   1010    ),  -- NOT mit Transistoren (Schaltplan)
('not_transistor',  2   ,   1018    ),  -- NOT mit Transistoren (Breadboard)
('transistor'    ,  1   ,   1013    ),  -- Transistor
('monkey'        ,  1   ,   1015    ),  -- Educated Monkey
('chip'          ,  1   ,   1016    ),  -- Rechnerchip
('roehren'       ,  1   ,   1024    ),  -- Röhre aus einem «Elektronengehirn»
('roehren'       ,  2   ,   1017    ),  -- Verstärkerröhre
('neperstaebchen',  1   ,   1019    ),  -- Neperstäbchen
('binaersystem'  ,  1   ,   1020    ),  -- Nullen und Einsen
('taschenrechner',  1   ,   1022    ),  -- Taschenrechner
('rpn_tr'        ,  1   ,   1026    ),  -- Wissenschaftlicher TR HP 35
('rpn_tr'        ,  2   ,   1025    ),  -- Wissenschaftlicher Taschenrechner HP 15C
('elektr_rechner',  1   ,   1027    ),  -- Elektromechanischer Tischrechner

-- speichern
('amphore'       ,  1   ,   2001    ),  -- Amphora Etruskisch Popolonio
('amphore'       ,  2   ,   2002    ),  -- 3D-Drucker Amhpore
('amphore'       ,  3   ,   2003    ),  -- Bild Wikipedia von Amphoren
('diskette'      ,  1   ,   2004    ),  -- Diskette S.U.s.E
('cd'            ,  1   ,   2005    ),  -- Ubuntu CD
('cd'            ,  2   ,   2006    ),  -- Vince Eberts CD "ur Knaller"
('harddisk'      ,  1   ,   2021    ),  -- Harddisk
('harddisk'      ,  2   ,   2010    ),  -- Harddisk
('lochkarte'     ,  1   ,   2011    ),  -- Lochkarte blau
('bit_relais'    ,  1   ,   2008    ),  -- Bit mit Relais Latch
('bit_transistor',  1   ,   2009    ),  -- Bit mit Transitor nachgebaut
('bit_transistor',  2   ,   2017    ),  -- Bit Nachbau mit Flip-Flop (Transistoner)
('kernspeicher'  ,  1   ,   2012    ),  -- Kernspeicher Ringe
('kernspeicher'  ,  2   ,   2013    ),  -- Kernspeicher Modul
('kernspeicher'  ,  3   ,   2014    ),  -- Kernspeicher Seitenansicht
('kernspeicher'  ,  4   ,   2020    ),  -- Kernspeicher Foto von Berts Rothmans Kernspeicher
('magnetband'    ,  1   ,   2015    ),  -- Magnetband
('chip'          ,  2   ,   2016    ),  -- Speicherchip
('flash'         ,  1   ,   2018    ),  -- Flash Speicherchip
('flash'         ,  2   ,   2019    ),  -- Flash Speicherchip
-- kommunizieren
('schrift'       ,  1   ,   3001    ),  -- Bild der Babylonischen Keilschritf (Hammurabi)
('morsetaste'    ,  1   ,   3003    ),  -- Morsetaste
('telephon'      ,  1   ,   3002    ),  -- Telephon
('enigma'        ,  1   ,   3005    ),  -- Enigma
('enigma'        ,  2   ,   3006    ),  -- Walzen der Enigma
('brief'         ,  1   ,   3007    ),  -- Brief Dr. Wander

-- diverse
('smartphone'    ,  1   ,   9006    ),  -- NOKIA Smarphone 1998
('smartphone'    ,  2   ,   9001    ),  -- htc desire smartphone
('halbleiter'    ,  1   ,   9002    ),  -- halbleiter
('wafer'         ,  1   ,   9003    ),  -- Wafer
('wafer'         ,  2   ,   9004    ),  -- Wafer unter dem Mikroskop
('buchdruck'     ,  1   ,   9005    );  -- Auschnitt Gutenberg-Bibel von Wikimedia (2020)


-- ---------------------------------------------------
-- Welche Bilder gehören zu welchen Exponaten
-- Theoretisch wären mehrere Bilder zum selben Exponat möglich.
CREATE TABLE `tbl_exponatbild` (
  `exponat_fk`  int
, `bild_fk`     int
, `ord`         int  DEFAULT 1 COMMENT 'Reihenfolge der Bilder der Exponate (Nur, falls einmal ein Exponat mehrere Fotos in der DB haben sollte)'
, FOREIGN KEY (`exponat_fk`) REFERENCES `tbl_exponat` (`ID`)
, FOREIGN KEY (`bild_fk`   ) REFERENCES `tbl_bild`    (`ID`)
);


INSERT INTO `tbl_exponatbild`
( `exponat_fk`, `bild_fk`, `ord`) VALUES
-- rechnen
(  1001       ,   1001    ,  1   ), -- abakus
(  1002       ,   1004    ,  1   ), -- rechenschieber
(  1003       ,   1003    ,  1   ), -- zahlenschieber
(  1004       ,   1016    ,  1   ), -- Rechnerchip (XOR)
(  1005       ,   1014    ,  1   ), -- Relais Nachbau: NOT
(  1006       ,   1015    ,  1   ), -- The educated Monkey
(  1007       ,   1017    ,  1   ), -- Verstärkerröhre
(  1011       ,   1024    ,  1   ), -- Röhre aus einem Elektronengehirn
(  1008       ,   1018    ,  1   ), -- not mit Transistoren
(  1009       ,   1022    ,  1   ), -- Taschenrechner privileg 853M
(  1010       ,   1023    ,  1   ), -- PC 1500 Sharp
(  1013       ,   1026    ,  1   ), -- HP 35
(  1012       ,   1025    ,  2   ), -- HP 15 C
(  1014       ,   1027    ,  1   ), -- Elektromechanischer Tischrechner

-- speichern
(  2001       ,   2001    ,  1   ), -- Etruskische Amphoore Popolonio
(  2002       ,   2002    ,  1   ), -- Amphore Bild aus dem 3DDrucker
(  2013       ,   2010    ,  2   ), -- Harddisk offen
(  2003       ,   2021    ,  1   ), -- Harddisk einer alten IBM
(  2004       ,   2004    ,  1   ), -- Diskette S.U.s.E.
(  2005       ,   2005    ,  1   ), -- CD (Ubuntu OS 2008 Oktober (10)
(  2006       ,   2006    ,  1   ), -- CD (Audio : "Vince Eberts Ur-Knaller")
(  2007       ,   2011    ,  1   ), -- Lochkarte
(  2009       ,   2012    ,  1   ), -- Kernspeicher ringe
(  2009       ,   2013    ,  2   ), -- Kernspeicher Modul
(  2009       ,   2014    ,  3   ), -- Kernspeicher Seitenansicht
(  2009       ,   2020    ,  4   ), -- Kernspeicher von Bert
(  2010       ,   2015    ,  1   ), -- Magnetband ...
(  2008       ,   2016    ,  1   ), -- Speicherchip (XOR)
(  2011       ,   2017    ,  1   ), -- Bit nachgebaut mit Transistoren (Flip-Flop)
(  2012       ,   2018    ,  1   ), -- Flash Speicherkarte Compact Flash
(  2012       ,   2019    ,  2   ), -- Flash Speicherkarte Compact Flash
(  2014       ,   2022    ,  2   ), -- Buch «Petra»

-- kommunizieren
-- (  3001       ,   3001    ,  1   ), -- Tontäfelchen selbt gebrannt
(  3003       ,   3003    ,  1   ), -- Morsetaste
(  3002       ,   3002    ,  1   ), -- Telephon
(  3004       ,   3007    ,  1   ), -- Brief
-- diverses
(  9001       ,   9001    ,  1   ), -- smartphone
(  9002       ,   9002    ,  1   ), -- halbleiter Silicium
(  9003       ,   9003    ,  1   ), -- Wafer
(  9004       ,   1013    ,  1   ), -- Transistor
(  9006       ,   9006    ,  1   ); -- NOKIA 6150 SATA (1998)


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
('not_relais'    ,  1005        ,  1   ),
('monkey'        ,  1006        ,  1   ),
('chip'          ,  1004        ,  1   ),
('roehren'       ,  1011        ,  1   ),
('not_transistor',  1008        ,  1   ),
('taschenrechner',  1009        ,  1   ),
('computer'      ,  1010        ,  1   ),
('rpn_tr'        ,  1013        ,  1   ),
('rpn_tr'        ,  1012        ,  2   ),
('elektr_rechner',  1014        ,  1   ),

-- speichern
('amphore'       ,  2001        ,  1   ),
('amphore'       ,  2002        ,  2   ),
('harddisk'      ,  2013        ,  1   ),
('harddisk'      ,  2003        ,  2   ),
('diskette'      ,  2004        ,  1   ),
('cd'            ,  2005        ,  1   ),
('cd'            ,  2006        ,  2   ),
('cd'            ,  9005        ,  3   ),
('lochkarte'     ,  2007        ,  1   ),
('chip'          ,  2008        ,  2   ),
('kernspeicher'  ,  2009        ,  1   ),
('magnetband'    ,  2010        ,  1   ),
('bit_transistor',  2011        ,  1   ),
('flash'         ,  2012        ,  1   ),
('buchdruck'     ,  2014        ,  1   ),

-- kommunizieren
-- ('schrift'       ,  3001        ,  1   ),
('morsetaste'    ,  3003        ,  1   ),
('brief'         ,  3004        ,  1   ),
('telephon'      ,  3002        ,  1   ),

-- diveses
('smartphone'    ,  9001        ,  1   ),
('smartphone'    ,  9006        ,  2   ),
('halbleiter'    ,  9002        ,  1   ),
('wafer'         ,  9003        ,  1   ),
('transistor'    ,  9004        ,  1   );

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
('flash'         , 'Flash'               ),
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
-- Wer ist der Autor des Textes
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
('taschenrechner', 1),
('rpn_tr'        , 1),
('elektr_rechner', 1),
-- speichern
('amphore'       , 1),
('harddisk'      , 1),
('diskette'      , 1),
('cd'            , 1),
('magnetband'    , 1),
('flash'         , 1),

-- kommmunizieren
('schrift'       , 1),
('morsetaste'    , 1),
('telephon'      , 1),

-- diverse
('smartphone'    , 1),
('chip'          , 1);
