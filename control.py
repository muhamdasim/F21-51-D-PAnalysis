from DatabaseConnection import DatabaseConnection
import time


class Predicting():
    def __init__(self):
        self.queries = []
        self.db = DatabaseConnection()

    def scraper(self):
        
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
                    time.sleep(120)
                    cursor, db = self.db.getFreshConnection()
                    cursor.execute("UPDATE `row` set status = 1, last_scraped=CURRENT_TIMESTAMP where query_id= %s",[row[0]])
                    db.commit()
                except Exception as e:
                    cursor, db = self.db.getFreshConnection()
                    print("Exception")
                    print(e )
                    cursor.execute("UPDATE `row` set status = 3 where query_id= %s",[row[0]])
                    db.commit()
                self.db.close_connection(cursor, db)



obj = Predicting()
obj.scraper()
time.sleep(5)
