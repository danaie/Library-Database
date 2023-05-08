from flask import Flask, render_template, request, flash, redirect, url_for, abort
from forms import Signup_form, Login_form

app = Flask(__name__)

app.config['SECRET_KEY'] = '7d08dab940ec78d6b8dd74864dab85f4'

@app.route("/")
@app.route("/home")
def home():
	return render_template('home.html')

@app.route("/books")
def books():
	return render_template('av_books.html')

'''
@app.route("/login", methods=['GET', 'POST'])
def login():
    if request.method == 'GET':
        return render_template("login.html")
    else:
        username = request.form['username']
        password = request.form['password']
        if username != 'admin' or password != 'admin':
            flash("Invalid password", "danger")
            return redirect(url_for("home"))
        else:
            is_admin=True
            flash("Logged in", "success")
            return redirect(url_for("home"))
'''

@app.route("/signup", methods=['GET', 'POST'])
def signup():
    form = Signup_form()
    if form.validate_on_submit():
    	flash('Account Created', 'success')
    	return redirect(url_for('home'))
    return render_template('signup.html', form=form)


@app.route("/login", methods=['GET', 'POST'])
def login():
    form = Login_form()
    if form.validate_on_submit():
    	if form.username.data == 'admin' and form.password.data == 'admin':
    		flash('You have been logged in', 'success')
    		return redirect(url_for('home'))
    	else:
    		flash('Login Unsuccesful')
    return render_template('login.html', form=form)


if (__name__ == '__main__'):
	app.run(debug=True)
