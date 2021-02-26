CREATE TABLE `examene` (
  `idexamen` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `denumire` varchar(45) NOT NULL,
  `sala` varchar(45) NOT NULL,
  `data` datetime DEFAULT NULL,
  PRIMARY KEY (`idexamen`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `profesori` (
  `idprofesor` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `numar_matricol` varchar(45) DEFAULT NULL,
  `nume` varchar(45) DEFAULT NULL,
  `prenume` varchar(45) DEFAULT NULL,
  `grad` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idprofesor`),
  UNIQUE KEY `numar_matricol_UNIQUE` (`numar_matricol`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `studenti` (
  `idstudent` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `numar_matricol` varchar(45) DEFAULT NULL,
  `nume` varchar(45) DEFAULT NULL,
  `prenume` varchar(45) DEFAULT NULL,
  `cnp` int(13) unsigned DEFAULT NULL,
  `data_nasterii` date NOT NULL,
  PRIMARY KEY (`idstudent`),
  UNIQUE KEY `cnp_UNIQUE` (`cnp`),
  UNIQUE KEY `numar_matricol_UNIQUE` (`numar_matricol`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
