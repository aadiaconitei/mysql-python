#Creati o baza de date cu numele magazin
CREATE DATABASE `magazin` DEFAULT CHARACTER SET utf8 ;
#CREATE SCHEMA `magazin` DEFAULT CHARACTER SET utf8 ;
#(daca exista deja baza de date, nu va mai fi creata, dar cu aceasta a doua comanda, nici nu se va raporta o eroare)

CREATE DATABASE IF NOT EXISTS magazin;
#verificati ca  baza de date a fost creata:
SHOW DATABASES;

#Setati baza de date pentru a fi folosita fara a fi nevoie sa fie invocata explicit
USE magazin;

#Verificati ca nu a fost definita nici o tabela
SHOW TABLES;

#Acelasi rezultat il puteti obtine specificand numele tabelei prefixat de numele bazei de date; rezultatul se obtine indiferent daca am folosit anterior comanda USE;
SHOW TABLES in magazin;

#Creati o tabela

CREATE TABLE `magazin`.`produse`
( `idprodus` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
`numep` VARCHAR(200) NOT NULL ,
`cantitate` INT NOT NULL ,
`idfirma` INT UNSIGNED NOT NULL ,
`firma` VARCHAR(200) NOT NULL ,
`adresafirma` INT(250) NOT NULL ,
`modelp` VARCHAR(250) NOT NULL ,
`stocp` SMALLINT NOT NULL ,
`pret` DECIMAL(6,2) NOT NULL ,
`categoriep` VARCHAR(200) NOT NULL ,
`descrierep` TEXT NOT NULL ,
`data_addp` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ,
PRIMARY KEY (`idprodus`)
) ENGINE = InnoDB CHARSET=utf8 COLLATE utf8_general_ci;

-- creati un tabele pe baza altui tabel
CREATE TABLE produse2 LIKE produse;

#Verificati tabelele definite in baza de date
USE magazin;
SHOW TABLES;
#sau
SHOW TABLES in magazin;
#sau
SHOW TABLES FROM magazin;

#Prezentati structura tabelei
DESCRIBE produse;
-- sau folosind doar primele 4 litere din comanda
DESC produse;
#sau
SHOW COLUMNS FROM produse;
#puteti prezenta doar structura unei singure coloane
DESCRIBE produse.idprodus;

-- stergerea unei coloane
-- ALTER TABLE nume_tabel DROP COLUMN nume_coloana
ALTER TABLE produse DROP COLUMN firma;
-- Adaugarea unei coloane
-- ALTER TABLE nume_tabel ADD nume_coloana tip;
ALTER TABLE `produse` ADD `ts` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP AFTER `data_addp`;

# redenumeste coloana numita 'dat' cu numele 'data'
ALTER TABLE nume_tabel CHANGE dat data TEXT;	
# modifica tipul coloanei 'data' din 'TEXT' in coloana de tip 'DATE'
ALTER TABLE nume_tabel CHANGE data data DATE;

-- Valideaza valoarea unei coloane
-- ALTER TABLE nume_tabel ADD CHECK (nume_coloana >=18);
ALTER TABLE produse ADD CHECK (cantitate >=1);
-- Valideaza valoarile din doua coloane
-- ALTER TABLE nume_tabel ADD CONSTRAINT CHK_nume CHECK (nume_coloana >=18 AND nume_coloana2='Bucuresti');

#Stergeti tabela
DROP TABLE produse;

#Stergeti baza de date;
DROP DATABASE magazin;