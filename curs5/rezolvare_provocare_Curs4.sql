###Creare tabele
 
#Tabela adrese
CREATE TABLE IF NOT EXISTS adresa
(id int unique auto_increment primary key,
strada char(20),
oras char(20));
 
#Tabela clienti
CREATE TABLE IF NOT EXISTS client
(id int unique auto_increment primary key,
denumire char(50),
adresa_id int,
INDEX (adresa_id),
FOREIGN KEY (adresa_id) REFERENCES adresa(id));
 
#Tabela comenzi
 CREATE TABLE IF NOT EXISTS comanda
(id int unique auto_increment primary key,
data date,
client_id int,
INDEX (client_id),
FOREIGN KEY (client_id) REFERENCES client(id));
 
#Tabela articole
 CREATE TABLE IF NOT EXISTS articol
(id int unique auto_increment primary key,
descriere char(40),
pret  float);
 
# Tabela de legatura dintre comenzi si articole (un articol poate sa apara in mai multe comenzi, o comanda are mai
#multe articole
 CREATE TABLE IF NOT EXISTS comanda_articol
(id int unique auto_increment primary key,
comanda_id int,
articol_id int,
cantitate int,
INDEX (comanda_id),
INDEX (articol_id),
FOREIGN KEY (comanda_id) REFERENCES comanda(id),
FOREIGN KEY (articol_id) REFERENCES articol(id));
-- Popularea tabelelor cu date

INSERT INTO adresa (strada, oras) VALUES
('Magheru', 'Bucuresti'),
('Brasov',  'Bucuresti'),
('Elisabeta', 'Bucuresti'),
('Maniu', 'Brasov'),
('Aviatorilor', 'Bucuresti'),
('Balcescu', 'Buzau'),
('Mihalache', 'Bucuresti'),
('Horea', 'Cluj Napoca'),
('Macaralei', 'Barlad'),
('Minerului', 'Petrosani');
 
##
INSERT INTO client (denumire, adresa_id) VALUES
('SC LEON SRL', 1),
('GEOMIL', 2),
('LIBERTY', 3),
('MINERON', 10),
('AEROFUN', 4),
('MEDITEL', 5);
 
##
INSERT INTO comanda (data, client_id) VALUES
('2007-4-8', 1),
('2007-4-8', 1),
('2007-4-7', 2),
('2008-4-8', 2),
('2008-4-9', 3),
('2008-4-8', 4),
('2008-4-8', 5);
 
##
INSERT INTO articol (descriere, pret) VALUES
('stilou', 5),
('pix bila', 4),
('creion', 0.5),
('marker', 2),
('guma', 0.75),
('rigla', 1),
('echer', 1),
('penar', 2),
('top hartie', 9.5),
('top hartie gloss', 9.5),
('cutie cerneala', 2.25);
 
##
INSERT INTO comanda_articol (comanda_id, articol_id, cantitate) VALUES
 
(1,1,10),
(1,2,10),
(1,3,10),
 
 
(2,4,2),
(2,5,4),
(2,6,12),
 
(3,8,20),
(3,5,42),
 
 
(4,1,20),
(4,2,40),
(4,3,20),
(4,4,40),
(4,5,20),
(4,6,20),
 
(5,1,100),
(5,7,200),
 
(6,2,25),
(6,6,25),
(7,3,100);
/*Exercitii
1.Calculati numarul de comenzi
2.Calculati numarul de adrese ale clientilor din Bucuresti
3.Calculati numarul de orase diferite din toate adresele
4.Calculati numarul de preturi deosebite dintre toate articolele
5.Calculati numarul de orase din toate adresele al caror nume incepe cu litere diferite
6.Care este pretul maxim al articolelor; care este cantitatea maxima de articole dintr-o comanda
7.Care este pretul minim al articolelor; care e cantitatea minima de articole dintr-o comanda
8.Care este pretul minim al articolelor al caror nume incepe cu 'p' ?
9.Care este pretul maxim al articolelor din comanda numarul 3 ?
10.Cate articole au cel mai mare pret ? Dar cel mai mic pret ?
11.Care este diferenta intre cel mai mare si mai mic pret (in bani) ?
12.Care este initiala clientului cu ultimul nume, in ordine alfabetica ?
13.Care este suma preturilor articolelor ?
14.Care este pretul total al comenzii cu numarul 3 ?
15.Calculati pretul mediu al articolelor. Calculati pretul mediu al articolelor, neponderat.
16.Calculati pretul mediu al comenzilor. Calculati pretul mediu al comenzilor, neponderat.
Rezolvari
*/
#(1)
SELECT count(*)
FROM  comanda;
 
#(2)
SELECT count(*)
FROM adresa
WHERE oras = 'Bucuresti';
 
#(3)
SELECT COUNT(oras)
FROM adresa;
 
SELECT COUNT(DISTINCT oras)
FROM adresa;
 
 
#(4)
SELECT COUNT(*)
FROM articol;
SELECT COUNT(pret)
FROM articol;
SELECT COUNT(DISTINCT pret)
FROM articol;
 
#(5)
SELECT DISTINCT SUBSTRING(oras,1,1)
FROM adresa;
SELECT COUNT(DISTINCT SUBSTRING(oras, 1, 1))
FROM adresa;
 
#(6)
SELECT MAX(pret)
FROM articol;
SELECT MAX(cantitate)
FROM comanda_articol;
 
#(7)
SELECT MIN(pret)
FROM articol;
SELECT MIN(cantitate)
FROM comanda_articol;
 
 
#(8)
SELECT MIN(pret)
FROM articol
WHERE SUBSTRING(descriere, 1, 1) = 'p';
 
#(9)
SELECT MAX(pret)
FROM articol, comanda_articol
WHERE comanda_articol.comanda_id = 3
AND comanda_articol.articol_id = articol.id;
 
SELECT descriere, pret, cantitate
FROM articol, comanda_articol
WHERE comanda_articol.comanda_id = 3
AND comanda_articol.articol_id = articol.id;
 
#(10)
SELECT COUNT(*)
FROM articol
WHERE pret =
    (SELECT MAX(pret) FROM articol);
 
SELECT COUNT(*)
FROM articol
WHERE pret =
    (SELECT MIN(pret) FROM articol);
 
 
#(11)
SELECT MAX(pret) - MIN(pret)
FROM articol;
 
#(12)
SELECT SUBSTRING(MAX(denumire), 1, 1)
FROM client;
 
#(13)
SELECT SUM(pret)
FROM articol;
 
#(14)
SELECT SUM( pret  *  cantitate)
FROM comanda_articol, articol, comanda
WHERE comanda_articol.articol_id = articol.id
AND comanda_articol.comanda_id = comanda.id
AND comanda.id = 3;
 
SELECT pret, cantitate, descriere, ( pret  *  cantitate)
FROM comanda_articol, articol, comanda
WHERE comanda_articol.articol_id = articol.id
AND comanda_articol.comanda_id = comanda.id
AND comanda.id = 3;
 
#(15)
SELECT AVG(pret)
FROM articol;
 
SELECT AVG(DISTINCT pret)
FROM articol;
 
#(16)
SELECT AVG(pret * cantitate)
FROM   comanda_articol, articol
WHERE comanda_articol.articol_id = articol.id;
 
SELECT AVG(DISTINCT (pret * cantitate))
FROM   comanda_articol, articol
WHERE comanda_articol.articol_id = articol.id;