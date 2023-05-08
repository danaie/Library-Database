from flask import Flask, render_template, request, flash, redirect, url_for, abort
from library.forms import Signup_form, Login_form
from library.configs import app


@app.route("/")
@app.route("/home")
def home():
	return render_template('home.html')

@app.route("/books")
def books():
	return render_template('av_books.html')

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
