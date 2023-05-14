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
    #cur.execute("SELECT * from review_info WHERE book_id=%s",(str(book_id),))
    #review = cur.fetchall()
    cur.close()
    return render_template("info.html", book=book) #, review = review)


@app.route('/reserve/<int:book_id>')
def reserve(book_id):
    if session.get('user_role') not in ['s','t']:
        flash("You do not have authorization to view this page.")
        return redirect(url_for("home"))
    cur = db.connection.cursor()
    query = "SELECT count(*) from service WHERE user_id=%s AND service_type='r'"
    values = (session.get('user_id'),)
    cur.execute(query, values)
    res = int(cur.fetchone()[0])
    if session.get('user_role') == 's':
        lim = 2
    else:
        lim = 1
    if res >= lim:
        flash("You have exceeded the limit of reservations.")
        return redirect(url_for("books"))
    try:
        query ="UPDATE availability SET copies=copies-1 WHERE book_id=%s AND school_id=%s"
        values = (book_id, session['school_id'],)
        cur.execute(query, values)
    except Exception as e:
        flash("Not enough copies.")
        return redirect(url_for('books'))
    try:
        query = "INSERT INTO service (user_id, book_id, service_type) VALUES (%s, %s, %s)"
        values = (session.get('user_id'), book_id, 'r',)
        cur.execute(query, values)
    except Exception as e:
        flash("You have already reserved or are currently in possession of this title.")
        return redirect(url_for('books'))
    db.connection.commit()
    cur.close()
    flash("Your reservation has been registered.")
    return redirect(url_for('books'))



@app.route('/applications')
def applications():
    if session.get('user_role') not in ['l', 'a']:
        flash("You do not have authorization to view this page.")
        return redirect(url_for("home"))
    else:
        cur = db.connection.cursor()
        if session.get('user_role') == 'a':
            query = "SELECT user_id, username, first_name, last_name, birth_date, user_role from lib_user WHERE active=FALSE AND pending=TRUE AND user_role='l'"
            values = ()
        else:
            query = "SELECT user_id, username, first_name, last_name, birth_date, user_role from lib_user WHERE active=FALSE AND pending=TRUE AND school_id=%s"
            values = (session.get('school_id'),)
        cur.execute(query, values)
        list = cur.fetchall()
        cur.close()
        return render_template("applications.html", list=list)


@app.route('/applications/accept/<user_id>')
def accept_app(user_id):
    if session['user_role'] != 'l':
        flash("You do not have authorization to view this page.")
        return redirect(url_for("home"))
    else:
        cur = db.connection.cursor()
        query = "UPDATE lib_user SET active=TRUE, pending=FALSE WHERE user_id=%s"
        cur.execute(query, (user_id,))
        db.connection.commit()
        cur.close()
        return redirect(url_for("applications"))


@app.route('/applications/decline/<user_id>')
def decline_app(user_id):
    if session['user_role'] != 'l':
        flash("You do not have authorization to view this page.")
        return redirect(url_for("home"))
    else:
        cur = db.connection.cursor()
        query = "DELETE FROM lib_user WHERE user_id=%s"
        cur.execute(query, (user_id,))
        db.connection.commit()
        cur.close()
        return redirect(url_for("applications"))


@app.route('/reservations')
def reservations():
    if session.get('user_role') != 'l':
        flash("You do not have authorization to view this page.")
        return redirect(url_for("home"))
    else:
        cur = db.connection.cursor()
        query = "SELECT * from loan_app WHERE school_id=%s"
        cur.execute(query, (session.get('school_id'),))
        list = cur.fetchall()
        cur.close()
        return render_template('reservations.html', list=list)


@app.route('/reservations/accept/<user_id>+<book_id>')
def accept(user_id,book_id):
    if session['user_role'] != 'l':
        flash("You do not have authorization to view this page.")
        return redirect(url_for("home"))
    else:
        cur = db.connection.cursor()
        query = "UPDATE service SET service_type='b', service_date=CURDATE() WHERE user_id=%s AND book_id=%s"
        values = (user_id, book_id,)
        cur.execute(query, values)
        db.connection.commit()
        cur.close()
        return redirect(url_for("reservations"))


@app.route('/reservations/decline/<user_id>+<book_id>')
def decline_reserv(user_id,book_id):
    if session['user_role'] != 'l':
        flash("You do not have authorization to view this page.")
        return redirect(url_for("home"))
    else:
        cur = db.connection.cursor()
        query = "DELETE FROM service WHERE user_id=%s AND book_id=%s"
        cur.execute(query, (user_id,book_id,))
        db.connection.commit()
        cur.close()
        return redirect(url_for("reservations"))

@app.route('/add_book',methods=['GET', 'POST'])
def add_book():
    if session.get('user_role') != 'l':
        flash("You do not have authorization to view this page.")
        return redirect(url_for("home"))
    else:
        try:
            form = Book_form()
            if request.method=='POST':
                cur = db.connection.cursor()
                cur.execute("SELECT book_id FROM book WHERE ISBN = %s",(form.isbn.data,))
                b = cur.fetchall()
                if not b:
                    query = "INSERT INTO book (ISBN,title,page_number,summary,lang,key_words) VALUES (%s,%s,%s,%s,%s,%s)"
                    values = (form.isbn.data, form.title.data, form.page_number.data, form.summary.data, form.lang.data, form.key_words.data,)
                    cur.execute(query,values)
                    print("book")
                cur.execute("SELECT publisher_id FROM publisher WHERE publisher_name = %s",(form.publisher.data,))
                pub = cur.fetchall()
                if not pub:
                    query = "INSERT INTO publisher (publisher_name) VALUES (%s)"
                    values = (form.publisher.data,)
                    cur.execute(query,values)
                    print("publisher")
                a = form.author_first_name.data + ' ' + form.author_last_name.data
                cur.execute("SELECT author_id FROM author WHERE CONCAT(author_first_name, ' ', author_last_name) = %s",(a,))
                auth = cur.fetchall()
                if not auth:
                    query = "INSERT INTO author (author_first_name, author_last_name) VALUES (%s,%s)"
                    values = (form.author_first_name.data, form.author_last_name.data,)
                    cur.execute(query,values)
                    print("author")
                cur.execute("SELECT category_id FROM category WHERE category_name = %s",(form.category.data,))
                cat = cur.fetchall()    
                if not cat:
                    query = "INSERT INTO category (category_name) VALUES (%s)"
                    values = (form.category.data,)
                    cur.execute(query,values)
                    print("category")
                db.connection.commit()
                cur.execute("SELECT book_id FROM book WHERE ISBN = %s",(form.isbn.data,))
                b = cur.fetchall()
                cur.execute("SELECT publisher_id FROM publisher WHERE publisher_name = %s",(form.publisher.data,))
                pub = cur.fetchall()
                cur.execute("SELECT author_id FROM author WHERE CONCAT(author_first_name, ' ', author_last_name) = %s",(a,))
                auth = cur.fetchall()
                cur.execute("SELECT category_id FROM category WHERE category_name = %s",(form.category.data,))
                cat = cur.fetchall()
                query = "INSERT INTO availability (school_id, book_id, copies) VALUES (%s,%s,%s)"
                values = (session['school_id'], b[0][0], form.copies.data)
                cur.execute(query,values)
                print("availability")
                query = "INSERT INTO book_publisher (publisher_id, book_id) VALUES (%s,%s)"
                values = (pub[0][0], b[0][0],)
                cur.execute(query,values)
                print("book publisher")
                query = "INSERT INTO book_author (author_id, book_id) VALUES (%s,%s)"
                values = (auth[0][0], b[0][0],)
                cur.execute(query,values)
                print("book author")
                query = "INSERT INTO book_category (category_id, book_id) VALUES (%s,%s)"
                values = (cat[0][0], b[0][0],)
                cur.execute(query,values)
                print("book category")
                db.connection.commit()
                cur.close()
                flash("Book was added.")
                return redirect(url_for('home'))
        except Exception as e:
            print("Problem inserting into db: " + str(e))
            return render_template("add_book.html", form=form)
        return render_template('add_book.html', form = form)

@app.route('/profile')
def profile():
    if (session.get('user_role') in ['s','t']):
        cur = db.connection.cursor()

        query = "SELECT * from user_info WHERE user_id=%s"
        values = (session.get('user_id'),)
        cur.execute(query, values)
        data = cur.fetchall()

        query = "SELECT * FROM service_info WHERE user_id=%s"
        values = (session.get('user_id'),)
        cur.execute(query, values)
        ser = cur.fetchall()
        
        query = "SELECT * FROM log_info WHERE user_id=%s"
        values = (session.get('user_id'),)
        cur.execute(query, values)
        log = cur.fetchall()

        cur.close()
        return render_template("profile.html", data=data, log=log)
    else:
        flash("You do not have authorization to view this page.")
        return redirect(url_for("home"))

@app.route('/add_school', methods=['GET', 'POST'])
def add_school():
    if session.get('user_role') != 'a':
        flash("You do not have authorization to view this page.")
        return redirect(url_for("home"))
    else:
        try:
            form = School_form()
            if request.method=='POST':
                cur = db.connection.cursor()
                lib_man = form.lib_man_first_name.data +' '+form.lib_man_last_name.data
                print("lib_man")
                query = "INSERT INTO school_unit (name, city, address, phone_number, email, principal, lib_manager) VALUES (%s,%s,%s,%s,%s,%s,%s)"
                values = (form.name.data, form.city.data, form.address.data, form.phone_number.data, form.email.data, form.principal.data, lib_man,)
                cur.execute(query,values)
                print("school")
                cur.execute("SELECT * FROM lib_user WHERE username=%s",(form.lib_man_username.data,))
                user = cur.fetchall()
                cur.connection.commit()
                if user:
                    flash("Username not available")
                    return render_template('add_school.html', form=form)
                else:
                    cur.execute("SELECT school_id FROM school_unit WHERE name=%s",(form.name.data,))
                    sch = cur.fetchall()
                    query = "INSERT INTO lib_user (username, password, school_id, first_name, last_name, birth_date, user_role) VALUES (%s,%s,%s,%s,%s,%s,%s)"
                    values = (form.lib_man_username.data, form.password.data, sch, form.lib_man_first_name.data, form.lib_man_last_name.data, form.lib_man_date_of_birth.data, 'l')
                    cur.execute(query,values)
                    db.connection.commit()
                    cur.close()
                    flash("School have been added")
                    return redirect(url_for("home"))
        except Exception as e:
            print("Problem inserting into db: " + str(e))
            return render_template("add_school.html", form=form)
        else:
            return render_template("add_school.html", form=form)
    
