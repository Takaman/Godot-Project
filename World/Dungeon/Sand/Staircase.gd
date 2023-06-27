extends Node2D

var downAt1 = false
var downAt2 = false
var upAt2 = false
var upAt3 = false
var downAt3 = false

func _on_staircase_1_body_entered(body):
	downAt1 = true

func _on_staircase_1_body_exited(body):
	downAt1 = false

func _on_staircase_2_up_body_entered(body):
	upAt2 = true

func _on_staircase_2_up_body_exited(body):
	upAt2 = false
	
func _on_staircase_2_down_body_entered(body):
	downAt2 = true

func _on_staircase_2_down_body_exited(body):
	downAt2 = false

func _on_staircase_3_up_body_entered(body):
	upAt3 = true

func _on_staircase_3_up_body_exited(body):
	upAt3 = false

func _on_staircase_3_down_body_entered(body):
	downAt3 = true

func _on_staircase_3_down_body_exited(body):
	downAt3 = false


#Check if player press enter then if on staircase1
func _process(delta):
	if Input.is_action_just_released("ui_accept"):
		if downAt1 == true:
			next_level("OneToTwo")
		if downAt2 == true:
			next_level("TwoToThree")
		if upAt2 == true:
			next_level("TwoToOne")
		if upAt3 == true:
			next_level("ThreeToTwo")
		if upAt3 == true:
			next_level("Exit")

func next_level(where):
	if where == "OneToTwo":
		SceneTransition.change_scene_to_file("res://World/Dungeon/Sand/Level_2.tscn")
	if where == "TwoToOne":
		SceneTransition.change_scene_to_file("res://World/Dungeon/Sand/Level_1.tscn")
	if where == "TwoToThree":
		SceneTransition.change_scene_to_file("res://World/Dungeon/Sand/Level_3.tscn")
	if where == "ThreeToTwo":
		SceneTransition.change_scene_to_file("res://World/Dungeon/Sand/Level_2.tscn")
	if where == "Exit":
		pass
	downAt1 = false
	downAt2 = false
	upAt2 = false
	upAt3 = false
	downAt3 = false
