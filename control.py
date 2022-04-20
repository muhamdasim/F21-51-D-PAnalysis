from DatabaseConnection import DatabaseConnection
import time
from scraper import Scraper

class Predicting():
    def __init__(self):
        self.queries = []
        self.db = DatabaseConnection()

    def scrape(self, username):
        obj = Scraper(username)
        cursor, db = self.db.getFreshConnection()
        obj.populateUserData(cursor)
        obj.populateUserTweets(10, cursor)
        db.commit()
        self.db.close_connection(cursor, db)
    def predict(self):
        
        while(1):
            cursor, db = self.db.getFreshConnection()
            cursor.execute('''select * from query where status =1
            limit 1

            ''')


            row = cursor.fetchone()
               
            if(row is None):
                self.db.close_connection(cursor, db)
                print("sleeping")
                time.sleep(10)

                continue
            else:
                # a data exist to be scraped

                #change the status of the data
                

                
                cursor.execute("UPDATE `query` set status = 2 where id= %s",[row[0]])
                db.commit()
                self.db.close_connection(cursor, db)
                try:
                    
                    cursor, db = self.db.getFreshConnection()
                    cursor.execute("UPDATE `query` set status = 1 where id= %s",[row[0]])
                    db.commit()
                    self.db.close_connection(cursor, db)
                    self.scrape(row[2])
                except Exception as e:
                    cursor, db = self.db.getFreshConnection()
                    print("Exception")
                    print(e )
                    cursor.execute("UPDATE `query` set status = 3 where id= %s",[row[0]])
                    db.commit()
                    self.db.close_connection(cursor, db)



obj = Predicting()
obj.predict()
time.sleep(5)
