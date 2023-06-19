extends Node

const scheme = "http"
const host = "172.16.241.132"
const port = 7350
const server_key = "nakama_godot_itp"
var _client := Nakama.create_client(server_key, host, port, scheme)
var _session: NakamaSession

# authentication -- does not run and return instantly, takes time to call server and get respond -- "await" tells system to wait for reply
func authenticate_async(email: String, password: String) -> int:
	var result := OK
	# username - null # false - no registration # "completed" is the return value of authentication method
	var new_session: NakamaSession = await _client.authenticate_email_async(email, password, null, false)
	if not new_session.is_exception():
		_session = new_session
	else:
		result = new_session.get_exception().status_code
	
	return result
	
