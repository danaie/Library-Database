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
	password = PasswordField('Password', validators=[DataRequired(),Length(max=20)])
	confirm_password = PasswordField('Confirm Password', 
		validators=[DataRequired(),EqualTo('password')])
	submit = SubmitField('Sign Up')

class Login_form(FlaskForm):
	username = StringField('Username', 
		validators=[DataRequired(), Length(min=2, max=15)])
	password = PasswordField('Password', validators=[DataRequired(),Length(max=20)])
	submit = SubmitField('Login')
