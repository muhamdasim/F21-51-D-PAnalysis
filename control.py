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

    #it takes a username as argument, fetch tweets from the database
    # call the model class
    # record predictions and insert back into database
    def make_prediction(self, username):
        cursor, db = self.db.getFreshConnection()
        cursor.execute("select * from tweets WHERE username=%s", [username])
        data= cursor.fetchall()
        self.db.close_connection(cursor, db)

        df= pd.DataFrame(data)

        #getting top 10 words
        ids= df['id'].values.reshape(-1,1)
        count_10 = Counter(" ".join(df["content"]).split()).most_common(10)
        # create a model object
        model = Model()
        model.addModel("static/models/humour_en/saved_model/random_forest.joblib")


        # analysing humour prediction first 
        humour_df=model.predict(df)
        humour_df=humour_df.transpose()
        humour_df=humour_df.rename({0: 'Neutral', 1: 'Funny', 2: 'Neutral'}, axis='columns')
        output = pd.DataFrame()
        output["humour"] = humour_df.idxmax(axis=1)
        output["tweet_id"]= ids


        # hatespeech offensive prediction
        model = Model()
        model.addModel("static/models/hatespeech_offensive/saved_model/random_forest.joblib")
        hatespeech_offensive=model.predict(df)
        hatespeech_offensive=hatespeech_offensive.transpose()
        hatespeech_offensive=hatespeech_offensive.rename({0: 'Hate Speech', 1: 'Offensive', 2: 'Neutral'}, axis='columns')
        # appendinge hatespeech_offensive to existing dataframe
        output["hatespeech_offensive"] = hatespeech_offensive.idxmax(axis=1)


        # negative positive neutral prediction
        model = Model()
        model.addModel("static/models/negative_positive_neutral_en/saved_model/random_forest.joblib")
        negativePositiveNeutral=model.predict(df)
        negativePositiveNeutral=negativePositiveNeutral.transpose()
        negativePositiveNeutral=negativePositiveNeutral.rename({0: 'Neutral', 1: 'Positive', 2: 'Negative', 3: 'Mixed'}, axis='columns')
        output["negative_positive_neutral"] = negativePositiveNeutral.idxmax(axis=1)

        cursor, db = self.db.getFreshConnection()
        
        cols = "`,`".join([str(i) for i in output.columns.tolist()])

        # Insert DataFrame recrds one by one.
        for i,row in data.iterrows():
            sql = "INSERT INTO `tweets_prediction` (`" +cols + "`) VALUES (" + "%s,"*(len(row)-1) + "%s)"
            cursor.execute(sql, tuple(row))

        # the connection is not autocommitted by default, so we must commit to save our changes
        db.commit()
        self.db.close_connection(cursor, db)


    
    

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
                    self.make_prediction(row[2])
                    cursor, db = self.db.getFreshConnection()
                    cursor.execute("UPDATE `query` set status = 4 where id= %s",[row[0]])
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
