from flask import Flask
from flask_mysqldb import MySQL

app = Flask(__name__)

app.config['SECRET_KEY'] = 'secret'
app.config["WTF_CSRF_SECRET_KEY"] = ''
app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = ''
app.config['MYSQL_DB'] = 'library'
app.config['MYSQL_DATABASE_PORT'] = 3306

db = MySQL(app)

from library import routes
