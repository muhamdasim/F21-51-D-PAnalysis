from MySQLdb import Connect, connect
from flask_mysqldb import MySQL
import MySQLdb.cursors

class DatabaseConnection(object):
    
    def __init__(self, app, host, user, password, db):
        self.host = host 
        self.user = user 
        self.password = password 
        self.db = db 
        app.config['MYSQL_HOST'] = self.host
        app.config['MYSQL_USER'] = 'root'
        app.config['MYSQL_PASSWORD'] = ''
        app.config['MYSQL_DB'] = 'fyp'
        self.mysql = MySQL(app)
        self.app = app

    def getFreshConnection(self):
        cursor = self.mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        return cursor

    def setHost(self, host):
        self.host = host 
    def getHost(self):
        return self.host 
    def setUser(self, user):
        self.user = user 
    def getUser(self):
        return self.user 
    
    def setPassword(self, password):
        self.password = password 
    def getPassword(self):
        return self.password

    def setDb(self, db):
        self.db = db 
    def getDb(self):
        return self.db
    
    def queryAll(self, query, val):
        self.mysql.init_app(self.app)
        connection = self.mysql.connect()
        cursor = connection.cursor()
        cursor.execute(query, val)
        lst = cursor.fetchall()
        connection.close()
        return lst
    
    def queryOne(self, query, val):
        self.mysql.init_app(self.app)
        connection = self.mysql.connect()
        cursor = connection.cursor()
        cursor.execute(query, val)
        lst = cursor.fetchone()
        connection.close()
        return lst
    
    def query(self, query, val):
        self.mysql.init_app(self.app)
        connection = self.mysql.connect()
        cursor = connection.cursor()
        cursor.execute(query, val)
        connection.close()
        

