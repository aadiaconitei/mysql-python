I.

Conectare la server din linia de comanda:
mysql -u root -p

Conectare la server din MySQL Workbench
II.
-- CREATE DATABASE - creează baze de date
-- ALTER DATABASE - modifică baza de date
-- DROP DATABASE - elimină baze de date
-- CREATE TABLE - creează tabele
-- ALTER TABLE - modifică tabele
-- DROP TABLE - elimină tablele
-- CREATE INDEX - creează index pentru tabelă
-- DROP INDEX - elimină index-ul pentru tabelă

# Vizualizare baze de date existente:
SHOW DATABASES;

#Creati o baza de date cu numele magazin
CREATE DATABASE `banca` DEFAULT CHARACTER SET utf8 ;
# sau
# CREATE SCHEMA `banca` DEFAULT CHARACTER SET utf8 ;

#Alternativ, puteti folosi o comanda putin diferita
#(daca exista deja baza de date, nu va mai fi creata, dar cu aceasta a doua comanda, nici nu se va raporta o eroare)

CREATE DATABASE IF NOT EXISTS banca;

#verificati ca  baza de date a fost creata:
SHOW DATABASES;

#Setati baza de date pentru a fi folosita fara a fi nevoie sa fie invocata explicit
USE banca;

#Verificati si listeaza tabele:
SHOW TABLES;

#Acelasi rezultat il puteti obtine specificand numele tabelei prefixat de numele bazei de date; rezultatul se obtine indiferent daca am folosit anterior comanda USE;
SHOW TABLES in banca;
# creaza tabela utilizatori
CREATE TABLE `utilizatori`(
  `id` int NOT NULL AUTO_INCREMENT,
  `nume` varchar(50)  NOT NULL,
  `prenume` varchar(50)  NOT NULL,
  `email` varchar(50) DEFAULT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE plati (
  idplata    SMALLINT     UNSIGNED NOT NULL AUTO_INCREMENT,
  idcard   INT     UNSIGNED NOT NULL,
  idutilizator   INT     UNSIGNED NOT NULL,
  suma        DECIMAL(5,2) NOT NULL,
  data_plata  DATETIME     NOT NULL,
  actualizare   TIMESTAMP    DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY  (idplata),
  KEY idx_fk_idutilizator (idutilizator),
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE carduri (
  idcard    SMALLINT     UNSIGNED NOT NULL AUTO_INCREMENT,
  nume varchar(50)  NOT NULL,
  idutilizator   INT     UNSIGNED NOT NULL,
  numar INT     UNSIGNED NOT NULL,
  numar_verificare INT     UNSIGNED NOT NULL,
  sold        DECIMAL(5,2) NOT NULL,
  data_expirare  DATETIME     NOT NULL,
  actualizare   TIMESTAMP    DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY  (idcard),
  KEY idx_fk_idutilizator (idutilizator),
) ENGINE=InnoDB DEFAULT CHARSET=utf8;