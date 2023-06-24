extends Control

const scheme = "http"
const host = "165.22.246.221"
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


func _on_register_btn_button_down():
	var email = $EmailTxt.text.strip_edges()
	var pwd = $PassTxt.text.strip_edges()
	var name = $NameTxt.text.strip_edges()
	var result := OK

	var x: NakamaSession = await client.authenticate_email_async(email, pwd, name, true)
	if not x.is_exception():
		print(x)
		
		if !x.created:
			$ErrorLbl.text="User already registered"
		else:
			$ErrorLbl.text="User created."
			print("^^^^^^^^^ USER HAS BEEN CREATED ^^^^^^^^^")
	else:
		result = x.get_exception().status_code
		var e = x.get_exception().message
		$ErrorLbl.text=e
	
	pass
