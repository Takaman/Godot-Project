extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	if SeshVar._session:
		var username = SeshVar._session.get("username")
	else:
		SceneTransition.change_scene("res://../menu/Login.tscn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_continue_btn_button_down():
	SceneTransition.change_scene("res://menu/Admin_Registration_Batch.tscn")


func _on_back_btn_button_down():
	SceneTransition.change_scene("res://../menu/Admin_LandingPage.tscn")
