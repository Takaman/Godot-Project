extends Control




func _on_QuitButton_pressed():
	get_tree().quit()


func _on_PlayButton_pressed():
	get_tree().change_scene_to_file("res://leaderboard/game.tscn")


func _on_high_scores_button_pressed():
	get_tree().change_scene_to_file("res://leaderboard/score_table.tscn")
