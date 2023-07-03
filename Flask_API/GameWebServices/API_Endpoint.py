from flask import Flask, request, json, jsonify
import sqlite3, string, random
from flask_mail import Mail, Message

app = Flask(__name__)
app.secret_key="your_secret_Key"
database = "score.db"

################################################   MAIL CONFIG   ##########################################
app.config['MAIL_SERVER']='smtp.gmail.com'
app.config['MAIL_PORT'] = 465
#update it with your gmail
app.config['MAIL_USERNAME'] = 'sititpgroup11@gmail.com'
#update it with your password
app.config['MAIL_PASSWORD'] = 'phtmlworgmfohuxx'
app.config['MAIL_USE_TLS'] = False
app.config['MAIL_USE_SSL'] = True

mail = Mail(app)
###########################################################################################################

############################################################################################################
## Testing command
# curl -X POST http://127.0.0.1:5000/string_example -H 'Content-Type: application/json' -d '{

#     "name":"John",
#     "age":30,
#     "year":2020
    
#     }'
############################################################################################################

# Base template for endpoints
@app.route('/string_example', methods=['POST'])
def string_example():
    data = json.loads(request.data)
    print("RECIEVED JSON REQUEST: ")
    print(data)
    return data

@app.route('/pwd_Gen', methods=['POST','GET'])
def ep_Pwd_Gen():
    characters = string.ascii_letters + string.digits
    punctuation = string.punctuation
    password = ''.join(random.choice(characters) for _ in range(10))
    password += ''.join(random.choice(punctuation) for _ in range(2))
    password = ''.join(random.sample(password,len(password)))
    print(password)
    return password

# Initialise User Record
@app.route('/init_Player', methods=['POST'])
def ep_InitPlayer():
    # JSON input parameters:
        # Email, company,  name
    # Receive JSON Request
    data = json.loads(request.data)
    print("RECIEVED JSON REQUEST: ")
    email = data.get("email")
    company = data.get("company")
    name = data.get("name")
    print("Email: " + email)
    print("Name: " + name)
    print("Company: " + company)

    print("---Inserting New User Into Database----")
    conn = sqlite3.connect(database)
    cursor = conn.cursor()
    cursor.execute("INSERT INTO PlayerProgress (username, name, company, date_joined, points, comp_rate, last_played, accountStatus) VALUES (?,?,?,DateTime('now', 'localtime'),0,0,'-','Active')",(email,name,company))
    conn.commit()
    print("---New user record inserted successfully---")
    conn.close()
    return data #TODO change to a success or sth

# Email sender
@app.route('/send_Mail', methods=['POST'])
def ep_send_mail():
    # JSON input parameters:
        # Email, body, subject

    # Receive JSON Request
    data = json.loads(request.data)
    print("RECIEVED JSON REQUEST: ")
    email = data.get("email")
    body = data.get("body")
    subject = data.get("subject")

    # Mail
    email = Message(subject, sender = 'sititpgroup11@gmail.com', recipients = [email])
    email.body = body
    mail.send(email)
    return ""

# Update of score
@app.route('/update_Score', methods=['POST'])
def ep_update_score():
    # JSON input parameters:
        # Email, Score, Completion Rate, se_completed, se_correct, policy_correct, policy_completed, breakdown
    # Recieve JSON request
    data = json.loads(request.data)
    print("RECIEVED JSON REQUEST: ")
    email = data.get("email")
    score = data.get("score")
    comp_rate = data.get("comp_rate")
    se_completed = data.get("se_completed")
    se_correct = data.get("se_correct")
    policy_completed = data.get("policy_completed")
    policy_correct = data.get("policy_correct")
    breakdown = data.get("breakdown")
    print("Email: " + email)
    print("Score: " + str(score))
    print("Completion Rate: " + str(comp_rate)+"%")

    print("---Updating Database----")
    conn = sqlite3.connect(database)
    cursor = conn.cursor()
    try:
        cursor.execute("UPDATE PlayerProgress SET points = ? , comp_rate = ?, last_played = DateTime('now', 'localtime'), se_completed = ?, se_correct = ?, policy_correct = ?, policy_completed = ?, breakdown = ? WHERE username = ?", (score,comp_rate, se_completed, se_correct, policy_correct, policy_completed, breakdown, email))
        conn.commit()
    
    except sqlite3.Error as er:
        print('SQLite error: %s' % (' '.join(er.args)))
        print("Exception class is: ", er.__class__)
        print('SQLite traceback: ')
        exc_type, exc_value, exc_tb = sys.exc_info()
        print(traceback.format_exception(exc_type, exc_value, exc_tb))
    conn.close()
    return data #TODO change to a success or sth

# Retrieve leaderboard for users based on company
@app.route('/get_Leader_Player', methods=['POST'])
def ep_Get_Leader_Player():
    # JSON input parameters:
        # Company
    # Recieve JSON request
    data = json.loads(request.data)
    print("RECIEVED JSON REQUEST: ")
    company = data.get("company")
    print("Company: " + company)

    print(f"---Retrieving Leaderboards from Database for {company}---")
    conn = sqlite3.connect(database)
    cursor = conn.cursor()
    cursor.execute("SELECT username, name, points FROM PlayerProgress WHERE company = ? and accountStatus = 'Active' ORDER BY points DESC", (company,))
    board = cursor.fetchall()
    conn.close()
    print(f"Found {str(len(board))} results.")

    # send back json reply
    return jsonify(board)


# Retrieve leaderboard for all users 
@app.route('/get_Leader_Admin', methods=['POST'])
def ep_Get_Leader_All():
    # JSON input parameters:
        # N/A
    # Recieve request

    print(f"---Retrieving Leaderboards from Database for all players---")
    conn = sqlite3.connect(database)
    cursor = conn.cursor()
    cursor.execute("SELECT username, name, points FROM PlayerProgress WHERE accountStatus = 'Active' ORDER BY points DESC")
    board = cursor.fetchall()
    conn.close()
    print(f"Found {str(len(board))} results.")

    # send back json reply
    return jsonify(board)

if __name__ == '__main__':
    app.run()