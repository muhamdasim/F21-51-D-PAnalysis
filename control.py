from DatabaseConnection import DatabaseConnection
import time
from scraper import Scraper
import pandas as pd
from collections import Counter
from models import Model
class Predicting():
    def __init__(self):
        self.queries = []
        self.db = DatabaseConnection()
    #model_prediction
    def predict(self, dataset, username):
        cursor, db = self.db.getFreshConnection()
        cursor.execute("select * from tweets WHERE username=%s", [username])
        data= cursor.fetchall()
        df= pd.DataFrame(data)

        #getting top 10 words
        tweets= df['content'].values.reshape(-1, 1)
        count_10 = Counter(" ".join(df["content"]).split()).most_common(10)

        
        if(dataset=="humour"):
            model = Model()
            model.addModel("static/models/humour_en/saved_model/random_forest.joblib")
            # model.addModel("static/models/humour_en/saved_model/svm.joblib")
            output=model.predict(df)
            output1=output.transpose()
            output1=output1.rename({0: 'Neutral', 1: 'Funny', 2: 'Neutral'}, axis='columns')
            output1["max"] = output1.idxmax(axis=1)
            output1["tweet"]= tweets
            
            final=output1['max'].value_counts()
            return count_10, final, output1
        elif(dataset=="hatespeech_offensive"):
            model = Model()
            model.addModel("static/models/hatespeech_offensive/saved_model/random_forest.joblib")
            # model.addModel("static/models/hatespeech_offensive/saved_model/svm.joblib")
            output=model.predict(df)
            output1=output.transpose()
            output1=output1.rename({0: 'Hate Speech', 1: 'Offensive', 2: 'Neutral'}, axis='columns')
            output1["max"] = output1.idxmax(axis=1)
            output1["tweet"]= tweets
            final=output1['max'].value_counts()
            return count_10, final, output1
        elif(dataset=="negative_positive_neutral"):
            model = Model()
            model.addModel("static/models/negative_positive_neutral_en/saved_model/random_forest.joblib")
            # model.addModel("static/models/negative_positive_neutral_en/saved_model/svm.joblib")
            output=model.predict(df)
            output1=output.transpose()
            output1=output1.rename({0: 'Neutral', 1: 'Positive', 2: 'Negative', 3: 'Mixed'}, axis='columns')
            output1["max"] = output1.idxmax(axis=1)
            output1["tweet"]= tweets

            final=output1['max'].value_counts()
            return count_10, final, output1


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
