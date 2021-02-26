#import the module
import config
con = config.connect()
#open cursor
db_cursor = con.cursor(dictionary=True)
# executing cursor with execute method and pass SQL query
db_cursor.execute("USE magazin2")
db_cursor.execute("""CREATE TABLE `produse`
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
) ENGINE = InnoDB CHARSET=utf8 COLLATE utf8_general_ci;""")
db_cursor.execute("SHOW TABLES")
#print all databases
for tb in db_cursor:
	print(tb)