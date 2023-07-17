extends Control

var scheme = " "
var host = " "
var port = 0
var server_key = " "
var client := Nakama.create_client(server_key, host, port, scheme)
var pwd = "" 
var loggedIn = ""
var api_svr = ""

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
		var url = api_svr + "/pwd_Gen"
		$HTTPRequest_PWD.request_completed.connect(_on_request_completed_pwd)
		$HTTPRequest_PWD.request(url)
		
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
	var createPwd = pwd
	
	
	print("Creating with PASSWORD: " + createPwd)
	

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
			var subject = "Your xxx account has been created" #TODO CHANGE THE APP NAME
			var body = "An xxx account has been Created for you on behalf of "+company+".\n Username: "+email+"\nPassword: "+createPwd
			#var body = "An xxx account has been Created for you on behalf of xxx.\n Username: kdfjk@fas.com \nPassword: sdfsdf"
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
	

	
	pass
	
func _on_request_completed_pwd(result, response_code, headers, body):
	pwd = body.get_string_from_utf8()
	print(pwd)



func _on_back_btn_button_down():
	SceneTransition.change_scene("res://../menu/Admin_LandingPage.tscn")
