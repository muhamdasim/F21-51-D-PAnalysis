# importing libraries and packages
import imp
import snscrape.modules.twitter as sntwitter
import pandas as pd
from datetime import datetime
from DatabaseConnection import DatabaseConnection as DB

import re
def remove_emoji(string):
    emoji_pattern = re.compile("["
                           u"\U0001F600-\U0001F64F"  # emoticons
                           u"\U0001F300-\U0001F5FF"  # symbols & pictographs
                           u"\U0001F680-\U0001F6FF"  # transport & map symbols
                           u"\U0001F1E0-\U0001F1FF"  # flags (iOS)
                           u"\U00002702-\U000027B0"
                           u"\U000024C2-\U0001F251"
                           "]+", flags=re.UNICODE)
    return emoji_pattern.sub(r'', string)


class Scraper():
    def __init__(self, userName):
        self.userName = userName
        self.profileURL = None
        self.name = None
        self.followersCount = None
        self.desc = None
        self.location = None
        self.profileImage = None
        self.isVerified = None

    def populateUserData(self):
        for i in sntwitter.TwitterSearchScraper('from:' + self.userName).get_items():
            self.profileURL = 'https://twitter.com/' + self.userName
            self.name = i.user.displayname
            self.followersCount = i.user.followersCount
            self.desc = i.user.description
            self.location = i.user.location
            self.profileImage = i.user.profileImageUrl
            self.isVerified = i.user.verified
            break
        # db.setUser(self.userName, self.profileURL, self.profileImage, self.name, self.desc, self.location,
        #            self.followersCount, self.isVerified)

        #db.execute("REPLACE INTO `users_profile` (`username`, `profileURL`, `profileImage`, `name`, `description`, `location`, `followersCount`, `isVerified`) VALUES (%s, %s, %s, %s, %s, %s, %s, %s)",(self.userName, self.profileURL, self.profileImage, self.name, self.desc, self.location,self.followersCount, self.isVerified))

    def populateUserTweets(self, noOfTweets):
        # Creating list to append tweet data
        tweets_list1 = []
        for i, tweet in enumerate(
                sntwitter.TwitterSearchScraper('from:' + self.userName).get_items()):  # declare a username
            if i > noOfTweets:  # number of tweets you want to scrape
                break
            tweets_list1.append(
                [tweet.date, tweet.id, tweet.content, tweet.user.username,tweet.media])  # declare the attributes to be returned

        # Creating a dataframe from the tweets list above
        tweets_df1 = pd.DataFrame(tweets_list1, columns=['Datetime', 'Tweet Id', 'Text', 'Username','Media'])
        for index, i in tweets_df1.iterrows():
            date_time_obj = datetime.strptime(str(i['Datetime'])[:19], '%Y-%m-%d %H:%M:%S')
            print(i['Tweet Id'], i['Text'].encode('ascii', 'ignore'), date_time_obj, i['Username'],i['Media'])
            #db.execute("INSERT INTO `tweets` (`id`, `tweetID`, `content`, `tweetTS`, `username`) VALUES (NULL, %s, %s, %s, %s)",(i['Tweet Id'], i['Text'].encode('ascii', 'ignore'), date_time_obj, i['Username']))
            # db.setTweets(i['Tweet Id'], i['Text'].encode('ascii', 'ignore'), date_time_obj, i['Username'])
        #db.execute("update query set status=1 where status=0 and keyword=%s;", [self.userName])
        print("All Tweets Added to DB")

    def display(self):
        print(self.userName)
        print(self.profileURL)
        print(self.name)
        print(self.followersCount)
        print(self.desc)
        print(self.location)
        print(self.profileImage)
        print(self.isVerified)


# Initiate connection to the databse.

username = 'habib_tweets'
obj = Scraper(username)
#obj.populateUserData()
obj.populateUserTweets(3)