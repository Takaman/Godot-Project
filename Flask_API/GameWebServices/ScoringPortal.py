from flask import Flask, render_template, request, redirect, Response, session, send_from_directory
from werkzeug.security import check_password_hash
import random, csv, sqlite3
from datetime import datetime

app = Flask(__name__)
app.secret_key="your_secret_Key"
database = "score.db"

themes = [
    {
        "background_color": "#F8E0E6",
        "text_color": "#2C3E50",
        "button_color": "#E91E63",
    },
    {
        "background_color": "#F0F4C3",
        "text_color": "#512DA8",
        "button_color": "#FBC02D",
    },
    {
        "background_color": "#BBDEFB",
        "text_color": "#4CAF50",
        "button_color": "#FF5722",
    },
]

@app.route('/')
def home():
    if 'username' in session:
        conn = sqlite3.connect(database)
        cursor = conn.cursor()
        cursor.execute("SELECT * FROM PlayerProgress")
        users = cursor.fetchall()
        conn.close()
        print("No. of fetched player records..."+str(len(users)))
        return render_template("index.html", users=users)
    else:

        return redirect('/login')

@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']

        # Validate Credentials
        conn = sqlite3.connect(database)
        cursor = conn.cursor()
        cursor.execute("SELECT * FROM login WHERE email = ?", (username,))
        user = cursor.fetchone()

        print("Logging in :"+username)

        if user is not None and check_password_hash(user[2],password):
            session['username'] = username
            session['name'] = user[0]
            return redirect('/')

        else:
            error = 'Invalid username or password.'
            theme = random.choice(themes)
            return render_template('login.html', error=error, theme=theme)
    else:
        theme = random.choice(themes)
        return render_template('login.html', theme=theme)

@app.route("/sort", methods=["POST"])
def sort():
    sort_by = request.form["sort_by_sort"]
    sort_order = request.form["sort_order_sort"]
    conn = sqlite3.connect(database)
    cursor = conn.cursor()
    cursor.execute(f"SELECT * FROM PlayerProgress ORDER BY {sort_by} {sort_order}")
    users = cursor.fetchall()
    conn.close()
    print("No. of fetched player records..." + str(len(users)))
    return render_template("index.html", users=users)

@app.route("/export", methods=["POST"])
def export():
    print("Starting CSV export.....")
    print("Fetching records to export.....")
    sort_by = request.form["sort_by_export"]
    sort_order = request.form["sort_order_export"]
    conn = sqlite3.connect(database)
    cursor = conn.cursor()
    cursor.execute(f"SELECT name,username,company,date_joined,points,comp_rate,last_played, accountStatus FROM PlayerProgress ORDER BY {sort_by} {sort_order}") # TODO CHANGE TO PREPARED STATEMENTS
    users = cursor.fetchall()
    conn.close()
    print("No. of fetched player records..." + str(len(users)))

    now = datetime.now()
    csv_name = f"""{now.strftime("%Y_%m_%d,%H_%M_%S")}-PlayerStats.csv"""
    with open("static_csv/"+csv_name,"x") as file:
        writer = csv.writer(file, dialect='excel')
        field = ["Name", "Email","Company", "Date Joined", "Score","Completion Rate (%)","Last Played", "Account Status"]
        writer.writerow(field)
        for user in users:
            writer.writerow(user)

    return send_from_directory(directory="static_csv/", path=csv_name, as_attachment=True)




@app.route('/logout')
def logout():
    session.pop('username', None)
    return redirect('/')

# @app.route('/create_account', methods=['GET', 'POST'])
# def create_account():
#     if request.method == 'POST':
#         username = request.form['username']
#         password = request.form['password']
#         if username in users:
#             error = 'Username already exists. Please choose a different username.'
#             return render_template('create_account.html', error=error)
#         else:
#             users[username] = password
#             session['username'] = username
#             return redirect('/')
#     else:
#         return render_template('create_account.html')




if __name__ == '__main__':
    app.run()


# @app.route("/register", methods=["POST"])
# def register():
#     username = request.form["username"]
#     password = request.form["password"]

#     hashed_password = generate_password_hash(password)

#     conn = sqlite3.connect(database)
#     cursor = conn.cursor()
#     cursor.execute("INSERT INTO users (username, password) VALUES (?, ?)", (username, hashed_password))
#     conn.commit()
#     conn.close()

#     return redirect("/login")