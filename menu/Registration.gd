extends Control

const scheme = "http"
const host = "165.22.246.221"
const port = 7350
const server_key = "nakama_godot_itp"
var client := Nakama.create_client(server_key, host, port, scheme)
var pwd = "" 

const api_svr = "http://127.0.0.1:5000"

@onready var sessionVar = get_node("/root/SeshVar")

# Called when the node enters the scene tree for the first time.
func _ready():
	var url = api_svr + "/pwd_Gen"
	$HTTPRequest.request_completed.connect(_on_request_completed_pwd)
	$HTTPRequest.request(url)
	pass # Replace with function body.


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
	
	
	print("Creating with PASSWORD :" + createPwd)
	

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
			var headers = ["Content-Type: application/json"]
			$HTTPRequest.request(url,headers,HTTPClient.METHOD_POST, jsonPayload)
			
			print("********* Attempting to send email *********")
			var subject = "Your xxx account has been created" #TODO CHANGE THE APP NAME
			#var body = "An xxx account has been Created for you on behalf of "+company+".\n Username: "+email+"\nPassword: "+createPwd
			var body = "An xxx account has been Created for you on behalf of xxx.\n Username: kdfjk@fas.com \nPassword: sdfsdf"
			data_to_send = {"email":email,"subject":subject,"body":body}
			url = api_svr+"/send_Mail"
			jsonPayload = JSON.stringify(data_to_send)
			$HTTPRequest.request(url,headers,HTTPClient.METHOD_POST, jsonPayload)
			print("EMAIL SENT...")
			
	else:
		result = x.get_exception().status_code
		var e = x.get_exception().message
		$ErrorLbl.text=e
	
	
		##### TODO REMOVE
	## BEFORE THIS STEP NEED TO FIRST HAVE THE HTTPRequest node
	##### TESTING API CALL FROM GODOT
	# var data_to_send = {"email":"test123@gmail.com","score":500,"comp_rate":59}
	# var url = api_svr + "/update_Score"
	# var jsonPayload = JSON.stringify(data_to_send)
	# var headers = ["Content-Type: application/json"]
	# $HTTPRequest.request(url,headers,HTTPClient.METHOD_POST, jsonPayload)
	
	pass
	
func _on_request_completed_pwd(result, response_code, headers, body):
	pwd = body.get_string_from_utf8()
	print(pwd)

