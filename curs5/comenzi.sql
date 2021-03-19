
-- Rezolvari Aplicatia 1
##1
SELECT nume, prenume
FROM angajat;
 
SELECT concat(nume,' ',prenume)
FROM angajat;
 
SELECT concat_ws(' ',nume, prenume)
FROM angajat;
 
##2
SELECT nume, prenume
FROM angajat
ORDER BY nume, prenume ASC;
 
##3
SELECT nume, prenume
FROM angajat
ORDER BY nume, prenume DESC;
 
SELECT nume, prenume
FROM angajat
ORDER BY nume DESC, prenume DESC;
 
##4
SELECT nume, prenume
FROM angajat
ORDER BY departament_id DESC, salariu;
 
SELECT nume AS Nume, prenume AS Prenume, departament_id AS Dept, Salariu
FROM angajat
ORDER BY departament_id DESC, salariu;
 
##5
SELECT nume
FROM angajat
WHERE departament_id = 5;
 
 
SELECT angajat.nume
FROM angajat, departament
WHERE angajat.departament_id = departament.id
AND departament.nume = 'HR';
 
SELECT angajat.nume
FROM angajat JOIN departament
ON angajat.departament_id = departament.id
AND departament.nume = 'HR';
 
 
##7
SELECT angajat.nume
FROM angajat, departament
WHERE angajat.departament_id = departament.id
AND departament.nume <> 'HR';
 
SELECT angajat.nume
FROM angajat JOIN departament
ON angajat.departament_id = departament.id
AND departament.nume <> 'HR';
 
 
#8 Angajatii care au salariu mai mare de 3000 lei
SELECT nume, prenume
FROM angajat
WHERE salariu > 3000;
 
SELECT nume, prenume, salariu
FROM angajat
WHERE salariu > 3000;
 
#9 Angajatii care au salariul 3000 lei
SELECT nume, prenume, salariu
FROM angajat
WHERE salariu = 3000;
 
 
#10 Angajatii care au salariul intre 3000 si 5000 de lei (incluzand limitele)
SELECT nume, prenume, salariu
FROM angajat
WHERE salariu >= 3000 AND salariu <= 5000;
 
 
SELECT nume, prenume, salariu
FROM angajat
WHERE salariu BETWEEN 3000 AND 5000;
 
SELECT nume, prenume, salariu
FROM angajat
WHERE salariu > 3000 AND salariu < 5000;
 
#11 Angajatii care nu au manager
SELECT nume, prenume
FROM angajat
WHERE manager_id IS NULL;
 
#12 Angajatii ai carui manager are ID-ul  1
SELECT nume, prenume
FROM angajat
WHERE manager_id = 1;
 
 
#13 Angajatii ai carui manager este Toma Ion
SELECT nume, prenume
FROM angajat
WHERE manager_id IN
(SELECT id
FROM angajat
WHERE nume='Toma' AND prenume='Ion');
 
 
SELECT concat_ws(' ',a1.nume, a1.prenume) As Angajat, concat(a2.nume,' ',a2.prenume) as Manager
FROM angajat a1 JOIN angajat a2 ON
a1.manager_id = a2.id
WHERE a2.nume = 'Toma' AND a2.prenume = 'Ion';
 
 
 
#14 Angajatii care au salariu mai mare de 2500 lei si lucreaza la Backend
 
SELECT angajat.nume AS Angajat, departament.nume AS Departament, salariu AS Salariu
FROM angajat, departament
WHERE
(angajat.departament_id = departament.id
AND departament.nume = 'Backend')
AND salariu > 2500;
 
#15 Angajatii ai caror manager NU este Popa Ion si care au salariu mai mare de 4000 lei
 
SELECT nume, prenume, manager_id, salariu
FROM angajat
WHERE manager_id IS NULL
OR manager_id NOT IN
(SELECT id
FROM angajat
WHERE nume='Toma' AND prenume='Ion')
AND salariu > 4000;
 
 
## (de ce includem 'manager_id IS NULL' ?)
SELECT nume, prenume
FROM angajat
WHERE manager_id NOT IN
(SELECT id
FROM angajat
WHERE nume='Toma' AND prenume='Ion');
 
 
## aceeasi problema - nu includem acei angajati care nu au manager daca facem doar join
SELECT concat(a1.nume,' ',a1.prenume) As Angajat, concat(a2.nume,' ',a2.prenume) as Manager, a1.salariu
FROM angajat a1 INNER JOIN angajat a2
ON (a1.manager_id = a2.id)
WHERE ((a2.nume<>'Toma' OR a2.prenume<>'Ion')
AND a1.salariu > 1000);


-- sfarsit rezolvari aplicatia 1

-- variabile 
SELECT @my_var;
SET @my_var2 = 2;
SET @my_var3 := @my_var2; -- pentru variabile

select @my_var2, @my_var3;
select @my_var4 = 5;

SET @t1=1, @t2=2, @t3:=4;
SELECT @t1, @t2, @t3, @t4 := @t1+@t2+@t3;


SELECT @my_var1 := 7;


SELECT * FROM universitate.note;
SET @MIN = '1996-01-07 00:00:00';
SET @MAX = '2000-03-24 00:00:00';

UPDATE `student` 
SET `data_nastere` =  TIMESTAMPADD(SECOND, FLOOR(RAND() * TIMESTAMPDIFF(SECOND, @MIN, @MAX)), @MIN);


SET @MIN = '1960-04-30';
SET @MAX = '1980-04-30';
update profesor set data_nastere =  TIMESTAMPADD(SECOND, FLOOR(RAND() * TIMESTAMPDIFF(SECOND, @MIN, @MAX)), @MIN);

SELECT @n:=7, (@n*52+1) AS Nr_zile_an;

select @n = 7; -- atentie sa nu confundati = cu :=. In cazul = o sa se verifice valoarea de adevar a expresiei
	
    

SET
	@nr = 1,
	@nr_aleator = FLOOR(RAND()*100), 
    @maine  := CURDATE()  + INTERVAL 1 DAY;
-- valoarea unei variabile poate fi obţinută pe baza alteia sau pe baza vechii ei valori
SET      
	@nr2 = @nr + 6; 	

SET	
	@Scadenta = @maine + INTERVAL 60 DAY,
	@nr1 = @nr + 1,
	@nr2 = @nr2 + 1; -- cresterea valorii lui @nr2 cu 1
select 
	@nr+1,
		@nr1,
	@nr_aleator + 5 AS Nr3, 
		WEEKDAY(@MAINE) AS Maine1, 
    DAYOFWEEK(@MAINE) AS Maine2, 
		WEEKDAY(@MAINE-INTERVAL 1 DAY) AS AZI,
    @NR2 * 6,
		@NR2*@nr_aleator,
    @n * @nr_aleator,
		@SCADENTA;



-- ap2
## view dep4
CREATE VIEW dep4 
 AS SELECT  nume, prenume, salariu*12 SAL_ANUAL
     FROM   angajat
     WHERE  departament_id=4;

select * from dep4;
INSERT INTO angajat
(nume, prenume, departament_id, manager_id, salariu, angajare)
VALUES
('Tomaescu',    'Dan',    4, NULL, 9000, '2000-1-12'),
('Popescu',     'Marian',   4, 1, 4000, '2003-5-6');


-- ap3
-- view manager
CREATE VIEW manager AS SELECT
	concat(a1.nume,' ',a1.prenume) As Angajat, concat(a2.nume,' ',a2.prenume) as Manager, a1.salariu asSalariu FROM 
    angajat a1 INNER JOIN angajat a2
	ON (a1.manager_id = a2.id)
	WHERE ((a2.nume<>'Popa' OR a2.prenume<>'Ion')
	AND a1.salariu > 4000);

SELECT * from manager;

INSERT INTO angajat
(nume, prenume, departament_id, manager_id, salariu, angajare)
VALUES
('Vartop',    'Claudiu',    1, 1, 5000, '2000-1-12'),
('Topolescu',     'Vlad',   4, 1, 5500, '2003-5-6');

CREATE VIEW managerToma AS
SELECT nume, prenume
FROM angajat
WHERE manager_id IN
(SELECT id
FROM angajat
WHERE nume='Toma' );
SELECT * from managerToma;


PREPARE ps FROM 'SELECT * FROM angajat  WHERE nume=? AND prenume =?';
SET @x='Topolescu';
SET @y= 'Vlad';
EXECUTE ps USING @x, @y;

-- ap4

DELIMITER $$
	CREATE PROCEDURE salut( IN nume VARCHAR(100))
	BEGIN
		SELECT CONCAT('Bine ai venit ', nume, '! ');
		SET @nume = nume;
	
	END$$
DELIMITER ;

CALL salut('Mihai');
select @nume;
CALL salut('Sofia');
select @nume;



/* Instructiuni repetitive : REPEAT */
DROP TABLE IF EXISTS sumaNnumere;
CREATE TABLE sumaNnumere(numarul int, suma int);

DELIMITER WW
CREATE PROCEDURE EXEMPLU_REP(n int)
COMMENT 'returneaza suma tuturor numerelor de la 1 la n, numarul lor (n) si media aritmetica'

BEGIN 

	DECLARE suma INT UNSIGNED DEFAULT 0;		-- initializam o variabila pentru suma
    DECLARE numarul INT UNSIGNED DEFAULT 0;		-- initializam o variabila pentru numararea iteratiilor
	truncate sumaNnumere;
    
	REPEAT
		
        SET numarul = numarul + 1, 		-- numaram iteratiile (practic, cate numere adunam) pana la n numere
			suma = suma + numarul;  	-- suma numerelor
            
        insert into sumaNnumere VALUES(numarul, suma);		-- insereaza rezultatul fiecarei iteratii in tabel
        
	UNTIL numarul = n					-- cand ajunge la numarul n iese din bucla

	END REPEAT;
        
	SELECT Numarul, suma, suma / numarul AS media;		-- extragem rezultatul
    SELECT * FROM sumaNnumere;
    
END WW
DELIMITER ;

CALL EXEMPLU_REP(20);

select * from sumannumere;


-- functii
DELIMITER $
CREATE FUNCTION Varsta(data_nasterii date)
	RETURNS INT
    DETERMINISTIC
    COMMENT 'Returneaza varsta in ani'
BEGIN 
	
	IF MONTH(NOW()) > MONTH(data_nasterii) or 
		MONTH(NOW()) = MONTH(data_nasterii) AND DAY(NOW()) >= DAY(data_nasterii)THEN 
			RETURN YEAR(NOW())-YEAR(data_nasterii);
	ELSE RETURN YEAR(NOW())-YEAR(data_nasterii) - 1;
    end if;
END $
DELIMITER ;

select varsta('1977-06-11');
select nume, prenume, varsta(angajare) as ani_vechime from angajat;


/* Instructiunea decizionala IF */

DROP TABLE IF EXISTS grade;
DROP FUNCTION IF EXISTS rezultate;

CREATE TABLE grade(
	Nume TEXT,
	Nota INT(2),
    Calificativ ENUM('Admis','Respins','Exmatriculat'));
    
INSERT INTO grade(Nume, Nota) VALUES 
	('Vasile',5),
	('Maria',10),
	('Ion',8),
	('George',7),
	('Emanuel',4),
	('Dorel',3),
    ('Copiat',0),
	('Paul',9);

DELIMITER //    
CREATE FUNCTION Rezultate(Candidat TEXT)
    RETURNS ENUM('Admis', 'Respins', 'Exmatriculat') 
    COMMENT 'Acordare calificativ in functie de nota'
    DETERMINISTIC   -- produce acelasi rezultat 

BEGIN 
	DECLARE Scor int(2);
    
    SELECT Nota FROM grade WHERE nume=candidat limit 1 INTO Scor;
		-- nume este col din tabel, candidat este parametru functie
		
    IF Scor >=6 and scor <= 10	THEN RETURN 'Admis';
		ELSEIF 	Scor>0 AND Scor<6 THEN RETURN 'Respins';
		ELSE RETURN 'Exmatriculat';
    END IF; -- ATENTIE! return e specific functiilor

END //
DELIMITER ;
	-- verificam daca functioneaza

select rezultate('Maria');

UPDATE grade SET Calificativ= (Select rezultate(nume));
SELECT * FROM grade ORDER BY Calificativ ASC, nota DESC;


 /* Instructiuni repetitive : WHILE */

USE test;
DELIMITER $
CREATE PROCEDURE test_while(param1 DATE)
	COMMENT 'Returneaza tote datele din intervalul param1 pana in data curenta'

BEGIN 

	DECLARE d date DEFAULT param1;
        
    w: WHILE d <= curdate() DO
		               
        INSERT INTO t9 values(d);
        SET d = d + INTERVAL 1 DAY;
        
	END WHILE;
  END $
DELIMITER ;

CREATE TABLE t9 (data date);

call test_while(curdate()- interval 6 day);

select * from t9;

drop procedure if exists test_while;
drop table if exists t9;