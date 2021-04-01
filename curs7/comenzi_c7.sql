
-- Aplicatia 1
-- Comenzi din linia de comanda a serverului MySQL.
-- Logare/Conexiune :  default utilizatorul root nu are parola.
/*
mysql
mysql -h host -u root -p
mysql -h host -u root -pParola
mysql -h host -u root -p nume_baza_de_date
*/
/*
-host este numele sau adresa IP a calculatorului pe care rulează serverul MySQL. –h host poate fi omisă. 
-root sau username este numele de user.
-opţiunea –p cere user-ului care se conectează să introducă parola corespunzătoare

Pas1 : Facem baza de date demodb
CREATE DATABASE demodb;

Pas2 : Facem un user nou demou ce se poate conecta localhost sau % de pe orice host (wildcard)
MySQL >= 5.7
CREATE USER 'demou'@'localhost' IDENTIFIED WITH mysql_native_password BY 'DemoU12345';
sau 
CREATE USER 'demou'@'%' IDENTIFIED WITH mysql_native_password BY 'DemoU12345';
MySQL  < 5.7
CREATE USER 'demou'@'localhost' IDENTIFIED BY 'DemoU12345';
sau
CREATE USER 'demou'@'%' IDENTIFIED BY 'DemoU12345' ;

Pas3 Alocam priviliegii userului demou pentru baza de date demodb
GRANT ALL PRIVILEGES ON demodb.* TO 'demou'@'localhost';


Pas4 Actualizam privilegiile  fara sa dam restart la server
FLUSH PRIVILEGES;
*/

--   Comenzi din linia de comanda MySQL (dupa ce v-ati logat si ati ajuns la un prompt MySQL).
-- Afiseaza o lista de baze de date
show databases;

use mysql;
show  tables;
select * from user;
update user set password=PASSWORD('new_password') where User='root';
flush privileges; --  Privilegiile intra in vigoare cu aceasta comanda fara a fi nevoie de restart

-- Drepturile specificate aici merg doar pentru baza de date specificate in coloana db_column.
show columns from db;

-- Tabelele tables_priv si columns_priv  Ofera drepturi asupra unei tabele sau asupra unor coloane dintr-o tabela. 
show columns from tables_priv;

-- Arata toate procesele MySQL
show full processlist;

-- Termina un proces (este nevoie de introducerea comenzii anterioare pentru a obtine PID): 
kill 4; -- $pid;



-- Aplicatia 2

 -- Etapele de lucru din prezentare 
 CREATE SCHEMA `bazadedate_test4` DEFAULT CHARACTER SET utf8 ;
 CREATE USER 'user_test4'@'localhost' IDENTIFIED BY 'test4';
 CREATE TABLE `bazadedate_test4`.`drepturi` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nume` VARCHAR(45) NULL,
  PRIMARY KEY (`id`));

 GRANT SELECT ON bazadedate_test4.drepturi TO 'user_test4'@'localhost';
 FLUSH PRIVILEGES;
use mysql;
select * from user;
-- ne deconectam si ne conectam cu noul user creat
select now();
select * from drepturi;
INSERT INTO drepturi (`id`, `nume`) VALUES ('1', 'test');


-- Putem vedea ce permisiuni are un anumit utilzator
show grants for 'user_test4'@'localhost';

DROP USER 'user_test4'@'localhost';



/*
-- Backup
-- Salvati/Exportati o baze de date: 
mysqldump -Q –add-drop-table $database > file.sql

-- Salvati baze de date multiple: 
mysqldump -Q –add-drop-table –databases $database1 $database2 > file.sql

-- Importati o baza de date (salvata anterior): 
mysql -p -u $username $databasename < file.sql

-- Importati baze de date multiple (salvate anterior): 
mysql -p u $username < file.sql
*/
-- Replicare
/*
Avem doua servere diferite si vrem sa configuram replicarea MySQL de tip Master-Slave.
Pentru acest exemplu vom folosi:
Server 1: 127.0.0.10 - Master (serverul principal)
Server 2: 127.0.0.22 - Slave (serverul secundar)


CONFIGURARE MASTER
Incepem cu adaugarea urmatoarelor linii in /etc/my.cnf 
Important: Aveti grija ca liniile introduse in config sa fie sub [mysql] sau [mysqld], si nu sub [mysql_safe]


[mysql] 
log-bin = /var/lib/mysql/mysql-bin
server-id = 1
sync-binlog = 1
binlog-format = mixed
relay-log = mysqld-relay-bin
binlog_do_db            = replicare_db   # baza de date ce dorim sa fie replicata

-- restart server 
sudo service mysql restart

In prima faza creem baza de date si importam din backup daca e cazul:

CREATE DATABASE replicare_db; 
Daca e cazul, importam baza de date ruland:

mysql -u root replicare_db < replicare_backup.sql
Facem utilizatorul pe care il vom utiliza la replicare si actualizam:

GRANT REPLICATION SLAVE ON *.* TO 'slave_user'@'127.0.0.20' IDENTIFIED BY 'parola';
FLUSH PRIVILEGES;
Selectam baza de date si o blocam:

USE replicare_db;
FLUSH TABLES WITH READ LOCK;
Verificam statusul master-ului (ne va folosi mai incolo):

SHOW MASTER STATUS;
+------------------+----------+--------------+------------------+
| File             | Position | Binlog_Do_DB | Binlog_Ignore_DB |
+------------------+----------+--------------+------------------+
| mysql-bin.000001 |      107 | newdatabase  |                  |
+------------------+----------+--------------+------------------+

Facem dump la baza de date (aveti grija sa iesiti din mysql (exit sau Ctrl+C) si apoi rulati comanda de mai jos):

mysqldump -u root --opt replicare_db > replicare_backup.sql
Intram inapoi in MySQL si deblocam baza de date:

USE replicare_db;
UNLOCK TABLES;
QUIT;
Acum configurarea master-ului este completa. In continuare ne mutam pe celalalt server si configuram slave-ul.

CONFIGURARE SLAVE

Verificam in /etc/my.cnf sa avem optiunea 
server-id = 2 #(diferita de 0 care e default sau 1 care e masterul).
relay-log               = /var/log/mysql/mysql-relay-bin.log
log_bin                 = /var/log/mysql/mysql-bin.log
binlog_do_db            = replicare_db

sudo service mysql restart
In prima faza facem baza de date:

CREATE DATABASE replicare_db;
Iesim din MySQL si importam baza de date (la care am facut dump pe serverul principal):

mysql -u root replicare_db < replicare_backup.sql
Acum trebuie sa definim master-ul, astfel incat MySQL sa stie unde sa se conecteze pentru a face replicarea. 
Aici ne este de folos informatia afisata de SHOW MASTER STATUS; de mai devreme 
- inlocuim valorile de la MASTER_LOG_FILE si MASTER_LOG_POS cu cele afisate.

CHANGE MASTER TO
MASTER_HOST='127.0.0.10'   #'IP SERVER MASTER',
MASTER_USER='slave_user', 
MASTER_PASSWORD='parola', 
MASTER_LOG_FILE='mysql-bin.000001', 
MASTER_LOG_POS= 107;
Pornim slave-ul si verificam daca totul este in regula:

start slave;
show slave status \G;
Daca totul a decurs normal, acum orice modificari in baza de date pe serverul principal (Master) vor fi imediat vizibile si pe Slave.


-- pentru probleme de conexiune putem seta:
SET GLOBAL SQL_SLAVE_SKIP_COUNTER = 1; SLAVE START;

 -- conexiune remote
 Testare daca este deschis portul 
 -- telnet 127.0.0.1 3306
 Adaugare acces
 -- iptables -A INPUT -i eth0 -p tcp -m tcp --dport 3306 -j ACCEPT
 -- GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'password' WITH GRANT OPTION;
 -- FLUSH PRIVILEGES;
 -- SELECT host,user,authentication_string FROM mysql.user;