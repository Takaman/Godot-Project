extends Control
var LeaderboardRecord = preload("res://menu/LeaderRecord.tscn")
const api_svr = "http://127.0.0.1:5000"
var result = []
@onready var record_container = $PanelContainer/VBoxContainer/Panel/ScrollContainer/VBoxContainer

func _ready() -> void:
	clear_records()
	get_records()

func clear_records() -> void:
	for child in record_container.get_children():
		record_container.remove_child(child)
		child.queue_free()

func get_records():
	# TODO Get records from API
	print("REQUESTING FOR RESULTS....")
	var url = api_svr + "/get_Leader_Admin"
	$HTTPRequest.request_completed.connect(_on_request_completed)
	var headers = ["Content-Type: application/json"]
	await $HTTPRequest.request(url,headers, HTTPClient.METHOD_POST)
	
	
func populate_data():	
	clear_records()
	print("fk")
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
	var headers = ["Content-Type: application/json"]
	$HTTPRequest_export.request(url, headers, HTTPClient.METHOD_POST)
	pass # Replace with function body.
