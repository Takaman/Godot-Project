from flask import Flask, request, json, jsonify, g
import sqlite3, string, random, csv
from datetime import datetime
from flask_mail import Mail, Message
import mysql.connector


app = Flask(__name__)
app.secret_key="your_secret_Key"

#MySQL connection config
mysql_host = 'localhost'
mysql_user = 'godotproject'
mysql_password = 'sititpgroup11password'
mysql_database = 'game_data'

#Create a MYSQL connection
conn = mysql.connector.connect(
    host=mysql_host,
    user=mysql_user,
    password=mysql_password,
    database=mysql_database
)
# Create a new MySQL connection object
def create_mysql_connection():
    try:
        conn = mysql.connector.connect(
            host=mysql_host,
            user=mysql_user,
            password=mysql_password,
            database=mysql_database
        )
        return conn
    except mysql.connector.Error as error:
        print("Error while connecting to MySQL", error)
        return None

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

    conn = create_mysql_connection()
    if conn is None:
        return jsonify({"error": "Failed to connect to MySQL"})
    try:

        cursor = conn.cursor()
        cursor.execute("INSERT INTO PlayerProgress (username, name, company, date_joined, points, comp_rate, last_played, accountStatus) VALUES (%s, %s, %s, NOW(), 0, 0, '-', 'Active')", (email, name, company))
        conn.commit()
        return "Player initialized successfully"
    
    except mysql.connector.Error as error:
        print("Error initializing new player:", error)
        return jsonify({"error": "Failed to initialize new player"})

    finally:
        if conn is not None:
            conn.close()


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
    conn = create_mysql_connection()
    if conn is None:
        return jsonify({"error": "Failed to connect to MySQL"})
    try:

        cursor = conn.cursor()
        #cursor.execute("UPDATE PlayerProgress SET points = ? , comp_rate = ?, last_played = DateTime('now', 'localtime'), se_completed = ?, se_correct = ?, policy_correct = ?, policy_completed = ?, breakdown = ? WHERE username = ?", (score,comp_rate, se_completed, se_correct, policy_correct, policy_completed, breakdown, email))
        cursor.execute("UPDATE PlayerProgress SET points = %s, comp_rate = %s, last_played = NOW(), se_completed = %s, se_correct = %s, policy_correct = %s, policy_completed = %s, breakdown = %s WHERE username = %s", (score, comp_rate, se_completed, se_correct, policy_correct, policy_completed, breakdown, email))
        conn.commit()
        return "Player score updated successfully"
    
    except mysql.connector.Error as error:
        print("Error updating player score:", error)
        return jsonify({"error": "Failed to update player score"})

    finally:
        if conn is not None:
            conn.close()

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
    
    conn = create_mysql_connection()
    if conn is None:
        return jsonify({"error": "Failed to connect to MySQL"})
    
    try:
        cursor = conn.cursor()
        #cursor.execute("UPDATE PlayerProgress SET has_interacted = ? WHERE username = ?", (interactions, email))
        cursor.execute("UPDATE PlayerProgress SET has_interacted = %s WHERE username = %s", (interactions, email))
        conn.commit()
        return "Player interactions updated successfully"
    
    except mysql.connector.Error as error:
        print("Error updating player interactions:", error)
        return jsonify({"error": "Failed to update player interactions"})

    finally:
        if conn is not None:
            conn.close()


# Retrieve leaderboard for users based on company
@app.route('/generate_report', methods=['POST'])
def ep_Generate_report():
    # JSON input parameters:
        # email
    data = json.loads(request.data)
    print("RECIEVED JSON REQUEST: ")
    email = data.get("email")

    # Generate the csv file''
    print("Starting CSV export.....")
    print("Fetching records to export.....")
     
    print("DB Connected...")
    conn = create_mysql_connection()
    if conn is None:
        return jsonify({"error": "Failed to connect to MySQL"})
    try:
        cursor = conn.cursor()
        cursor.execute(f"SELECT name,username,company,date_joined,points,comp_rate,last_played, accountStatus FROM PlayerProgress ") # TODO CHANGE TO PREPARED STATEMENTS
        users = cursor.fetchall()
    
    except mysql.connector.Error as error:
        print("Error getting database:", error)
        return jsonify({"error": "Failed to get database"})
    
    finally:
        if conn is not None:
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
    print(f"Sending csv email to {email}...")
    name = "Game Report" #TODO CHANGE TO RETRIEVE FROM DB FOR DYNAMIC
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
    conn = create_mysql_connection()
    if conn is None:
        return jsonify({"error": "Failed to connect to MySQL"})
    try:

        cursor = conn.cursor()
        #cursor.execute("SELECT breakdown FROM PlayerProgress WHERE username = %(email)s", {'email': email})
        #cursor.execute("SELECT breakdown FROM PlayerProgress WHERE username = ?",(email,))
        cursor.execute("SELECT breakdown FROM PlayerProgress WHERE username = %s", (email,))
        score = cursor.fetchone()
        # conn.close()
        if score is None:
            return jsonify({"error": "No player progress found"})
        else:
            return score[0] 
    
    except mysql.connector.Error as error:
        print("Error retrieving player progress:", error)
        return jsonify({"error": "Failed to retrieve player progress"})

    finally:
        if conn is not None:
            conn.close()

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
    conn = create_mysql_connection()  # Create a new MySQL connection
    if conn is None:
        return jsonify({"error": "Failed to connect to MySQL"})

    try:
        cursor = conn.cursor()
        #cursor.execute("SELECT has_interacted FROM PlayerProgress WHERE username = %(email)s", {'email': email})
        #cursor.execute("SELECT has_interacted FROM PlayerProgress WHERE username = ?",(email,))
        cursor.execute("SELECT has_interacted FROM PlayerProgress WHERE username = %s", (email,))
        score = cursor.fetchone()

        if score is None:
            return jsonify({"error": "No has_interaction found"})
        else:
            return score[0]
        
    except mysql.connector.Error as error:
        print("Error retrieving player interactions:", error)
        return jsonify({"error": "Failed to retrieve player interactions"})

    finally:
        if conn is not None:
            conn.close()

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
    conn = create_mysql_connection()
    if conn is None:
        return jsonify({"error": "Failed to connect to MySQL"})
    try:

        cursor = conn.cursor()
        cursor.execute("SELECT username, name, points FROM PlayerProgress WHERE company = ? and accountStatus = 'Active' ORDER BY points DESC", (company,))
        board = cursor.fetchall()
        print(f"Found {str(len(board))} results.")
        # send back json reply
        return jsonify(board)

    except mysql.connector.Error as error:
        print("Error retrieving player leaderboard:", error)
        return jsonify({"error": "Failed to retrieve player leaderboard"})
    
    finally:
        if conn is not None:
            conn.close()



# Retrieve leaderboard for all users 
@app.route('/get_Leader_Admin', methods=['POST'])
def ep_Get_Leader_All():
    # JSON input parameters:
        # N/A
    # Recieve request

    print(f"---Retrieving Leaderboards from Database for all players---")
    
    conn = create_mysql_connection()
    if conn is None:
        return jsonify({"error": "Failed to connect to MySQL"})
    try:
        cursor = conn.cursor()
        cursor.execute("SELECT name, username, company, points , comp_rate FROM PlayerProgress WHERE accountStatus = 'Active' ORDER BY points DESC")
        board = cursor.fetchall()
        if board is None:
            return jsonify({"error": "No player leaderboard found"})
        
        print(f"Found {str(len(board))} results.")
        return jsonify(board)
    
    except mysql.connector.Error as error:
        print("Error retrieving all players leaderboard:", error)
        return jsonify({"error": "Failed to retrieve all players leaderboard"})

    finally:
        if conn is not None:
            conn.close()
    
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
    
    conn = create_mysql_connection()
    if conn is None:
        return jsonify({"error": "Failed to connect to MySQL"})
    try:
        cursor = conn.cursor()
        cursor.execute(f"SELECT name, username, company, points , comp_rate FROM PlayerProgress WHERE accountStatus = 'Active' ORDER BY {column_name}")
        board = cursor.fetchall()
        if board is None:
            return jsonify({"error": "No player leaderboard found"})
        print(f"Found {str(len(board))} results.")
        return jsonify(board)

    except mysql.connector.Error as error:
        print("Error retrieving all players leaderboard:", error)
        return jsonify({"error": "Failed to retrieve all players leaderboard"})
    
    finally:
        if conn is not None:
            conn.close()

    # send back json reply
    return jsonify(board)

if __name__ == '__main__':



    app.run(host='0.0.0.0',port=5000)