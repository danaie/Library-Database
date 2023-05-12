from flask import Flask, jsonify, render_template, request, redirect, url_for, session
import sqlite3
import os
from flask_mysqldb import MySQL

app = Flask(__name__)
app.secret_key = os.urandom(24)

app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = '12345'
app.config['MYSQL_DB'] = 'library'

mysql = MySQL(app)

@app.route('/')
def home():
    return render_template('home.html')

@app.route('/sign_up')
def sign_up():
    return render_template('sign_up.html')

@app.route('/submit_form', methods=['POST'])
def submit_form():

    if request.form['userrole'] == 'teacher':
         user_role = 't'
    elif request.form['userrole'] == 'student':
         user_role = 's'
    
    username = request.form['username']
    password = request.form['password1']
    school_id = request.form['schoolid']
    first_name = request.form['firstname']
    last_name = request.form['lastname']
    birth_date = request.form['birthdate']

    cur = mysql.connection.cursor()
    query = "INSERT INTO lib_user (username, password, school_id, first_name, last_name, birth_date, user_role) VALUES (%s, %s, %s, %s, %s, %s, %s)"
    values = (username, password, school_id, first_name, last_name, birth_date, user_role)
    cur.execute(query, values)
    mysql.connection.commit()
    cur.close()

    return redirect(url_for('home'))

@app.route('/sign_in')
def sign_in():
    return render_template('sign_in.html')

@app.route('/log_in', methods=['POST'])
def login():
    username = request.form['username']
    password = request.form['password']

    cur = mysql.connection.cursor()
    cur.execute("SELECT * FROM lib_user WHERE username = %s AND password = %s AND active = 1 AND pending = 0", (username, password))
    user = cur.fetchone()
    cur.close()

    if user:
        return render_template('library.html', user=user)
    else:
        error = 'Invalid username or password'
        return render_template('sign_in.html', error=error)

@app.route('/all_books')
def get_books():
    user_id = request.args.get('user_id')

    cur = mysql.connection.cursor()
    cur.execute("SELECT * FROM book")
    result = cur.fetchall()
    cur.close()
    return render_template('all_books.html', data = result, user_id=user_id)

@app.route('/user_books')
def user_books():
    user_id = request.args.get('user_id')

    cur = mysql.connection.cursor()

    query = """
    SELECT book.title, author.author_last_name, borrow_log.borrow_date
    FROM book
    JOIN book_author ON book.book_id = book_author.book_id
    JOIN author ON book_author.author_id = author.author_id
    JOIN borrow_log ON book.book_id = borrow_log.book_id
    WHERE borrow_log.user_id = %s
    """

    cur.execute(query, (user_id,))

    books = cur.fetchall()
    cur.close()
    return render_template('user_books.html', books=books)

@app.route('/service')
def service():
    book_id = request.args.get('book_id')
    user_id = request.args.get('user_id')

    cur = mysql.connection.cursor()

    availability_query = "SELECT copies FROM availability WHERE book_id = %s"
    update_service_query = "INSERT INTO service (user_id, book_id, service_type, service_date) VALUES (%s, %s, 'b', CURDATE())"
    update_borrow_log_query = "INSERT INTO borrow_log (user_id, book_id, borrow_date) VALUES (%s, %s, CURDATE())"
    decrease_copies_query = "UPDATE availability SET copies = copies - 1 WHERE book_id = %s"

    cur.execute(availability_query, (book_id,))
    copies = cur.fetchone()
    
    
    if copies and copies[0] > 0:
        cur.execute(update_service_query, (user_id, book_id))
        cur.execute(update_borrow_log_query, (user_id, book_id))
        cur.execute(decrease_copies_query, (book_id,))
        mysql.connection.commit()
        message = "You borrowed the book!"
    else:

        message = "There are no copies available, we will take care of your request as soon as possible"

    cur.close()
    return render_template('service.html', message=message)



if __name__ == "__main__":
    app.run(debug=True)