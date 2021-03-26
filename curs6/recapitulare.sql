-- recapitulare 1
-- 1
CREATE VIEW backend_view AS
SELECT a.nume AS Angajat, d.nume AS Departament, a.salariu AS Salariu
FROM angajat AS a INNER JOIN departament AS d ON a.departament_id = d.id AND d.nume = 'Backend'
WHERE a.salariu > 2500;
-- 2
SELECT table_name, is_updatable FROM information_schema.views WHERE table_name = 'backend_view';
SELECT * from  backend_view;
-- 3
SELECT * FROM firma.angajat;
-- 4
UPDATE backend_view SET salariu = salariu + ( salariu * 0.15 ) WHERE salariu > 5600;
-- 5
SELECT * from  backend_view;
-- 6 // se schimba valoarea si in Tabela angajat
SELECT * FROM firma.angajat;
-- Error Code: 1395. Can not delete from join view 'firma.backend_view'
DELETE FROM backend_view  WHERE angajat = 'Tomaescu';

-- recapitulare 2

CREATE VIEW total_view AS
SELECT d.nume, sum(a.salariu) as total  FROM angajat AS a INNER JOIN departament  AS  d  ON a.departament_id = d.id 
GROUP BY a.departament_id ORDER BY total desc;

SELECT table_name, is_updatable FROM information_schema.views WHERE table_name = 'total_view';
SELECT * from  total_view;

-- Error Code: 1288. The target table total_view of the UPDATE is not updatable
UPDATE total_view SET nume = 'IT_2' WHERE nume = 'IT';

-- recapitulare 3  Test  IN OUT INOUT

SET @departament = 7;
DROP procedure IF EXISTS `departament_procedure`;

DELIMITER $$
USE `firma`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `departament_procedure`(IN n INT)
BEGIN
 SELECT * FROM angajat WHERE departament_id = n;
 SET n = 50;
 
END$$

DELIMITER ;
CALL departament_procedure(@departament);
SELECT @departament;

-- recapitulare  
-- Sa se determine termenul de pe pozitia n din sirul lui Fibonacci
CREATE PROCEDURE fibonacci_1(n INT,OUT out_fib INT)

BEGIN
  DECLARE m INT DEFAULT 0;
  DECLARE k INT DEFAULT 1;
  DECLARE i INT;
  DECLARE tmp INT;

  SET m=0;
  SET k=1;
  SET i=1;

  WHILE (i<=n) DO
    SET tmp=m+k;
    SET m=k;
    SET k=tmp;
    SET i=i+1;
  END WHILE;
  SET out_fib=m;
 END

 CALL fibonacci_1(5,@a);
SELECT @a;

