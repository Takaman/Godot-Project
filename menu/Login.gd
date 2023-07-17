extends Control

@onready var sessionVar = get_node("/root/SeshVar")
@onready var scheme = sessionVar.scheme
@onready var host = sessionVar.host
@onready var port = sessionVar.nakama_port
@onready var server_key = sessionVar.server_key
@onready var api_svr = sessionVar.api_svr
@onready var client := Nakama.create_client(server_key, host, port, scheme)

var company=""


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_login_btn_button_down():
	var email = $EmailTxt.text.strip_edges()
	var pwd = $PassTxt.text.strip_edges()
	var result := OK
	# attempt login
	# username - null # false - no registration # "completed" is the return value of authentication method
	var session = await client.authenticate_email_async(email, pwd, null, false)
	if session.is_exception():
		var e = session.get_exception().message
		print(e)
		if "User account not found" in e:
			e="Invalid credentials."
		#TODO display exception
		$ErrorLbl.text=e
	else:
		print("::::::::::::::USER AUTHENTICATED::::::::::::::")
		print(session)
		sessionVar._session = session
		
		#TODO STORE THE USER's company in the session
		var url = api_svr + "/get_Company"
		var data_to_send = {"email":email}
		var jsonPayload = JSON.stringify(data_to_send)
		var headers = ["Content-Type: application/json", "Authorization: Bearer " + sessionVar._session.get("token")]
		$HTTPRequest_COMPANY.request_completed.connect(_on_request_completed_company)
		await $HTTPRequest_COMPANY.request(url,headers,HTTPClient.METHOD_POST, jsonPayload)

		
		#testing session user's detail retrieval
		var account = await client.get_account_async(session)
		var username = account.user.username
		print(account)

	pass
	
func _on_request_completed_company(result, response_code, headers, body):
	company = body.get_string_from_utf8()
	company = company.substr(2, company.length() - 5)
	print(">>>>GETTING COMPANY")
	print(company)
	print("Logging in as >>>")
	print(company)
	sessionVar.company = company
	if("Admin" in company):
		#TODO change to company
		SceneTransition.change_scene("res://../menu/Admin_LandingPage.tscn") # Shows admin landing page
	else:
		SceneTransition.change_scene("res://menu/menu.tscn") # Starts the game
