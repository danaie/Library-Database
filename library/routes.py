from flask import Flask, render_template, request, flash, redirect, url_for, abort, session
from library.forms import *
from flask_mysqldb import MySQL
from .__init__ import app, db


@app.route('/')
def home():
    return render_template('home.html')


@app.route('/about')
def about():
    return render_template("about.html")

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
        cur.close()
        if request.method=='POST':
            cur = db.connect.cursor()
            try:
                val = "your school library manager"
                if form.role.data == "Student":
                    role = "s"
                elif form.role.data == "Teacher":
                    role = "t"
                else:
                    role = "l"
                    val = "the administrator"
                cur = db.connection.cursor()
                query = "INSERT INTO lib_user (username, password, school_id, first_name, last_name, birth_date, user_role) VALUES (%s,%s,%s,%s,%s,%s,%s)"
                values = (form.username.data, form.password.data, form.school.data, form.first_name.data, form.last_name.data, form.date_of_birth.data, role)
                cur.execute(query,values)
                db.connection.commit()
                cur.close()
                flash("""Sign up application has been sent to """ +val+ """.\n
                Please wait for their approval.""")
            except Exception as e:
                flash("Username not available")
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


@app.route('/books')
def books():
    cur = db.connect.cursor()
    cur.execute("SELECT book_id, ISBN, title, auth, copies FROM school_book_info WHERE school_id = %s",(session['school_id'],))
    data = cur.fetchall()
    cur.close()
    return render_template("books_av.html", data=data)


@app.route('/info/<int:book_id>')
def info(book_id):
    cur = db.connect.cursor()
    cur.execute("SELECT * FROM book_info WHERE book_id=%s",(str(book_id),))
    book = cur.fetchall()
    cur.execute("SELECT * from review_info WHERE book_id=%s",(str(book_id),))
    review = cur.fetchall()
    cur.close()
    return render_template("info.html", book=book, review = review)


@app.route('/search',methods=['GET', 'POST'])
def search():
    cur = db.connection.cursor()
    cur.execute("SELECT category_name FROM category")
    r = cur.fetchall()
    cat = [] # this gets passed into the SelectMultipleField() choices
    for el in r:
        cat.append(el[0])
    form = Search_form()
    copies = Search_by_copies_form()
    form.category.choices = cat  
    if 'search' in request.form:
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
    elif 'search_cp' in request.form:
        cp = request.form.get('copies')
        return redirect(url_for('search_for_copies',cp=cp))
    return render_template('search.html', form=form, copies = copies)


@app.route('/search/for/copies/<cp>')
def search_for_copies(cp):
    cur = db.connection.cursor()
    cur.execute("SELECT book_id, ISBN, title, copies FROM school_book_info WHERE school_id = %s AND copies = %s", (session['school_id'], cp,))
    data = cur.fetchall()
    cur.close()
    if data:
        return render_template('books_av.html', data = data)
    else:
        flash('No results availabe')
        return redirect(url_for('search'))


@app.route('/search/for/<t>+<a>+<c>')
def search_for(t,a,c):
    cur = db.connection.cursor()
    query = "SELECT book_id, ISBN, title, copies FROM school_book_info WHERE school_id = %s AND REGEXP_LIKE(title,%s) AND REGEXP_LIKE(auth,%s) AND REGEXP_LIKE(cat,%s)"
    values = (session['school_id'], t, a, c,)
    cur.execute(query, values)
    data = cur.fetchall()
    cur.close()
    if data:
        return render_template('books_av.html', data = data)
    else:
        flash('No results availabe')
        return redirect(url_for('search'))


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
    msg = 'Your reservation has been registered.'
    try:
        query = """INSERT INTO service (user_id, book_id, service_type, waiting) 
            VALUES (%s, %s, 'r', 0)"""
        values = (str(session.get('user_id')), str(book_id),)
        cur.execute(query, values)
        db.connection.commit()
    except Exception as e:        
        msg = "Reservation failed."
    cur.close()
    flash(msg)
    return redirect(url_for('books'))


@app.route('/applications')
def applications():
    if session.get('user_role') not in ['l', 'a']:
        flash("You do not have authorization to view this page.")
        return redirect(url_for("home"))
    else:
        cur = db.connection.cursor()
        if session.get('user_role') == 'a':
            query = """SELECT u.user_id, u.username, u.first_name, u.last_name, 
            sch.name, u.birth_date, u.user_role 
            FROM lib_user u
            INNER JOIN school_unit sch 
            ON sch.school_id=u.school_id 
            WHERE active=FALSE AND pending=TRUE AND user_role='l'"""
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
    if session['user_role'] not in ['l','a']:
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
    if session['user_role'] not in ['l','a']:
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


@app.route('/reviews')
def reviews():
    if session.get('user_role') != 'l':
        flash("You do not have authorization to view this page.")
        return redirect(url_for("home"))
    else:
        cur = db.connection.cursor()
        query = "SELECT * from review_app WHERE school_id = %s"
        cur.execute(query, (session.get('school_id'),))
        list = cur.fetchall()
        cur.close()
        return render_template('reviews.html', list=list)


@app.route('/reviews/accept/<user_id>+<book_id>')
def accept_review(user_id,book_id):
        cur = db.connection.cursor()
        query = "UPDATE review SET pending=0 WHERE user_id=%s AND book_id=%s"
        values = (user_id, book_id,)
        cur.execute(query, values)
        db.connection.commit()
        cur.close()
        return redirect(url_for("info", book_id=book_id))


@app.route('/reviews/decline/<user_id>+<book_id>')
def decline_review(user_id,book_id):
    if session['user_role'] != 'l':
        flash("You do not have authorization to view this page.")
        return redirect(url_for("home"))
    else:
        cur = db.connection.cursor()
        query = "DELETE FROM review WHERE user_id=%s AND book_id=%s"
        values = (user_id, book_id,)
        cur.execute(query, values)
        db.connection.commit()
        cur.close()
        return redirect(url_for("reviews"))


@app.route("/add_review/<int:book_id>", methods=['GET', 'POST'])
def add_review(book_id):
    form = Review_form()
    if request.method == "POST":
        try:
            cur = db.connection.cursor()
            query = "INSERT INTO review (user_id, book_id, review_text, rating, pending) VALUES (%s,%s,%s,%s,TRUE)"
            values = (session.get('user_id'), str(book_id), form.review_text.data, str(form.rating.data),)
            cur.execute(query, values)
            db.connection.commit()
        except Exception as e:
            flash("Problem submitting your review." + str(e))
            return redirect(url_for("info", book_id=book_id))
        if (session.get('user_role') == 's'):
            flash("""Your review has been submitted successfully.
                Please wait for your library manager's approval.""")
            return redirect(url_for("info", book_id=book_id))
        return redirect(url_for("accept_review", user_id=session.get('user_id'), book_id=book_id))
    else:
        return render_template("add_review.html", form=form)


@app.route('/review/delete/<int:book_id>', methods=['POST','GET'])
def delete_review(book_id):
    if request.method == 'GET':
        flash('You do not have authorization to view this page.')
        return redirect(url_for('home'))
    cur = db.connection.cursor()
    query = "DELETE FROM review WHERE user_id=%s AND book_id=%s"
    values = (session.get('user_id'), book_id,)
    cur.execute(query, values)
    db.connection.commit()
    return redirect(url_for('info', book_id=book_id))


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


@app.route('/add_book',methods=['GET', 'POST'])
def add_book():
    if session.get('user_role') != 'l':
        flash("You do not have authorization to view this page.")
        return redirect(url_for("home"))
    else:   
        form = Book_form()
        if request.method=='POST':
            cur = db.connection.cursor()
            query = "INSERT IGNORE INTO book (ISBN,title,page_number,summary,lang,key_words) VALUES (%s,%s,%s,%s,%s,%s)"
            values = (form.isbn.data, form.title.data, form.page_number.data, form.summary.data, form.lang.data, form.key_words.data,)
            cur.execute(query,values)
            cur.execute("INSERT IGNORE INTO publisher (publisher_name) VALUES (%s)",(form.publisher.data,))
            auth_first = form.author_first_name.data.split(", ")
            auth_last = form.author_last_name.data.split(", ")
            auth = []
            for a1, a2 in zip(auth_first,auth_last): 
                auth.append(a1 + ' ' + a2)
                query = "INSERT IGNORE INTO author (author_first_name, author_last_name) VALUES (%s,%s)"
                values = (a1, a2,)
                cur.execute(query,values)
            cat = form.category.data.split(", ")
            for c in cat:
                cur.execute("INSERT IGNORE INTO category (category_name) VALUES (%s)",(c,))
            db.connection.commit()
            cur.execute("INSERT INTO availability (school_id, book_id, copies) SELECT %s,b.book_id,%s FROM book b WHERE ISBN = %s",(session['school_id'], form.copies.data,form.isbn.data))
            for a in auth:
                cur.execute("INSERT INTO book_author (author_id, book_id) SELECT a.author_id, b.book_id FROM author a JOIN book b WHERE CONCAT(author_first_name, ' ', author_last_name) = %s AND ISBN = %s", (a,form.isbn.data,))
            cur.execute("INSERT INTO book_publisher (publisher_id, book_id) SELECT p.publisher_id, b.book_id FROM publisher p JOIN book b WHERE b.ISBN = %s AND p.publisher_name = %s",(form.isbn.data,form.publisher.data,))
            for c in cat:
                cur.execute("INSERT INTO book_category (category_id, book_id) SELECT c.category_id, b.book_id FROM category c JOIN book b WHERE b.ISBN = %s AND c.category_name = %s",(form.isbn.data,c,))
            db.connection.commit()
            cur.close()
            flash("Book was added.")
            return redirect(url_for('home'))
    return render_template('add_book.html', form = form)


@app.route('/profile/<user_id>', methods=['POST','GET'])
def profile(user_id):
        msg = ''
        if session.get('user_role') != 'l' and str(session.get('user_id')) != user_id:
            flash("You do not have authorization to view this page.")
            return redirect(url_for("home"))

        cur = db.connection.cursor()

        if request.method =='POST':
            if request.form.get('button') == "Deactivate":
                try:
                    query = "UPDATE lib_user SET active=0 WHERE user_id=%s"
                    values = (user_id,)
                    cur.execute(query, values)
                    db.connection.commit()
                    msg = "Deactivation successful."
                except Exception as e:
                    msg = "Deactivation unsuccessful."

            elif request.form.get('button') == "Delete":
                try:
                    query = "DELETE FROM lib_user WHERE user_id=%s"
                    values = (user_id,)
                    cur.execute(query, values)
                    db.connection.commit()
                    msg = "Account successfully deleted."
                except Exception as e:
                    msg = "Account could not be deleted."

            
            flash(msg)
            return redirect(url_for("home"))

        query = "SELECT school_id FROM lib_user WHERE user_id=%s"
        values = (user_id,)
        cur.execute(query, values)
        sch = cur.fetchone()
        if sch[0] != session['school_id']:
            flash("You do not have authorization to view this page.")
            return redirect(url_for("home"))

        query = "SELECT * from user_info WHERE user_id=%s"
        values = (user_id,)
        cur.execute(query, values)
        data = cur.fetchall()

        query = "SELECT * FROM service_info WHERE user_id=%s"
        values = (user_id,)
        cur.execute(query, values)
        ser = cur.fetchall()
        
        query = "SELECT * FROM log_info WHERE user_id=%s"
        values = (user_id,)
        cur.execute(query, values)
        log = cur.fetchall()

        cur.close()
        return render_template("profile.html", data=data, ser=ser, log=log)
    

@app.route('/reservation/cancel/<int:user_id>+<int:book_id>', methods=['GET','POST'])
def cancel(user_id,book_id):
    msg = ''
    try:
        cur = db.connection.cursor()
        query = "DELETE FROM service WHERE user_id=%s AND book_id=%s AND service_type='r'"
        values = (user_id,book_id,)
        cur.execute(query, values)
        db.connection.commit()
        cur.close()
        msg = "Reservation was successfully canceled."
    except:
        msg = "No such reservation found."
    flash(msg)
    return redirect(url_for('profile', user_id=user_id))


@app.route('/change_password',methods=['GET', 'POST'])
def change_password():
    form = Change_password_form()
    if (request.method=='POST'):
        try:
            cur = db.connection.cursor()
            print(form.new_password.data)
            query = """UPDATE lib_user SET password=%s WHERE username=%s
            AND password=(SELECT password WHERE username=%s AND password=%s)"""
            values = (form.new_password.data, session.get('username'), session.get('username'), form.current_password.data,)
            cur.execute(query, values)
            db.connection.commit()
            cur.close()
            flash("Password changed successfully.")
            return redirect(url_for('profile',user_id=str(session.get('user_id'))))
        except Exception as e:
            print(e)
            flash('Wrong password!')
            return redirect(url_for('change_password'))
    return render_template("change_password.html",form=form)


@app.route('/change_info', methods=['GET','POST'])
def change_info():
    form = Change_info_form()
    if request.method == 'POST':
        cur = db.connection.cursor()
        values = ()
        list = []
        if form.username.data:
            list.append("username=%s")
            values += (form.username.data,)
        if form.first_name.data:
            list.append("first_name=%s")
            values += (form.first_name.data,)
        if form.last_name.data:
            list.append("last_name=%s")
            values += (form.last_name.data,)
        if form.date_of_birth.data:
            list.append("birth_date=%s")
            values += (str(form.date_of_birth.data),)
        query = "UPDATE lib_user SET " + ', '.join(list) + " WHERE user_id=%s"
        values += (session.get('user_id'),)
        cur.execute(query, values)
        db.connection.commit()
        cur.close()
        return redirect(url_for('profile', user_id=session.get('user_id')))
    else:
        return render_template('change_info.html', form=form)


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
                print("lib_man")
                query = "INSERT INTO school_unit (name, city, address, phone_number, email, principal, lib_manager) VALUES (%s,%s,%s,%s,%s,%s,%s)"
                values = (form.name.data, form.city.data, form.address.data, form.phone_number.data, form.email.data, form.principal.data, form.lib_man_name.data,)
                cur.execute(query,values)
                print("school")
                db.connection.commit()
                cur.close()
                flash("School has been added successfully.")
                return redirect(url_for("home"))
        except Exception as e:
            print("Problem inserting into db: " + str(e))
            return render_template("add_school.html", form=form)
        else:
            return render_template("add_school.html", form=form)


@app.route("/statistics", methods=['GET','POST'])
def statistics():
    delay_form = Delay_form()
    avgrating_form = AvgRating_form()
    cur = db.connect.cursor()
    query = "SELECT * FROM category;"
    cur.execute(query, ())
    temp = cur.fetchall()
    for el in temp:
        avgrating_form.category.choices.append(el)
    cur.close()
    if request.method == 'POST':
        if 'search1' in request.form:
            f = delay_form.first_name.data
            l = delay_form.last_name.data
            d = delay_form.delay.data 
            if f == '':
                f = '.*'
            if l == '':
                l = '.*'
            if d is None:
                d = '.*'
            return redirect(url_for("delay", f=f, l=l, d=d))
        elif 'search2' in request.form:
            username = avgrating_form.username.data
            cat = avgrating_form.category.data
            if username == '':
                username = '.*'
            if cat == '0':
                cat = '.*'
            return redirect(url_for("avg_rating", username=username, cat=cat))
    else:
        return render_template("statistics.html", delay_form=delay_form, avgrating_form=avgrating_form)


@app.route("/statistics/delay/<f>+<l>+<d>")
def delay(f,l,d):
    cur = db.connect.cursor()
    if d == '.*':
        query = """SELECT * FROM delay_info WHERE school_id = %s
        AND REGEXP_LIKE(first_name,%s) AND REGEXP_LIKE(last_name,%s) 
        AND DATEDIFF(CURDATE(), service_date) > 7
        """
        values = (session['school_id'], f, l,)
    else:
        val = int(d)+7
        query = """SELECT * FROM delay_info WHERE school_id = %s
        AND REGEXP_LIKE(first_name,%s) AND REGEXP_LIKE(last_name,%s)
        AND DATEDIFF(CURDATE(), service_date) = %s
        """
        values = (session['school_id'], f, l, val,)
    cur.execute(query, values)
    data = cur.fetchall()
    cur.close()
    if data:
        return render_template('delay_info.html', data = data)
    else:
        flash('No results availabe')
        return redirect(url_for('statistics'))


@app.route("/statistics/rating/<username>+<cat>")
def avg_rating(username,cat):
    cur = db.connection.cursor()
    query = "SELECT AVG(rating) FROM rating_info WHERE 1=1"
    values = ()
    if username == '.*' and cat == '.*':
        flash("Fill at least one field.")
        return redirect(url_for("statistics"))
    if username != '.*':
        query = query + " AND username=%s"
        values = (username,)
    if cat != '.*':
        query = query + " AND category_id=%s"
        values = (cat,)
    if cat != '.*' and username != '.*':
        values = (username,cat,)
    cur.execute(query, values)
    data = cur.fetchall()
    return render_template("avg_rating.html", data=data)


@app.route('/information', methods=['POST','GET'])
def information():
        tot_loans_form = TotLoans_form()
        category_form = Category_form()
        if request.method == 'POST':
            if 'search_category' in request.form:
                cat = category_form.category.data
                return redirect(url_for('result2', cat=cat))
            elif 'search_tot_loans' in request.form:
                month = tot_loans_form.month.data
                year = tot_loans_form.year.data
                return redirect(url_for('result1', q=1, m=month, y=year))
        else:
            cur = db.connection.cursor()
            query = "SELECT * from category ORDER BY category_name"
            cur.execute(query, ())
            data = cur.fetchall()
            list = []
            for el in data:
                list.append(el)
            category_form.category.choices = list
        return render_template('information.html', tot_loans_form=tot_loans_form, category_form=category_form)


@app.route('/result/<int:q>')
def result(q):
    if session.get('user_role') != 'a':
        flash("You do not have authorization to view this page.")
        return(redirect(url_for("home")))
    cur = db.connection.cursor()
    q = int(q)
    if q == 3:
        query = """SELECT CONCAT(u.first_name, ' ', u.last_name) AS teacher_name, 
            COUNT(bl.book_id) AS book_nmbr
            FROM lib_user u
            INNER JOIN borrow_log bl ON u.user_id = bl.user_id
            WHERE DATEDIFF(CURDATE(), u.birth_date)/365 < 40 AND u.user_role = 't'
            GROUP BY bl.user_id
            ORDER BY book_nmbr DESC
            LIMIT 10;"""
    elif q == 4:
        query = """SELECT CONCAT(author_first_name, ' ', author_last_name) AS author_name
            FROM author WHERE author_id NOT IN (
            SELECT DISTINCT author_id FROM book_author WHERE book_id IN 
            (SELECT book_id FROM borrow_log));"""
    elif q == 6:
        query = """SELECT COUNT(bl.book_id) AS loan_nmbr, 
            CONCAT(c1.category_name, ', ', c2.category_name) AS category_pair
            FROM category c1 INNER JOIN book_category bc1 ON c1.category_id = bc1.category_id
            INNER JOIN book_category bc2
            ON bc1.book_id = bc2.book_id AND bc1.category_id < bc2.category_id
            INNER JOIN category c2 ON c2.category_id = bc2.category_id
            INNER JOIN borrow_log bl ON bl.book_id = bc1.book_id
            GROUP BY bc1.category_id, bc2.category_id
            ORDER BY COUNT(bl.book_id) DESC
            LIMIT 3;"""
    elif q == 7:
        query = """SELECT author FROM author_books 
        WHERE author_books.total_books <= (SELECT MAX(total_books) 
        FROM author_books) - 5;"""
    else:
        flash("Invalid argument.")
        return redirect(url_for('home'))
    cur.execute(query, ())
    data = cur.fetchall()
    return render_template('result.html', q=q, data=data)


@app.route('/result/<int:q>/<m>+<y>')
def result1(q,m,y):
    if session.get('user_role') != 'a':
        flash("You do not have authorization to view this page.")
        return(redirect(url_for("home")))
    elif int(q) not in [1,5]:
        flash("Invalid arguments.")
        return(redirect(url_for("home")))
    elif int(q) == 1:
        cur = db.connection.cursor()
        query = "SELECT * FROM tot_loans WHERE b_year=%s"
        values = (y,)
        if m != 'Whole year':
            query += " AND b_month=%s;"
            values += (m,)
    else:
        cur = db.connection.cursor()
        query = """SELECT * FROM (
                SELECT lm.username, CONCAT(lm.first_name, ' ', lm.last_name) AS lib_man_name, sch.name, 
                COUNT(bl.user_id) AS loan_nmbr, YEAR(bl.borrow_date) AS loan_year
                FROM school_unit sch
                INNER JOIN lib_user u ON sch.school_id = u.school_id
                INNER JOIN borrow_log bl ON bl.user_id = u.user_id
                INNER JOIN lib_user lm ON lm.school_id = sch.school_id
                WHERE lm.user_role = 'l'
                GROUP BY lm.username, sch.school_id, loan_year) AS lib_loan
            WHERE lib_loan.loan_nmbr > 20 AND lib_loan.loan_year = %s
            ORDER BY loan_nmbr DESC;"""
        values = (y,)
    cur.execute(query, values)
    data = cur.fetchall()
    cur.close()
    return render_template("result.html", q=q, data=data)


@app.route('/result/2/<int:cat>')
def result2(cat):
    if session.get('user_role') != 'a':
        flash("You do not have authorization to view this page.")
        return redirect(url_for('home'))
    
    cur = db.connection.cursor()
    query = """SELECT author FROM
        (SELECT DISTINCT c.category_id AS category, CONCAT(a.author_first_name, ' ', a.author_last_name) AS author
        FROM author a INNER JOIN book_author ba ON ba.author_id = a.author_id
        INNER JOIN book b ON b.book_id = ba.book_id
        INNER JOIN book_category bc ON bc.book_id = b.book_id
        INNER JOIN category c ON c.category_id = bc.category_id) AS cat_auth
        WHERE cat_auth.category = %s;"""
    values = (cat,)
    cur.execute(query, values)
    data = cur.fetchall()

    query = """select username, CONCAT(first_name, ' ', last_name) AS teacher_name 
        from lib_user where user_id in
        (select distinct user_id from borrow_log where 
        DATEDIFF(current_date(), borrow_date)/365 <= 1
        and book_id in (select book_id from book_category where category_id in 
        (select category_id from category where category_id = %s) )
        ) and user_role = 't';"""
    cur.execute(query, values)
    data2 = cur.fetchall()

    cur.close()
    return render_template('result.html', q=2, data=data, data2=data2)
