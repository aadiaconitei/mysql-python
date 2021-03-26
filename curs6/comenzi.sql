-- Ap1

USE universitate;
DELIMITER //
CREATE PROCEDURE list_curs( IN var1 INT) 
BEGIN   
    DECLARE start INT unsigned DEFAULT 1;  
    SELECT titlu_curs FROM cursuri WHERE id_curs BETWEEN start AND var1 order by id_curs; 
END; //
DELIMITER ;
CALL list_curs(13);

-- cu doua variabile
DELIMITER //
CREATE PROCEDURE list_curs2( IN var1 INT,IN var2 INT) 
BEGIN   
    SELECT titlu_curs FROM cursuri WHERE id_curs BETWEEN var1 AND var2 order by id_curs; 
END; //
DELIMITER ;
CALL list_curs2(13, 16);


--  SELECT cu CASE

SELECT 
    *,
    CASE
        WHEN n.valoare < 7 THEN 'Atentie mergi la biblioteca'
        WHEN n.valoare >= 7 AND n.valoare < 9 THEN 'Binisor'
        ELSE 'FB'
    END
FROM
    studenti s
        LEFT JOIN
    note n ON s.id = n.id_student
WHERE
    s.id = 111;

-- functii
-- Ap2

-- 1
use firma;

DELIMITER //
CREATE FUNCTION count_salariu (prag INT)
 RETURNS INT
 DETERMINISTIC
 COMMENT 'Functia returneaza numarul de angajati cu salariul mai mare decat pragul specificat'
BEGIN
 DECLARE nr INT;
 SELECT COUNT(id) FROM angajat WHERE salariu >= prag INTO nr;
 RETURN nr;
END; //
DELIMITER ; 
SET @s := 5000;
SELECT count_salariu(@s);
SELECT COUNT(id) FROM angajat WHERE salariu>=5000;



-- 2
-- calcumeaza varsta/ vechimea
DELIMITER $
CREATE FUNCTION Varsta(data_nasterii date)
	RETURNS INT
    DETERMINISTIC
    COMMENT 'Returneaza varsta in ani'
BEGIN 
	
	IF ( MONTH(NOW()) > MONTH(data_nasterii) or MONTH(NOW()) = MONTH(data_nasterii) )
			AND DAY(NOW()) >= DAY(data_nasterii)THEN 
		RETURN YEAR(NOW())-YEAR(data_nasterii);
	ELSE 
		RETURN YEAR(NOW())-YEAR(data_nasterii) - 1;
    end if;
END $
DELIMITER ;

select varsta('1977-06-11');
select nume, prenume, varsta(angajare) as ani_vechime from angajat;

-- 3
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
    ('Ema',4),
	('Dan',3),
    ('Copiator',1),
	('Tudor',4),
	('Andrei',3),
	('Paul',9);

DELIMITER //    
CREATE FUNCTION Rezultate(Candidat TEXT)
    RETURNS ENUM('Admis', 'Respins', 'Exmatriculat') 
    COMMENT 'Acordare calificativ in functie de nota'
    DETERMINISTIC   -- produce acelasi rezultat 
BEGIN 
	DECLARE Scor int(2);
    SELECT Nota FROM grade WHERE nume=candidat limit 1 INTO Scor; -- variabila Scor  primeste valoarea Nota
		-- nume este col din tabel, candidat este parametru functie
		
    IF Scor >=6 and scor <= 10	THEN 
		RETURN 'Admis';
	ELSEIF 	Scor>0 AND Scor<6 THEN 
        RETURN 'Respins';
	ELSE 
		RETURN 'Exmatriculat';
    END IF; -- ATENTIE! return e specific functiilor
END //
DELIMITER ;

select rezultate('Maria');

UPDATE grade SET Calificativ= (Select rezultate(nume));
SELECT * FROM grade ORDER BY Calificativ ASC, nota DESC;

--4
-- instructiunea repetitiva  

DELIMITER //
CREATE FUNCTION factorial (n DECIMAL(3,0))
 RETURNS DECIMAL(20,0)
 DETERMINISTIC
BEGIN
 DECLARE factorial DECIMAL(20,0) DEFAULT 1;
 DECLARE counter DECIMAL(3,0); 
 SET counter := n; 
 factorial_loop: REPEAT
		SET factorial := factorial * counter;
		SET counter := counter - 1;
		UNTIL counter = 1 END
	REPEAT;
	RETURN factorial;
END; //
DELIMITER ; 

select factorial(5);
-- 5
-- WHILE   - genereaza parola de lungime n

DELIMITER //
CREATE FUNCTION RandString (n INT) 
RETURNS VARCHAR (100)
BEGIN
	SET @str := " ";
    SET @allowedChars := 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    SET @i = 0;
    WHILE (@i < n) DO
        SET @str = CONCAT(@str, substring(@allowedChars, FLOOR(RAND() * LENGTH(@allowedChars) + 1), 1));
        SET @i = @i + 1;
    END WHILE;

    RETURN @str;
END; //
DELIMITER ; 

SELECT RANDSTRING(12);

SHOW FUNCTION STATUS ;


-- cursoare
--Ap3
use universitate;
DROP PROCEDURE IF EXISTS selectie;
DROP TABLE IF EXISTS SuperNote;

DELIMITER //
CREATE PROCEDURE Selectie() 
BEGIN
	DECLARE n,p VARCHAR(100);
    DECLARE v INT;
	DECLARE supernote CURSOR FOR 				-- declaram cursorul
		SELECT s.nume, s.prenume, n.valoare FROM student s left join note n on s.id= n.id_student
        WHERE n.valoare>8 LIMIT 50;
	DECLARE EXIT HANDLER FOR 1329 BEGIN END;	-- declaram handler specific erorii de terminarea cursorului
	OPEN supernote;								-- deschidem cursorul
	
	bucla: LOOP

		FETCH supernote INTO n, p, v;					-- apelam fiecare inregistrare din result set
			IF v >8  THEN ITERATE bucla;	-- ducem valorile inregistrarii in variabilele n, p, v
			END IF;										-- cu exceptia celor cu v <=8	

		INSERT INTO SuperNote VALUES(n,p,v);		-- valorile fiecarei inregistrari sunt prelucrate
    
	END LOOP;

	CLOSE supernote;								-- inchidem cursorul

END;//    
DELIMITER ;

CREATE TABLE SuperNote(`nume` varchar(100),
	`prenume` varchar(100), `valoare` INT);

CALL selectie;

SELECT * FROM SuperNote;

--Ap4
-- declansatori --triggers
DELIMITER //
CREATE TRIGGER note_AFTER_INSERT AFTER INSERT ON `note` FOR EACH ROW
BEGIN
  DECLARE n,p VARCHAR(100);
  IF NEW.valoare >= 8 THEN
    SELECT nume,prenume FROM student WHERE id = NEW.id_student INTO n, p;
	INSERT INTO SuperNote VALUES(n,p,NEW.valoare);
  END IF;
END;//
DELIMITER ;



--Ap5
-- tranzactii
-- Ne asiguram ca tabelul este InnoDB
START TRANSACTION;
INSERT INTO student VALUES ('130', 'Ion', 'Ion','1997-08-21','m',1, 2,250,'admis');
SELECT * FROM student;  
-- in timpul tranzacţiei clientul initiator vede efectele ei, insa alti clienti nu
			-- (putem verifica deschizand in paralel o alta conexiune cu serverul)
COMMIT; -- modificarile au fost facute definitiv 
SELECT * FROM student;


-- alta aplicatie 
use firma;
CREATE TABLE conturi(
		id int AUTO_INCREMENT UNIQUE,
        NR_CONT CHAR(4),
        Sold DECIMAL(20,2) DEFAULT 0,
        Client VARCHAR(100) );

INSERT INTO conturi(NR_CONT, sold, client)  VALUES
		('A001', 150000, 'Vasile'),
        ('B002', 2000000, 'Ion'),
        ('X999', 0, 'Furnizor');
        
START TRANSACTION;

/* Vasile achita 30000 catre Ion */

update conturi SET SOLD = SOLD - 30000 WHERE CLIENT='VASILE';
update conturi SET SOLD = SOLD + 30000 WHERE CLIENT='ION';

SELECT * FROM conturi;

SAVEPOINT prima_tranzactie;

/* vasile achita catre un furnizor cu cont la alta banca 200000 lei */

update conturi SET SOLD=SOLD - 200000 WHERE nr_cont='a001';
update conturi SET SOLD=SOLD + 200000 WHERE nr_cont='x999';

SELECT * FROM conturi;

ROLLBACK TO prima_tranzactie;

COMMIT;
