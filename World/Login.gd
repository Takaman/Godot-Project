extends Control

const scheme = "http"
const host = "20.212.251.76"
const port = 7350
const server_key = "nakama_godot_itp"
var _client := Nakama.create_client(server_key, host, port, scheme)
var _session: NakamaSession

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
	var new_session: NakamaSession = await _client.authenticate_email_async(email, pwd, null, false)
	if not new_session.is_exception():
		_session = new_session
	else:
		result = new_session.get_exception().status_code

	pass # Replace with function body.


func _on_register_btn_button_down():
	var email = $EmailTxt.text.strip_edges()
	var pwd = $PassTxt.text.strip_edges()
	var name = $NameTxt.text.strip_edges()
	
		# username - null # false - no registration # "completed" is the return value of authentication method
	var new_session: NakamaSession = await _client.authenticate_email_async(email, pwd, null, false)
	
	pass # Replace with function body.
