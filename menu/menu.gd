extends Control
@onready var sessionVar = get_node("/root/SeshVar")
const api_svr = " "
# Called when the node enters the scene tree for the first time.
func _ready():
	api_svr = session.api_svr
	var username = sessionVar._session.get("username")
	print("SHOWING MENU")
	print(username)
	#print(username.get("username"))#test for session logged in 
	var urlprogress = api_svr + "/get_Progress"
	var urlinteracted = api_svr + "/get_Interactions"
	
	var data_to_send = {"email":username}
	var jsonPayload = JSON.stringify(data_to_send)
	var headers = ["Content-Type: application/json", "Authorization: Bearer " + sessionVar._session.get("token")]
	
	var http_request = HTTPRequest.new() 
	self.add_child(http_request)
	
	var http_request2 = HTTPRequest.new()
	self.add_child(http_request2)
	
	http_request.connect("request_completed", Callable(self, "_on_request_completed"))
	http_request.request(urlprogress,headers,HTTPClient.METHOD_POST, jsonPayload)
	http_request2.connect("request_completed", Callable(self, "_on_request_completed2"))
	http_request2.request(urlinteracted,headers,HTTPClient.METHOD_POST, jsonPayload)
	

func _on_start_pressed():
	SceneTransition.change_scene("res://menu/instruction.tscn")

func _on_options_pressed():
	SceneTransition.change_scene("res://menu/Options.tscn")


func _on_quit_pressed():
	get_tree().quit()
	
func _on_request_completed(result, response_code, headers, body):
	if response_code == 200:
		print("Data Received succesfully")
		var body_text = body.get_string_from_utf8()
		print("BODY text")
		print(body_text)
		var json = JSON.new()
		var parse_result = json.parse(body_text, false)
		print("AFTER PARSE")
		print(parse_result)
		if parse_result == OK:  # OK is equivalent to 0
			print("Parse successful")
			var data = json.get_data()
			print("Data:")
			print(data)
			#Uncomment this line below to set if you have running DB
			Score.set_Interactions_from_DB(data)
		else:
			print("Parse error on line ", json.get_error_line())
			print("Error message: ", json.get_error_message())
	else:
		print("An error occurred when trying to send data to server: ", response_code)

func _on_request_completed2(result, response_code, headers, body):
	if response_code == 200:
		print("Data received succesfully")
		var body_text = body.get_string_from_utf8()
		print("Body text")
		print(body_text)
		var json = JSON.new()
		var parse_result = json.parse(body_text,false)
		print("After Parsing")
		print(parse_result)
		
		if parse_result == OK:
			print("Parse succesful")
			var data = json.get_data()
			print("Data:")
			print(data)
			Score.set_has_interacted_from_DB(data)
		else:
			print("Parse error on line ", json.get_error_line())
			print("Error message: ", json.get_error_message())
	else:
		print("An error occured when trying to send data to server: ", response_code )
