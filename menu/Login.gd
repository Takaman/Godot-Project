extends Control

const scheme = "http"
const host = "165.22.246.221"
const port = 7350
const server_key = "nakama_godot_itp"
var client := Nakama.create_client(server_key, host, port, scheme)
const api_svr = "http://127.0.0.1:5000"
@onready var sessionVar = get_node("/root/SeshVar")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	


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
		if("admin" in email):
			SceneTransition.change_scene("res://../menu/Registration.tscn") # Shows registration screen
		else:
			SceneTransition.change_scene("res://menu/menu.tscn") # Starts the game
		
		#testing session user's detail retrieval
		var account = await client.get_account_async(session)
		var username = account.user.username
		print(account)

	pass
