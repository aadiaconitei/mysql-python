#import the module
import config
# creating database_cursor to perform SQL operation
#make connection to database
con = config.connect()
#open cursor
db_cursor = con.cursor(dictionary=True)
# executing cursor with execute method and pass SQL query
db_cursor.execute("CREATE DATABASE IF NOT EXISTS magazin2")
# get list of all databases
db_cursor.execute("SHOW DATABASES")
#print all databases
for db in db_cursor:
	print(db)