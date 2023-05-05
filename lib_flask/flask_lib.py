from flask import Flask, render_template 

app = Flask(__name__)


@app.route("/")
@app.route("/home")
def home():
	return render_template('home.html')

@app.route("/about")
def about():
	return render_template('av_books.html')

@app.route("/login", methods=['GET', 'POST'])
def login():
    if request.method == 'GET':
        return render_template("login.html")
    else:
        username = request.form['username']
        password = request.form['password']
        if username != 'admin' or password != 'admin':
            flash("Invalid password", "danger")
            return redirect(url_for("index"))
        else:
            is_admin=True
            flash("Logged in", "success")
            return redirect(url_for("index"))

@app.route("/signup", methods=['GET', 'POST'])
def signup():
    return render_template("signup.html")

if (__name__ == '__main__'):
	app.run(debug=True)
