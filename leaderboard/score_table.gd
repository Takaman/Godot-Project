extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	for name in Globals.names:
		$Names.text += name +"\n"
	for score in Globals.scores:
		$Scores.text += str(score)+"\n"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	get_tree().change_scene_to_file("res://leaderboard/title_screen.tscn")
