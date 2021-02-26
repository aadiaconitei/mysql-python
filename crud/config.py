#import the module
import mysql.connector
def connect():
    return  mysql.connector.connect( 
            host="localhost",
            user="root",
            passwd="",
            database="universitate"
            )