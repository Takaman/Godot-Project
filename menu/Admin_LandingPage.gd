extends Node2D

@onready var sessionVar = get_node("/root/SeshVar")

# Called when the node enters the scene tree for the first time.
func _ready():
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
