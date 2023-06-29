extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$score.text = str(Globals.score)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_line_edit_text_submitted(new_text):
	Globals.scores.append(Globals.score)
	Globals.names.append(new_text)
	#
	Globals.save_scores()
	#
	get_tree().change_scene_to_file("res://leaderboard/score_table.tscn")



