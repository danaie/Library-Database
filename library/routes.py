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

'''@app.route("/signup", methods=['GET', 'POST'])
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
    return render_template('signup.html', form=form)'''

@app.route("/signup", methods=['GET', 'POST'])
def signup():
    if not session.get('username'):
        cur = db.connect.cursor()
        cur.execute("SELECT school_id, name FROM school_unit")
        sch = cur.fetchall()
        cur.close()
        schools = []
        for el in sch:
            schools.append(el)
        form = Signup_form()
        form.school.choices=schools
        if request.method=='POST':
            cur = db.connect().cursor()
            cur.execute("SELECT * FROM lib_user WHERE username=%s",(form.username.data,))
            user = cur.fetchone()
            if user:
                flash("Username not available")
                return render_template('signup.html', form=form)
            else:
                try:
                    cur.execute("INSERT INTO lib_user (username, password, school_id, first_name, last_name, birth_date, user_role) VALUES (%s,%s,%s,%s,%s,%s,%s);",
                                    (form.username.data,
                                    form.password.data,
                                    form.school.data,
                                    form.first_name.data,
                                    form.last_name.data,
                                    form.birth_date.data,
                                    's',))
                    db.connect.commit()
                    flash("""Sign up application has been sent to your school library manager.\n
                    Please wait for their approval.""")
                except Exception as e:
                    print("Problem inserting into db: " + str(e))
                    return render_template("signup.html", form=form)
        else:
            return render_template("signup.html", form=form)
    else:
        flash('You must be logged out in order to sign up')
    return redirect(url_for("home"))


@app.route("/login", methods=['GET', 'POST'])
def login():
    if not session.get('username'): 
        form = Login_form()
        if (request.method=='POST'):
            cur = db.connect.cursor()
            cur.execute("SELECT * FROM lib_user WHERE username=%s AND password=%s"
                        ,(request.form['username'],request.form['password'],))                
            user = cur.fetchone()
            if user:
                if user[9]:
                    flash("Your application is pending.")
                elif not user[8]:
                    flash("Your account has been deactivated.")
                else:
                    session['user_id'] = user[0]
                    session['username'] = user[1]
                    session['school_id'] = user[3]          
                    session['first_name'] = user[4]
                    session['last_name'] = user[5]
                    session['user_role'] = user[7]
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

'''
@app.route('/info/<isbn>')
def info(isbn):
    cur = db.connect.cursor()
    cur.execute("SELECT * FROM book_info WHERE ISBN = %s",(isbn,))
    book = cur.fetchall()
    cur.close()
    return render_template("info.html", book=book)
'''

@app.route('/search',methods=['GET', 'POST'])
def search():
    cur = db.connection.cursor()
    cur.execute("SELECT category_name FROM category")
    r = cur.fetchall()
    cat = [] # this gets passed into the SelectMultipleField() choices
    for el in r:
        cat.append(el[0])
    form = Search_form()
    form.category.choices = cat  
    if form.validate_on_submit():
        t = form.title.data
        a = form.author.data
        c = request.form.getlist('category')
        if t == "":
            t = '.*'
        if a == "":
            a = '.*'
        if c == []:
            c = '.*'
        else:
            c = ','.join(c)
        return redirect(url_for('search_for', t=t, a=a, c=c))
    return render_template('search.html', form=form)


@app.route('/search/for/<t>+<a>+<c>')
def search_for(t,a,c):
    cur = db.connection.cursor()
    query = "SELECT book_id, ISBN, title, copies FROM book_info WHERE school_id = %s AND REGEXP_LIKE(title,%s) AND REGEXP_LIKE(auth,%s) AND REGEXP_LIKE(cat,%s)"
    values = (session['school_id'], t, a, c,)
    cur.execute(query, values)
    data = cur.fetchall()
    cur.close()
    if data:
        return render_template('books_av.html', data = data)
    else:
        flash('No results availabe')
        return redirect(url_for('search'))


@app.route('/info/<int:book_id>')
def info(book_id):
    cur = db.connect.cursor()
    cur.execute("SELECT * FROM book_info WHERE book_id=%s",(str(book_id),))
    book = cur.fetchall()
    cur.execute("SELECT * from review_info WHERE book_id=%s",(str(book_id),))
    review = cur.fetchall()
    cur.close()
    return render_template("info.html", book=book, review = review)

@app.route('/reserve/<int:book_id>')
def reserve(book_id):
    cur = db.connect.cursor()
    cur.execute("UPDATE availability SET copies=copies-1 WHERE book_id=%s",((book_id),))
    db.connect.commit()
    cur.execute("INSERT INTO service (user_id, book_id, service_type) VALUES (%s, %s, %s)",
                (session.get('user_id'),
                 book_id,
                 'r',))
    db.connect.commit()
    cur.close()
    return redirect(url_for('books'))

@app.route('/applications')
def applications():
    if session.get('user_role') != 'l':
        flash("You do not have authorization to view this page.")
        return redirect(url_for("home"))
    else:
        cur = db.connect.cursor()
        cur.execute("SELECT username, first_name, last_name, birth_date, user_role from lib_user WHERE active=FALSE AND pending=TRUE")
        list = cur.fetchall()
        cur.close()
        return render_template("applications.html", list=list)
    
@app.route('/accept/<username>')
def accept(username):
    if session['user_role'] != 'l':
        flash("You do not have authorization to view this page.")
        return redirect(url_for("home"))
    else:
        cur = db.connect.cursor()
        cur.execute("UPDATE lib_user SET active=TRUE, pending=FALSE WHERE username=%s",(username,))
        db.connect.commit()
        cur.close()
        return redirect(url_for("applications"))

@app.route('/loans')
def loans():
    if session.get('user_role') != 'l':
        flash("You do not have authorization to view this page.")
        return redirect(url_for("home"))
    else:
        cur = db.connect.cursor()
        cur.execute("SELECT username, first_name, last_name, user_role from lib_user WHERE ")
        list = cur.fetchall()
        cur.close()
        return render_template('loans.html')

