extends Control


# Called when the node enters the scene tree for the first time.


func _on_start_pressed():
	get_tree().change_scene_to_file("res://World/level_1.tscn")


func _on_instruction_pressed():
	get_tree().change_scene_to_file("res://menu/instruction.tscn")

func _on_options_pressed():
	get_tree().change_scene_to_file("res://menu/Options.tscn")


func _on_quit_pressed():
	get_tree().quit()
