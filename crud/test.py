#import the module
import config


def insert(con,cursor):
    #read values to be inserted
    sn=input("Nume:")
    sp=input("Prenume:")
    sa=input("An:")
    sg=input("Grupa:")
    sb=input("Bursa:")
    sd=input("Data nastere in format aaaa-ll-zz:")
    ssex = input("Sex, f sau m:")
    #create the Insert query
    sql = "INSERT INTO studenti (nume,prenume,an, grupa, bursa,data_nastere,sex) VALUES (%s, %s,%s, %s,%s, %s,%s)"
    #create list of values typed from user to insert in customer table
    val = (sn,sp,sa,sg,sb,sd,ssex)
    #Execute query with values
    cursor.execute(sql, val)
    #commit for permanent storage in database
    con.commit()
    #display success message
    print(cursor.rowcount, "Record inserted.")
    
    
def update(con,cursor):
    #read values to be updated
    sid=input("ID, unic pentru care dorim sa facem modificari:")
    sn=input("Nume:")
    sp=input("Prenume:")
    sa=input("An:")
    sg=input("Grupa:")
    sb=input("Bursa:")
    #create update query
    sql = "update studenti set nume='"+sn+"', prenume='"+sp+"',an='"+sa+"', grupa='"+sg+"', bursa='" +sb+"' where ID="+sid
    #Execute Update query on opened cursor
    cursor.execute(sql)
    #commit Changes to DB   
    con.commit()
    #display success message
    print(cursor.rowcount, "Record updated.")
    

def delete(con,cursor):
    #read the customer ID for which record to be deleted
    sid=input("Enter  ID :")
    #Create Delete Query
    sql = "delete FROM studenti where ID = '"+sid+"'"
    #execute delete query
    cursor.execute(sql)
    #commit changes to DB
    con.commit()
    #display success message
    print(cursor.rowcount, "Record deleted.")
    

def display(cursor):
    #Execute SELECT statement 
    cursor.execute("SELECT * FROM studenti")
    #Fetch all records from table
    res = cursor.fetchall()
    #print
    print("------------------------------------------------------------------------")
    print("ID   Nume    Prenume     An   Grupa   Status")
    print("------------------------------------------------------------------------")
          
    for x in res:
        print(str(x['id'])+"  "+str(x['nume'])+"  "+str(x['prenume'])+"  "+str(x['an'])+"  "+str(x['grupa'])+"  "+str(x['status']))
    print("------------------------------------------------------------------------")    
   
   

def main():
    #make connection to database
    con = config.connect()
   
    #opne cursor
    cursor = con.cursor(dictionary=True)
    ch=0
    #diaplay menu until user presses 5
    while(ch<=4):
        #menu options
        print("1. INSERT")
        print("2. UPDATE")
        print("3. DELETE")
        print("4. DISPLAY")
        print("5. EXIT")
        # ask user to enter what he wants to do
        ch=int(input("Ce doriti sa faceti? Introduceti cifra dorita:"))
        #call relevant fucntions defined above
        if (ch==1):
            insert(con, cursor)
        if (ch==2):
            update(con, cursor)
        if (ch==3):
            delete(con, cursor)
        if  (ch==4):
            display(cursor)
        
#call main
main()        
