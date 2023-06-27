extends Control


# Called when the node enters the scene tree for the first time.


func _on_start_pressed():
	SceneTransition.change_scene("res://menu/instruction.tscn")

func _on_options_pressed():
	SceneTransition.change_scene("res://menu/Options.tscn")


func _on_quit_pressed():
	get_tree().quit()
