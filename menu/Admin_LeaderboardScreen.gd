extends Control
var LeaderboardRecord = preload("res://menu/Admin_LeaderRecord.tscn")
var api_svr = ""
var result = []
@onready var record_container = $PanelContainer/VBoxContainer/Panel/ScrollContainer/VBoxContainer
@onready var sessionVar = get_node("/root/SeshVar")
var username = ""
func _ready() -> void:
	api_svr=sessionVar.api_svr
	if sessionVar._session:
		username = sessionVar._session.get("username")
		clear_records()
		get_records()
	else:
		SceneTransition.change_scene("res://../menu/Login.tscn")
	

func clear_records() -> void:
	for child in record_container.get_children():
		record_container.remove_child(child)
		child.queue_free()

func get_records():
	# TODO Get records from API
	print("REQUESTING FOR RESULTS....")
	var url = api_svr + "/get_Leader_Admin"
	$HTTPRequest.request_completed.connect(_on_request_completed)
	var data_to_send = ""
	if (sessionVar.company == "Admin"):
		data_to_send = {"company":sessionVar.company}
	else:
		var authCompany = sessionVar.company.lstrip("Admin_")
		print("ACompany = " + authCompany)
		data_to_send = {"company":authCompany}
	var jsonPayload = JSON.stringify(data_to_send)
	var headers = ["Content-Type: application/json", "Authorization: Bearer " + sessionVar._session.get("token")]
	await $HTTPRequest.request(url,headers, HTTPClient.METHOD_POST, jsonPayload)
	
	
func populate_data():	
	clear_records()
	print(result)
	#for record in result:
	#	print(record)
	#	var record_node = LeaderboardRecord.instance()
	#	record_container.add_child(record_node)
	#	record_node.setup(record.username, record.score)

func _on_request_completed(result, response_code, headers, body):
	print("Recieving data from server")
	var recordsString = body.get_string_from_utf8()
	result = JSON.parse_string(recordsString)
	print(result)
	clear_records()
	var record_node = LeaderboardRecord.instantiate()
	record_container.add_child(record_node)
	record_node.setup("Name:", "Email:", "Company:", "Score:", "Completion:")
	for record in result:
		print(record)
		record_node = LeaderboardRecord.instantiate()
		record_container.add_child(record_node)
		record_node.setup(record[0],record[1],record[2],str(record[3]),str(record[4]))


func _on_export_btn_button_down():
	print("Triggering the export")
	var url = api_svr+"/generate_report"
	var headers = ["Content-Type: application/json", "Authorization: Bearer " + sessionVar._session.get("token")]
	#var data_to_send = {"email":username, "company":sessionVar.company.lstrip("Admin_")}
	var data_to_send = ""
	if (sessionVar.company == "Admin"):
		data_to_send = {"email":username, "company":sessionVar.company}
	else:
		var authCompany = sessionVar.company.lstrip("Admin_")
		print("ACompany = " + authCompany)
		data_to_send = {"email":username, "company":authCompany}
	var jsonPayload = JSON.stringify(data_to_send)
			
	#add email
	$HTTPRequest_export.request(url, headers, HTTPClient.METHOD_POST,jsonPayload)
	pass # Replace with function body.


func _on_back_btn_button_down():
	SceneTransition.change_scene("res://../menu/Admin_LandingPage.tscn")
