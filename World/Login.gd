extends Control

const scheme = "http"
const host = "192.168.0.101"
const port = 7350
const server_key = "nakama_godot_itp"
var client := Nakama.create_client(server_key, host, port, scheme)
var _session: NakamaSession # global session object

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
		print(session.get_exception().message)
	else:
		print("::::::::::::::USER AUTHENTICATED::::::::::::::")
		print(session)
		
		#testing session user's detail retrieval
		var account = await client.get_account_async(session)
		var username = account.user.username
		print(account)

	pass


func _on_register_btn_button_down():
	var email = $EmailTxt.text.strip_edges()
	var pwd = $PassTxt.text.strip_edges()
	var name = $NameTxt.text.strip_edges()
	var result := OK

	var session: NakamaSession = await client.authenticate_email_async(email, pwd, name, true)
	if not session.is_exception():
		_session = session
		print(_session)
	else:
		result = session.get_exception().status_code
	
	pass
