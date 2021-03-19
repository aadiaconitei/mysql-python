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
    DETERMINISTIC

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

DROP TABLE IF EXISTS grade;
DROP FUNCTION IF EXISTS rezultate;