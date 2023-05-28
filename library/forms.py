from flask_wtf import FlaskForm
from wtforms import StringField, PasswordField, SubmitField, DateField, SelectField, SelectMultipleField, IntegerField, TextAreaField
from wtforms.validators import DataRequired, Length, EqualTo, NumberRange, Email
import datetime


class Signup_form(FlaskForm):
	username = StringField('Username', 
		validators=[DataRequired(), Length(min=2, max=15)])
	first_name = StringField('First Name',
		validators=[DataRequired(), Length(min=2, max=20)])
	last_name = StringField('Last Name',
		validators=[DataRequired(), Length(min=2, max=20)])
	date_of_birth = DateField('Date of Birth',
		validators=[DataRequired()])
	role = SelectField('Role',choices=['Student','Teacher', 'Library Manager'], validate_choice=True)
	school = SelectField('School',choices=[],validate_choice=True)
	password = PasswordField('Password', 
		validators=[DataRequired(),Length(max=20)])
	confirm_password = PasswordField('Confirm Password', 
		validators=[DataRequired(),EqualTo('password')])
	submit = SubmitField('Sign Up')


class Login_form(FlaskForm):
	username = StringField('Username', 
		validators=[DataRequired(), Length(min=2, max=15)])
	password = PasswordField('Password', validators=[DataRequired(),Length(max=20)])
	submit = SubmitField('Login')


class Change_password_form(FlaskForm):
	current_password = PasswordField('Current Password', validators=[DataRequired(), Length(max=20)])
	new_password = PasswordField('New Password', validators=[DataRequired(), Length(max=20)])
	submit = SubmitField('Change')


class Change_info_form(FlaskForm):
	username = StringField('Username', 
		validators=[Length(min=2, max=15)])
	first_name = StringField('First Name',
		validators=[Length(min=2, max=20)])
	last_name = StringField('Last Name',
		validators=[Length(min=2, max=20)])
	date_of_birth = DateField('Date of Birth')
	submit = SubmitField('Submit')


class Search_form(FlaskForm):
	title = StringField('Title')
	author = StringField('Author')
	category = SelectMultipleField('Category',choices=[])
	search = SubmitField('Search')

class Search_by_copies_form(FlaskForm):
	copies = StringField('Copies')
	search_cp = SubmitField('Search')


class Book_form(FlaskForm):
	isbn = StringField('ISBN',
		validators = [DataRequired(), Length(13)])
	title = StringField('Title',
		validators=[DataRequired(), Length(max=100)])
	author_first_name = StringField('Author First Name',
		validators=[DataRequired()])
	author_last_name = StringField('Author Last Name',
		validators=[DataRequired()])
	copies = IntegerField('Copies',
		validators=[DataRequired()])
	publisher = StringField('Publisher',
		validators=[DataRequired()])
	category = StringField('Category',
		validators=[DataRequired()])
	page_number = IntegerField('Page Number',
		validators=[DataRequired()])
	summary = TextAreaField('Summary',
		validators=[Length(max=200)])
	lang = StringField('Language',
		validators=[DataRequired(), Length(max=15)])
	key_words = StringField('Key Words',
		validators=[Length(max=100)])
	submit = SubmitField('Add book')



class School_form(FlaskForm):
	name = StringField('School Name',
		validators=[DataRequired(), Length(max=20)])
	address = StringField('Address',
		validators=[DataRequired(), Length(max=20)])
	city = StringField('City',
		validators=[DataRequired(), Length(max=20)])
	phone_number = StringField('Phone Number',
		validators=[DataRequired(), Length(max=10)])
	email = StringField('email',
		validators=[DataRequired(), Length(max=50), Email()])
	principal = StringField('Principal Full Name',
		validators=[DataRequired(), Length(max=20)])
	lib_man_name = StringField('Library Manager Full Name',
		validators=[DataRequired(), Length(max=20)])
	submit = SubmitField('Add School')


class Review_form(FlaskForm):
	rating = IntegerField('Rating', validators=[DataRequired(), NumberRange(min=1, max=5)])
	review_text = StringField('Review text', validators=[Length(max=200)])
	submit = SubmitField('Submit')


class Delay_form(FlaskForm):
	first_name = StringField('User\'s first name', validators=[Length(max=20)])
	last_name = StringField('User\'s last name', validators=[Length(max=20)])
	delay = IntegerField('Delay (in days)', validators=[NumberRange(min=1)])
	search1 = SubmitField('Search')


class AvgRating_form(FlaskForm):
	username = StringField('Username', validators=[Length(min=2, max=15)])
	category = SelectField('Category', choices=[(0,'')], validate_choice=True)
	search2 = SubmitField('Search')

class TotLoans_form(FlaskForm):
	month = SelectField('Month', choices=['Whole year']+[month for month in range(1,13)])
	year = SelectField('Year', validators=[DataRequired()], choices=[year for year in range(2010, datetime.date.today().year)])
	search_tot_loans = SubmitField('View')

class Category_form(FlaskForm):
	category = SelectField('Category', validators=[DataRequired()], choices=[])
	search_category = SubmitField('View')

