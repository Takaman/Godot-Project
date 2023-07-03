extends Control
@onready var sessionVar = get_node("/root/SeshVar")

# Called when the node enters the scene tree for the first time.
func _ready():
	var username = sessionVar._session
	print("SHOWING MENU")
	print(username)#test for session logged in 

func _on_start_pressed():
	SceneTransition.change_scene("res://menu/instruction.tscn")

func _on_options_pressed():
	SceneTransition.change_scene("res://menu/Options.tscn")


func _on_quit_pressed():
	get_tree().quit()
