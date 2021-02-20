#import the module
import sys
sys.path.append('../config')
# creating database_cursor to perform SQL operation
db_cursor = cursor(connect.)
# executing cursor with execute method and pass SQL query
db_cursor.execute("CREATE DATABASE IF NOT EXISTS universitate")
# get list of all databases
db_cursor.execute("SHOW DATABASES")
#print all databases
for db in db_cursor:
	print(db)