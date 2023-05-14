from flask_wtf import FlaskForm
from wtforms import StringField, PasswordField, SubmitField, DateField , SelectField
from wtforms.validators import DataRequired, Length, EqualTo


class Signup_form(FlaskForm):
	username = StringField('Username', 
		validators=[DataRequired(), Length(min=2, max=15)])
	first_name = StringField('First Name',
		validators=[DataRequired(), Length(min=2, max=20)])
	last_name = StringField('Last Name',
		validators=[DataRequired(), Length(min=2, max=20)])
	date_of_birth = DateField('Date of Birth',
		validators=[DataRequired()])
	role = SelectField('Role',choices=['Student','Teacher'], validate_choice=True)
	school = SelectField('School',choices=[],validate_choice=True)
	password = PasswordField('Password', validators=[DataRequired(),Length(max=20)])
	confirm_password = PasswordField('Confirm Password', 
		validators=[DataRequired(),EqualTo('password')])
	submit = SubmitField('Sign Up')

class Login_form(FlaskForm):
	username = StringField('Username', 
		validators=[DataRequired(), Length(min=2, max=15)])
	password = PasswordField('Password', validators=[DataRequired(),Length(max=20)])
	submit = SubmitField('Login')
	
class Search_form(FlaskForm):
	title = StringField('title')
	author = StringField('Author')
	category = SelectMultipleField('Category',choices=[]) #does not work
	search = SubmitField('Search')
	
class Book_form(FlaskForm):
	title = StringField('Title', validators=[DataRequired(), Length(max=100)])
	isbn = StringField('ISBN', validators=[DataRequired(), Length(13)])
	page_number = IntegerField('Page number', validators=[DataRequired()])
	summary = StringField('Summary', validators=[Length(max=200)])
	lang = StringField('Language', validators=[DataRequired(), Length(max=15)])
	key_words = StringField('Key words', validators=[DataRequired(), Length(max=100)])
	copies = IntegerField('Copies', validators=[DataRequired()])
	category = StringField('Category', validators=[DataRequired(), Length(max=15)])
	author_first_name = StringField('Author\'s first name', validators=[DataRequired(), Length(max=20)])
	author_last_name = StringField('Author\'s last name', validators=[DataRequired(), Length(max=20)])
	publisher = StringField('Publisher', validators=[DataRequired(), Length(max=20)])
	
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
	lib_man_first_name = StringField('Library Manager First Name',
		validators=[DataRequired(), Length(max=20)])
	lib_man_last_name = StringField('Library Manager Last Name',
		validators=[DataRequired(), Length(max=20)])
	lib_man_username = StringField('Libray Manager Username', 
		validators=[DataRequired(), Length(min=2, max=15)])
	lib_man_date_of_birth = DateField('Date of Birth',
		validators=[DataRequired()])
	password = PasswordField('Password', 
		validators=[DataRequired(),Length(max=20)])
	confirm_password = PasswordField('Confirm Password', 
		validators=[DataRequired(),EqualTo('password')])
	submit = SubmitField('Add School')
