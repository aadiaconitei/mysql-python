

--
-- Database: `recapitulare`
--
CREATE DATABASE IF NOT EXISTS `recapitulare` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `recapitulare`;

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `idadmin` int(10) UNSIGNED NOT NULL,
  `nume` varchar(45) NOT NULL,
  `prenume` varchar(45) NOT NULL,
  `email` varchar(145) NOT NULL,
  `parola` char(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- RELATIONSHIPS FOR TABLE `admin`:
--

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`idadmin`, `nume`, `prenume`, `email`, `parola`) VALUES
(1, 'Popa', 'Ion', 'popa.ion@test.ro', 'a94a8fe5ccb19ba61c4c0873d391e987982fbbd3'),
(2, 'Dobre', 'Dan', 'dobre.dan@tet.ro', '89e495e7941cf9e40e6980d14a16bf023ccd4c91');

-- --------------------------------------------------------

--
-- Table structure for table `adresa`
--

DROP TABLE IF EXISTS `adresa`;
CREATE TABLE `adresa` (
  `idadresa` int(10) UNSIGNED NOT NULL,
  `localitate` varchar(45) DEFAULT NULL,
  `strada` varchar(45) DEFAULT NULL,
  `codpostal` varchar(45) DEFAULT NULL,
  `numar` varchar(5) DEFAULT NULL,
  `ap` varchar(45) DEFAULT NULL,
  `judet` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- RELATIONSHIPS FOR TABLE `adresa`:
--   `idadresa`
--       `clienti` -> `idclient`
--

--
-- Dumping data for table `adresa`
--

INSERT INTO `adresa` (`idadresa`, `localitate`, `strada`, `codpostal`, `numar`, `ap`, `judet`) VALUES
(1, 'Balesti', NULL, '517117', NULL, NULL, 'Alba'),
(2, 'Bacau', 'Bacovia', '600237', '51A', '24', 'Bacau'),
(3, 'Bologa', NULL, '407471', NULL, NULL, 'Cluj');

--
-- Triggers `adresa`
--
DROP TRIGGER IF EXISTS `adresa_AFTER_DELETE`;
DELIMITER $$
CREATE TRIGGER `adresa_AFTER_DELETE` AFTER DELETE ON `adresa` FOR EACH ROW BEGIN
UPDATE clienti SET idadresa = NULL WHERE idadresa = OLD.idadresa;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `categorii`
--

DROP TABLE IF EXISTS `categorii`;
CREATE TABLE `categorii` (
  `idcategorie` int(10) UNSIGNED NOT NULL,
  `denumire` varchar(45) NOT NULL,
  `descriere` varchar(245) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- RELATIONSHIPS FOR TABLE `categorii`:
--

--
-- Dumping data for table `categorii`
--

INSERT INTO `categorii` (`idcategorie`, `denumire`, `descriere`) VALUES
(1, 'Sport', NULL),
(2, 'Pantofi', NULL),
(3, 'Haine', NULL),
(4, 'Noutati', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `clienti`
--

DROP TABLE IF EXISTS `clienti`;
CREATE TABLE `clienti` (
  `idclient` int(10) UNSIGNED NOT NULL,
  `nume` varchar(45) NOT NULL,
  `prenume` varchar(45) NOT NULL,
  `cnp` char(13) NOT NULL,
  `idadresa` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- RELATIONSHIPS FOR TABLE `clienti`:
--

--
-- Dumping data for table `clienti`
--

INSERT INTO `clienti` (`idclient`, `nume`, `prenume`, `cnp`, `idadresa`) VALUES
(1, 'Popescu', 'Cornel', '1880809155178', 1),
(2, 'Vasilescu', 'Razvan', '1890812892323', 2),
(3, 'Dornescu', 'Mihnea', '1900709892786', 2),
(4, 'Georgescu', 'Titi', '1890812892341', NULL),
(5, 'Popescu', 'Liviu', '1900812892345', 1),
(6, 'Georgescu', 'Titi', '1892812892341', 2);

-- --------------------------------------------------------

--
-- Table structure for table `culori`
--

DROP TABLE IF EXISTS `culori`;
CREATE TABLE `culori` (
  `idculoare` int(10) UNSIGNED NOT NULL,
  `nume` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- RELATIONSHIPS FOR TABLE `culori`:
--

--
-- Dumping data for table `culori`
--

INSERT INTO `culori` (`idculoare`, `nume`) VALUES
(1, 'alb'),
(3, 'negru'),
(2, 'rosu'),
(4, 'verde');

-- --------------------------------------------------------

--
-- Table structure for table `distribuitori`
--

DROP TABLE IF EXISTS `distribuitori`;
CREATE TABLE `distribuitori` (
  `iddistribuitor` int(10) UNSIGNED NOT NULL,
  `nume` varchar(45) NOT NULL,
  `idadresa` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- RELATIONSHIPS FOR TABLE `distribuitori`:
--   `idadresa`
--       `adresa` -> `idadresa`
--

--
-- Dumping data for table `distribuitori`
--

INSERT INTO `distribuitori` (`iddistribuitor`, `nume`, `idadresa`) VALUES
(1, 'Tuc', 2),
(2, 'Trac', 3);

-- --------------------------------------------------------

--
-- Table structure for table `factura`
--

DROP TABLE IF EXISTS `factura`;
CREATE TABLE `factura` (
  `idfactura` int(10) UNSIGNED NOT NULL,
  `nrtranzactie` varchar(45) NOT NULL,
  `idclient` int(10) UNSIGNED DEFAULT NULL,
  `data` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- RELATIONSHIPS FOR TABLE `factura`:
--

--
-- Dumping data for table `factura`
--

INSERT INTO `factura` (`idfactura`, `nrtranzactie`, `idclient`, `data`) VALUES
(1, 'AB12345', 1, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `itemfactura`
--

DROP TABLE IF EXISTS `itemfactura`;
CREATE TABLE `itemfactura` (
  `iditem` int(10) UNSIGNED NOT NULL,
  `idfactura` int(10) UNSIGNED DEFAULT NULL,
  `idprodus` int(10) UNSIGNED NOT NULL,
  `cantitate` int(11) DEFAULT NULL,
  `idculoare` int(10) UNSIGNED NOT NULL,
  `pretvanzare` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- RELATIONSHIPS FOR TABLE `itemfactura`:
--   `idculoare`
--       `produseculori` -> `idculoare`
--   `idfactura`
--       `factura` -> `idfactura`
--   `idprodus`
--       `produseculori` -> `idprodus`
--

--
-- Dumping data for table `itemfactura`
--

INSERT INTO `itemfactura` (`iditem`, `idfactura`, `idprodus`, `cantitate`, `idculoare`, `pretvanzare`) VALUES
(1, 1, 2, 3, 3, '25.00'),
(2, 1, 3, 5, 2, '35.00'),
(3, 1, 1, 1, 3, '50.00');

-- --------------------------------------------------------

--
-- Table structure for table `produse`
--

DROP TABLE IF EXISTS `produse`;
CREATE TABLE `produse` (
  `idprodus` int(10) UNSIGNED NOT NULL,
  `nume` varchar(245) DEFAULT NULL,
  `descriere` mediumtext,
  `idadmin` int(11) DEFAULT NULL,
  `data_adaugare` datetime DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- RELATIONSHIPS FOR TABLE `produse`:
--

--
-- Dumping data for table `produse`
--

INSERT INTO `produse` (`idprodus`, `nume`, `descriere`, `idadmin`, `data_adaugare`, `status`) VALUES
(1, 'Geacă de primăvară-toamnă \'Bikerprincess\'', 'Geacă de primăvară-toamnă \'Bikerprincess\' FREAKY NATION pe negru\r\nDesign & funcționalitate\r\nCroială pe talie\r\nFermoar înclinat\r\nMonocrom\r\nPiele\r\nGeacă de motociclist\r\nUşor căptuşit\r\nMaterial moale\r\nNr. articol FKN0077001001000\r\n\r\nMărime și croială\r\nForma potrivită: Formă îngustă\r\nLungime totală: 59cm\r\nLungimea mânecii: 62cm\r\n\r\nMaterial & îngrijire\r\nMaterial suprafață: 100% Piele\r\nElasticitatea: Neelastic\r\nConține piese netextile de origine animală: da', 1, '2021-04-06 04:12:10', 1),
(2, 'Geacă de primăvară-toamnă \'New Love\'', 'Geacă de primăvară-toamnă \'New Love\' FREAKY NATION pe roșu\r\nDesign & funcționalitate\r\nMonocrom\r\nBuzunar fermoar\r\nFermoar\r\nGuler rever\r\nPiele\r\nGeacă de motociclist\r\nUşor căptuşit\r\nMaterial neted\r\nUsed-Look\r\nNr. articol FKN0132001000001\r\n\r\nMărime și croială\r\nForma potrivită: Formă ce accentuează figura\r\nLungime totală: 59cm\r\nLungimea mânecii: 61cm\r\n\r\nMaterial & îngrijire\r\nMaterial suprafață: 100% Piele\r\nCăptușeală: 100% Bumbac\r\nCăptușeală mâneci: 100% Poliester\r\nElasticitatea: Neelastic\r\nConține piese netextile de origine animală: da', 2, '2021-04-04 14:28:35', 1),
(3, 'Sneaker de alergat \'CLIMACOOL VENTO\'', 'Sneaker de alergat \'CLIMACOOL VENTO\' ADIDAS PERFORMANCE pe negru / alb\r\nDesign & funcționalitate\r\nBombeu rotund\r\n9-12 mm diferență de înălțime\r\nProfil\r\nOchiuri de plasă\r\nÎnchidere cu șireturi\r\nPrint Logo\r\nMix de materiale\r\nȘiret 5 găuri\r\nDungi laterale\r\nInserții culori în contrast\r\nPlasă air\r\nCălcâi întărit\r\nZona degetelor de picioare întărită\r\nConstrucție fără cusături\r\nLabel Print\r\nInserții de plasă/ochiuri\r\nAmortizare\r\nTalpă flexibilă\r\nSuprafață structurată\r\nNr. articol ADI2906005000004\r\n\r\nMărime și croială\r\nGreutate: 300-400 g\r\n\r\nMaterial & îngrijire\r\nMaterial suprafață: Sintetic, Textil\r\nCăptușeală și branț: Textil\r\nTalpă: Cauciuc\r\n\r\nFuncționalitate\r\nTipul de sport: Atletism\r\nFuncţii: Amortizare\r\nDomeniul de utilizare: Stradă/antrenament\r\nAmortizarea: Boost', 1, '2021-04-05 20:17:50', 1),
(4, 'Pantofi \'Woodland\'\r\n', 'Pantofi \'Woodland\' JACK WOLFSKIN pe gri\r\nDesign & funcționalitate\r\nÎnchidere cu șireturi\r\nMonocrom\r\nBombeu rotund\r\nOchiuri de plasă\r\nImitație de piele\r\nProfil\r\nFață de încălțăminte căptușită\r\nProducătorul este membru al Fair Wear Foundation (Leader Brand)\r\nNr. articol JKW0613001000001\r\n\r\nMărime și croială\r\nÎnălțimea tocului: Toc plat (0-3 cm)\r\n\r\nMaterial & îngrijire\r\nMaterial suprafață: Textil, Sintetic\r\nCăptușeală și branț: Textil\r\nTalpă: Material plastic\r\n\r\nFuncționalitate\r\nStil sneaker: Running\r\nTipul de sport: Drumeţii\r\nDomeniul de utilizare: Drumeție', 2, '2021-04-06 04:12:10', 1),
(5, 'Botine \'Wynn\'', 'Botine \'Wynn\' ICEPEAK pe negru\r\nDesign & funcționalitate\r\nMonocrom\r\nMix de materiale\r\nÎnălțimea gleznei\r\nPiele\r\nProfil\r\nUşor căptuşit\r\nPiele velur\r\nÎnchidere cu șireturi\r\nMaterial robust\r\nLabel Patch/Label Flag\r\nCusături ton în ton\r\nTalpă profilată\r\nProtecție degete la picioare\r\nOchiuri de alpinism\r\nProtecție de cauciuc călcâi\r\nFață de încălțăminte căptușită\r\nNr. articol ICP0181002000001\r\n\r\nMaterial & îngrijire\r\nMaterial suprafață: Piele, Sintetic\r\nMaterial interior: Textil\r\nTalpă: Cauciuc\r\nConține piese netextile de origine animală: da\r\n\r\nFuncționalitate\r\nTipul de sport: Drumeţii\r\nFuncţii: Rezistent la utilizare intensă, Rezistent la apă, Respirație activă\r\nDomeniul de utilizare: Teren\r\nDomeniul de utilizare: Drumeție', 2, '2021-04-04 14:28:35', 1);

-- --------------------------------------------------------

--
-- Table structure for table `produsecategorii`
--

DROP TABLE IF EXISTS `produsecategorii`;
CREATE TABLE `produsecategorii` (
  `id` int(10) UNSIGNED NOT NULL,
  `idcategorie` int(11) DEFAULT NULL,
  `idprodus` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- RELATIONSHIPS FOR TABLE `produsecategorii`:
--

--
-- Dumping data for table `produsecategorii`
--

INSERT INTO `produsecategorii` (`id`, `idcategorie`, `idprodus`) VALUES
(1, 1, 1),
(2, 2, 1),
(3, 3, 2),
(4, 4, 2),
(5, 2, 3),
(6, 1, 4),
(7, 3, 5),
(8, 4, 4),
(9, 1, 2);

-- --------------------------------------------------------

--
-- Table structure for table `produseculori`
--

DROP TABLE IF EXISTS `produseculori`;
CREATE TABLE `produseculori` (
  `id` int(10) UNSIGNED NOT NULL,
  `idculoare` int(10) UNSIGNED NOT NULL,
  `idprodus` int(10) UNSIGNED NOT NULL,
  `cantitate` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- RELATIONSHIPS FOR TABLE `produseculori`:
--

--
-- Dumping data for table `produseculori`
--

INSERT INTO `produseculori` (`id`, `idculoare`, `idprodus`, `cantitate`) VALUES
(1, 1, 1, 15),
(2, 3, 2, 25),
(3, 1, 2, 35),
(4, 3, 1, 45),
(5, 3, 3, 50),
(6, 3, 4, 60),
(7, 2, 3, 50),
(8, 2, 4, 60),
(9, 4, 5, 50),
(10, 2, 5, 60);

-- --------------------------------------------------------

--
-- Table structure for table `produsedistribuitori`
--

DROP TABLE IF EXISTS `produsedistribuitori`;
CREATE TABLE `produsedistribuitori` (
  `id` int(10) UNSIGNED NOT NULL,
  `idprodus` int(10) UNSIGNED DEFAULT NULL,
  `iddistribuitor` int(10) UNSIGNED DEFAULT NULL,
  `pretcumparare` decimal(10,2) UNSIGNED DEFAULT '0.00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- RELATIONSHIPS FOR TABLE `produsedistribuitori`:
--   `iddistribuitor`
--       `distribuitori` -> `iddistribuitor`
--   `idprodus`
--       `produse` -> `idprodus`
--

--
-- Dumping data for table `produsedistribuitori`
--

INSERT INTO `produsedistribuitori` (`id`, `idprodus`, `iddistribuitor`, `pretcumparare`) VALUES
(9, 1, 2, '10.00'),
(10, 2, 2, '15.00');

-- --------------------------------------------------------

--
-- Table structure for table `produselog`
--

DROP TABLE IF EXISTS `produselog`;
CREATE TABLE `produselog` (
  `id` int(10) UNSIGNED NOT NULL,
  `idprodus` int(11) UNSIGNED DEFAULT NULL,
  `idadmin` int(11) UNSIGNED DEFAULT NULL,
  `datamodificare` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- RELATIONSHIPS FOR TABLE `produselog`:
--   `idadmin`
--       `admin` -> `idadmin`
--   `idprodus`
--       `produse` -> `idprodus`
--

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`idadmin`),
  ADD UNIQUE KEY `email_UNIQUE` (`email`);

--
-- Indexes for table `adresa`
--
ALTER TABLE `adresa`
  ADD PRIMARY KEY (`idadresa`);

--
-- Indexes for table `categorii`
--
ALTER TABLE `categorii`
  ADD PRIMARY KEY (`idcategorie`),
  ADD UNIQUE KEY `denumire_UNIQUE` (`denumire`);

--
-- Indexes for table `clienti`
--
ALTER TABLE `clienti`
  ADD PRIMARY KEY (`idclient`),
  ADD UNIQUE KEY `cnp_UNIQUE` (`cnp`);

--
-- Indexes for table `culori`
--
ALTER TABLE `culori`
  ADD PRIMARY KEY (`idculoare`),
  ADD UNIQUE KEY `nume_UNIQUE` (`nume`);

--
-- Indexes for table `distribuitori`
--
ALTER TABLE `distribuitori`
  ADD PRIMARY KEY (`iddistribuitor`),
  ADD KEY `key_adresa_idx` (`idadresa`);

--
-- Indexes for table `factura`
--
ALTER TABLE `factura`
  ADD PRIMARY KEY (`idfactura`);

--
-- Indexes for table `itemfactura`
--
ALTER TABLE `itemfactura`
  ADD PRIMARY KEY (`iditem`),
  ADD KEY `key_fact_idx` (`idfactura`),
  ADD KEY `prod` (`idprodus`),
  ADD KEY `culo` (`idculoare`);

--
-- Indexes for table `produse`
--
ALTER TABLE `produse`
  ADD PRIMARY KEY (`idprodus`);

--
-- Indexes for table `produsecategorii`
--
ALTER TABLE `produsecategorii`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idcat` (`idcategorie`),
  ADD KEY `idprod` (`idprodus`);

--
-- Indexes for table `produseculori`
--
ALTER TABLE `produseculori`
  ADD PRIMARY KEY (`id`),
  ADD KEY `prod` (`idprodus`),
  ADD KEY `culoare` (`idculoare`);

--
-- Indexes for table `produsedistribuitori`
--
ALTER TABLE `produsedistribuitori`
  ADD PRIMARY KEY (`id`),
  ADD KEY `key_produs_idx` (`idprodus`),
  ADD KEY `key_dist_idx` (`iddistribuitor`);

--
-- Indexes for table `produselog`
--
ALTER TABLE `produselog`
  ADD PRIMARY KEY (`id`),
  ADD KEY `key_idprodus_idx` (`idprodus`),
  ADD KEY `key_idadmin_idx` (`idadmin`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `idadmin` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `adresa`
--
ALTER TABLE `adresa`
  MODIFY `idadresa` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `categorii`
--
ALTER TABLE `categorii`
  MODIFY `idcategorie` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `clienti`
--
ALTER TABLE `clienti`
  MODIFY `idclient` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `culori`
--
ALTER TABLE `culori`
  MODIFY `idculoare` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `distribuitori`
--
ALTER TABLE `distribuitori`
  MODIFY `iddistribuitor` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `factura`
--
ALTER TABLE `factura`
  MODIFY `idfactura` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `itemfactura`
--
ALTER TABLE `itemfactura`
  MODIFY `iditem` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `produse`
--
ALTER TABLE `produse`
  MODIFY `idprodus` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `produsecategorii`
--
ALTER TABLE `produsecategorii`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `produseculori`
--
ALTER TABLE `produseculori`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `produsedistribuitori`
--
ALTER TABLE `produsedistribuitori`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `produselog`
--
ALTER TABLE `produselog`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `adresa`
--
ALTER TABLE `adresa`
  ADD CONSTRAINT `idadresa_key` FOREIGN KEY (`idadresa`) REFERENCES `clienti` (`idclient`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `distribuitori`
--
ALTER TABLE `distribuitori`
  ADD CONSTRAINT `key_adresa` FOREIGN KEY (`idadresa`) REFERENCES `adresa` (`idadresa`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `itemfactura`
--
ALTER TABLE `itemfactura`
  ADD CONSTRAINT `key_culoare` FOREIGN KEY (`idculoare`) REFERENCES `produseculori` (`idculoare`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `key_fact` FOREIGN KEY (`idfactura`) REFERENCES `factura` (`idfactura`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `key_prod` FOREIGN KEY (`idprodus`) REFERENCES `produseculori` (`idprodus`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `produsedistribuitori`
--
ALTER TABLE `produsedistribuitori`
  ADD CONSTRAINT `key_dist` FOREIGN KEY (`iddistribuitor`) REFERENCES `distribuitori` (`iddistribuitor`),
  ADD CONSTRAINT `key_produs` FOREIGN KEY (`idprodus`) REFERENCES `produse` (`idprodus`);

--
-- Constraints for table `produselog`
--
ALTER TABLE `produselog`
  ADD CONSTRAINT `key_idadmin` FOREIGN KEY (`idadmin`) REFERENCES `admin` (`idadmin`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `key_idprodus` FOREIGN KEY (`idprodus`) REFERENCES `produse` (`idprodus`) ON DELETE NO ACTION ON UPDATE NO ACTION;

