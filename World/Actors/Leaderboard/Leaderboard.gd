extends CharacterBody2D

@onready var hud := $"/root/Base_Map/PanelHUD"
@onready var sessionVar = get_node("/root/SeshVar")


func interact() -> void:
	
	var company = sessionVar.company
	var url = sessionVar.api_svr + "/get_Leader_Player"
	var headers = ["Content-Type: application/json", "Authorization: Bearer " + sessionVar._session.get("token")]
	var data_to_send = {"company":company}
	var jsonPayload = JSON.stringify(data_to_send)
	print(company)
	var http_request = HTTPRequest.new() 
	self.add_child(http_request)
	http_request.connect("request_completed", Callable(self, "_on_request_completed"))
	http_request.request(url,headers,HTTPClient.METHOD_POST, jsonPayload)

	
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
			hud.update_leaderboard(data)
			# Show the panel after updating the leaderboard
			hud.show_panel("leaderboard", {"$begin": hud.panel_big_label.text}, "leaderboard")
		else:
			print("Parse error on line ", json.get_error_line())
			print("Error message: ", json.get_error_message())
	else:
		print("An error occurred when trying to send data to server: ", response_code)
