extends Node2D

@onready var sessionVar = get_node("/root/SeshVar")

# Called when the node enters the scene tree for the first time.
func _ready():
	# TODO REMOVE THIS CONFIGGGGGG
	var config = ConfigFile.new()
	# Store some values.
	config.set_value("url", "scheme", "http")
	config.set_value("url", "nakama_port", 7350)
	config.set_value("url", "server_key", "nakama_godot_itp")
	config.set_value("url", "api_svr", "http://165.22.246.221:5000")
	print("saving config file")
	config.save("res://../menu/config.cfg") #TODO change upon bundle-ing
	
	if sessionVar._session:
		var username = sessionVar._session.get("username")
	else:
		SceneTransition.change_scene("res://../menu/Login.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_register_btn_button_down():
	SceneTransition.change_scene("res://../menu/Admin_Registration.tscn") # Shows registration screen


func _on_scoreboard_btn_button_down():
	SceneTransition.change_scene("res://../menu/Admin_LeaderboardScreen.tscn") # Shows registration screen



func _on_logout_btn_button_down():
	sessionVar._session = null
	sessionVar.company = null
	SceneTransition.change_scene("res://../menu/Login.tscn")
