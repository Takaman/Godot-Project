extends Control

var scheme = " "
var host = " "
var port = 0
var server_key = " "
var client := Nakama.create_client(server_key, host, port, scheme)
var pwd = "" 
var loggedIn = ""
var api_svr = ""
var characters = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ~!@#$%^&*()_+`-='

@onready var sessionVar = get_node("/root/SeshVar")

# Called when the node enters the scene tree for the first time.
func _ready():
	scheme = sessionVar.scheme
	host = sessionVar.host
	port = sessionVar.nakama_port
	server_key = sessionVar.server_key
	api_svr = sessionVar.api_svr
	client = Nakama.create_client(server_key, host, port, scheme)
	
	# Check if the user is logged in
	if sessionVar._session:
		loggedIn = sessionVar._session.get("username")
		print("username")
		print(loggedIn)
		
	else:
		print("FELLA NOT LOGGED IN")
		SceneTransition.change_scene("res://../menu/Login.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_register_btn_button_down():
	print("Current admin user: ")
	print(sessionVar._session)
	
	var email = $EmailTxt.text.strip_edges()
	var company = $CompanyTxt.text.strip_edges()
	var name = $NameTxt.text.strip_edges()
	var result := OK
	var createPwd = generate_word(characters, 10)
	var authCompany = sessionVar.company.lstrip("Admin_")
	var auth = false
	
	# Check if the admin is authorised to create the user
	if (sessionVar.company == "Admin"):
		print("User: Superuser")
		auth = true
	
	if (authCompany == company):
		print("User: "+ authCompany)
		auth = true

	if auth:
		print("********* CREATING USER *********")
		var x: NakamaSession = await client.authenticate_email_async(email, createPwd, email, true)
		if not x.is_exception():
			print(x)
			
			if !x.created:
				$ErrorLbl.text="User already registered"
			else:
				$ErrorLbl.text="User created."
				
				print("********* USER HAS BEEN CREATED *********")
				print("********* INITIALISING PLAYER DATA ********* ")
				#TODO ADD THE INITIALISE PLAYER API CALL
				var data_to_send = {"email":email,"company":company,"name":name}
				var url = api_svr + "/init_Player"
				var jsonPayload = JSON.stringify(data_to_send)
				var headers = ["Content-Type: application/json", "Authorization: Bearer " + sessionVar._session.get("token")]
				$HTTPRequest.request(url,headers,HTTPClient.METHOD_POST, jsonPayload)
				print("TOKEN IS HERE")
				print(sessionVar._session.get("token"))
				
				print("********* Attempting to send email *********")
				var subject = "Your Security Defender: Office Edition account has been created"
				var body = "An Security Defender: Office Edition account has been Created for you on behalf of "+company+".\n Username: "+email+"\nPassword: "+createPwd
				data_to_send = {"email":email,"subject":subject,"body":body}
				print("DATA TO SEND: ")
				print(data_to_send)
				url = api_svr+"/send_Mail"
				print(url)
				jsonPayload = JSON.stringify(data_to_send)
				$HTTPRequest_email.request(url,headers,HTTPClient.METHOD_POST, jsonPayload)
				print("EMAIL SENT...")
				
		else:
			result = x.get_exception().status_code
			var e = x.get_exception().message
			if(e=="Invalid credentials."):
				e="User exits."
			$ErrorLbl.text=e
	else:
		if (company.begins_with("Admin_")):
			$ErrorLbl.text = "You are not authorized to create another admin."
		else:
			$ErrorLbl.text= " You are not authorized to create user for "+ company

func _on_back_btn_button_down():
	SceneTransition.change_scene("res://../menu/Admin_LandingPage.tscn")

func _on_batch_register_btn_button_down():
	get_tree().change_scene_to_file("res://menu/Admin_Registration_Batch.tscn")

func generate_word(chars, length):
	var word: String
	var n_char = len(chars)
	for i in range(length):
		word += chars[randi()% n_char]
	return word
