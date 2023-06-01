from flask import Flask
from flask_mysqldb import MySQL

app = Flask(__name__)
app.config['SECRET_KEY'] = '7d08dab940ec78d6b8dd74864dab85f4'
app.config["MYSQL_HOST"] = '' #fill your host-name
app.config["MYSQL_USER"] = '' #fill your username
app.config["MYSQL_PASSWORD"] = '' #fill your password
app.config["MYSQL_DB"] = 'library'
db = MySQL(app)

from library import routes
