from flask import Flask
from flask_mysqldb import MySQL

app = Flask(__name__)

app.config['SECRET_KEY'] = '7d08dab940ec78d6b8dd74864dab85f4'

from library import routes
