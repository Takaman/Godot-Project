extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_register_btn_button_down():
	SceneTransition.change_scene("res://../menu/Admin_Registration.tscn") # Shows registration screen


func _on_scoreboard_btn_button_down():
	SceneTransition.change_scene("res://../menu/Admin_LeaderboardScreen.tscn") # Shows registration screen

