from flask import Flask, render_template, request, flash, redirect, url_for, abort
from library.forms import Signup_form, Login_form
from library.configs import app


@app.route("/")
@app.route("/home")
def home():
	return render_template('home.html')

@app.route('/books')
def new():
    if session:
        cur = db.connect.cursor()
        cur.execute("SELECT ISBN, title, copies FROM school_books WHERE school_id=%s",(session['school_id'],))
        data = cur.fetchall()
        cur.close()
        return render_template("books_av.html",data=data)
    else:
        return render_template("home.html") #dummy

@app.route("/signup", methods=['GET', 'POST'])
def signup():
    cur = db.connect.cursor()
    cur.execute("SELECT name, school_id  FROM school_unit")
    r = cur.fetchall()
    school = [] # this gets passed into the SelectField() choices
    for el in r:
        school.append(el[0])
    form = Signup_form()
    form.school.choices = school
    if form.validate_on_submit():
    	flash('Account Created', 'success')
    	return redirect(url_for('home'))
    return render_template('signup.html', form=form)

@app.route("/login", methods=['GET', 'POST'])
def login():
    if not session.get('username'): 
        form = Login_form()
        if (request.method=='POST'):
            cur = db.connect.cursor()
            cur.execute("SELECT * FROM lib_user WHERE username=%s AND password=%s",(request.form['username'],request.form['password'],))                
            user = cur.fetchone()
            if user:
                session['username'] = user[1]
                session['school_id'] = user[3]          
                session['first_name'] = user[4]
                session['last_name'] = user[5]
                flash('You have been logged in', 'success')
                return redirect(url_for("home"))
            else:
                    flash('Login Unsuccesful')
                    return render_template('login.html', form=form)
        else:
            return render_template('login.html', form=form)
    else:
        flash('You are already logged in')
    return redirect(url_for("home"))


@app.route('/logout')
def logout():
    if session.get('username'):
        session.clear()
        flash('You have been logged out')
    else:
        flash("You are not logged in")
    return redirect(url_for('home'))


@app.route('/info/<isbn>')
def info(isbn):
    cur = db.connect.cursor()
    cur.execute("SELECT * FROM book_info WHERE ISBN = %s",(isbn,))
    book = cur.fetchall()
    cur.close()
    return render_template("info.html", book=book)


@app.route('/search',methods=['GET', 'POST'])
def search():
    cur = db.connect.cursor()
    cur.execute("SELECT category_name FROM category")
    r = cur.fetchall()
    cat = [] # this gets passed into the SelectMultipleField() choices
    for el in r:
        cat.append(el[0])
    form = Search_form()
    form.category.choices = cat  #category does not work
    if form.validate_on_submit(): 
        t = form.title.data
        a = form.author.data
        if form.title.data == "":
            t = '.*'
        elif form.author.data == "":
            a = '.*'
        return redirect(url_for('search_for',t=t,a=a))
    return render_template('search.html', form=form)


@app.route('/search/for/<t>+<a>')
def search_for(t,a):
    cur = db.connect.cursor()
    cur.execute("SELECT ISBN, title, copies FROM book_info WHERE school_id = %s AND REGEXP_LIKE(title,%s) AND REGEXP_LIKE(auth,%s)",(session['school_id'],t,a,))
    data = cur.fetchall()
    cur.close()
    if data:
        return render_template('books_av.html', data = data)
    else:
        flash('No results availabe')
        return redirect(url_for('search'))

