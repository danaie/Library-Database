from flask_wtf import FlaskForm
from wtforms import StringField, PasswordField, SubmitField
from wtforms.validators import DataRequired, Length, EqualTo, Email



class Signup_form(FlaskForm):
	username = StringField('Username', 
		validators=[DataRequired(), Length(min=2, max=15)])
	password = PasswordField('Password', validators=[DataRequired(),Length(max=20)])
	email = StringField('Email', validators=[DataRequired(),Email()])
	confirm_password = PasswordField('Confirm Password', validators=[DataRequired(),EqualTo('password')])
	submit = SubmitField('Sign Up')

class Login_form(FlaskForm):
	username = StringField('Username', 
		validators=[DataRequired(), Length(min=2, max=15)])
	password = PasswordField('Password', validators=[DataRequired(),Length(max=20)])
	submit = SubmitField('Login')
