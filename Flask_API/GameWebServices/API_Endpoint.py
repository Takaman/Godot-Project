from flask import Flask, request, json, jsonify
import sqlite3, string, random, csv
from datetime import datetime
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
    
    cursor.execute("UPDATE PlayerProgress SET points = ? , comp_rate = ?, last_played = DateTime('now', 'localtime'), se_completed = ?, se_correct = ?, policy_correct = ?, policy_completed = ?, breakdown = ? WHERE username = ?", (score,comp_rate, se_completed, se_correct, policy_correct, policy_completed, breakdown, email))
    conn.commit()
    conn.close()
    return data #TODO change to a success or sth

# Update of interactions
@app.route('/update_Interactions', methods=['POST'])
def ep_update_Interactions():
    # JSON input parameters:
        # Email, Interactions
    # Recieve JSON request
    data = json.loads(request.data)
    print("RECIEVED JSON REQUEST: ")
    email = data.get("email")
    interactions = data.get("has_interacted")
    print("Email: " + email)
    print("---Updating Database----")
    conn = sqlite3.connect(database)
    cursor = conn.cursor()
    
    cursor.execute("UPDATE PlayerProgress SET has_interacted = ? WHERE username = ?", (interactions, email))
    conn.commit()
    conn.close()
    return data


# Retrieve leaderboard for users based on company
@app.route('/generate_report', methods=['POST'])
def ep_Generate_report():
    # JSON input parameters:
        # ---
    # Generate the csv file''
    print("Starting CSV export.....")
    print("Fetching records to export.....")
    conn = sqlite3.connect(database)
    print("DB Connected...")
    cursor = conn.cursor()
    cursor.execute(f"SELECT name,username,company,date_joined,points,comp_rate,last_played, accountStatus FROM PlayerProgress ") # TODO CHANGE TO PREPARED STATEMENTS
    users = cursor.fetchall()
    conn.close()
    print("No. of fetched player records..." + str(len(users)))

    now = datetime.now()
    csv_name = f"""{now.strftime("%Y_%m_%d,%H_%M_%S")}-PlayerStats.csv"""
    print("Creating file..."+csv_name)
    with open("static_csv/"+csv_name,"x") as file:
        writer = csv.writer(file, dialect='excel')
        field = ["Name", "Email","Company", "Date Joined", "Score","Completion Rate (%)","Last Played", "Account Status"]
        writer.writerow(field)
        for user in users:
            writer.writerow(user)
            
    # send the csv in the email    
    print("Sending csv email...")
    email="teo259@gmail.com" #TODO CHANGE TO TAKE IN FROM JSON FOR DYNAMIC
    name = "Sean" #TODO CHANGE TO RETRIEVE FROM DB FOR DYNAMIC
    subject = "Your Report has Arrived"
    email_csv = Message(subject, sender = 'sititpgroup11@gmail.com', recipients = [email])
    email_csv.body = f"Hi {name},\nAttached is the csv report generated."
    with app.open_resource(f"static_csv/{csv_name}") as file:
        email_csv.attach(csv_name,"text/csv",file.read())

    mail.send(email_csv)
    # send back json reply with status as sent 
    return "Sent"

# Getting the progress of the player through the player dictionary
@app.route('/get_Progress', methods=['POST'])
def ep_get_Progress():
    # JSON input parameters:
        # Email
    # Recieve JSON request
    data = json.loads(request.data)
    print("RECIEVED JSON REQUEST: ")
    email = data.get("email")
    print("Email: " + email)

    print("---Retrieving Player Progress----")
    conn = sqlite3.connect(database)
    cursor = conn.cursor()
    
    cursor.execute("SELECT breakdown FROM PlayerProgress WHERE username = ?",(email,))
    score = cursor.fetchone()
    # conn.close()
    if score is None:
        return jsonify({"error": "No player progress found"})
    else:
        return score[0] 

#Getting the interactions the player had through the player dicitionary
@app.route('/get_Interactions', methods=['POST'])
def ep_get_Interactions():
    #JSON input parameters:
        #Email
    #Recieve JSON request
    data = json.loads(request.data)
    print("RECIEVED JSON REQUEST: ")
    email = data.get("email")
    print("Email: " + email)

    print("---Retrieving Player Interactions----")
    conn = sqlite3.connect(database)
    cursor = conn.cursor()

    cursor.execute("SELECT has_interacted FROM PlayerProgress WHERE username = ?",(email,))
    score = cursor.fetchone()

    if score is None:
        return jsonify({"error": "No has_interaction found"})
    else:
        return score[0]


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
    cursor.execute("SELECT name, username, company, points , comp_rate FROM PlayerProgress WHERE accountStatus = 'Active' ORDER BY points DESC")
    board = cursor.fetchall()
    conn.close()
    print(f"Found {str(len(board))} results.")

    # send back json reply
    return jsonify(board)

# Retrieve leaderboard for all users 
@app.route('/get_Leader_Admin_Sort', methods=['POST'])
def ep_Get_Leader_All_Sort():
    # JSON input parameters:
        # column_name
    # Recieve request
    data = json.loads(request.data)
    print("RECIEVED JSON REQUEST: ")
    column_name = data.get("column_name")
    print(f"---Retrieving Leaderboards from Database for all players order by {column_name}---")
    conn = sqlite3.connect(database)
    cursor = conn.cursor()
    cursor.execute(f"SELECT name, username, company, points , comp_rate FROM PlayerProgress WHERE accountStatus = 'Active' ORDER BY {column_name}")
    board = cursor.fetchall()
    conn.close()
    print(f"Found {str(len(board))} results.")

    # send back json reply
    return jsonify(board)

if __name__ == '__main__':
    app.run()