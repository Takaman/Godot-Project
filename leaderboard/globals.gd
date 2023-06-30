extends Node

var score = 0
var scores = []
var names = []

func _init():
	load_scores()

func save_scores():
	##
	bubble_sort()
	var file = FileAccess.open("res://leaderboard/leaderboard.dat", FileAccess.WRITE)
	if file != null:
		file.store_var(names)
		file.store_var(scores)
		file.close()
	else:
		print("Error opening file for writing")

func load_scores():
	if not FileAccess.file_exists("res://leaderboard/leaderboard.dat"):
		print("File not found. Creating a new file.")
		save_scores()

	var file = FileAccess.open("res://leaderboard/leaderboard.dat", FileAccess.READ)
	if file != null:
		names = file.get_var()
		scores = file.get_var()
		file.close()
	else:
		print("Error opening file for reading")
	
	#this part of the code only show top 20 of the scores
	var total_entries = min(names.size(), 13)
	names.resize(total_entries)
	scores.resize(total_entries)
		

		
###
func bubble_sort():
	for passnum in range(len(scores)-1,0,-1):
		for i in range(passnum):
			if scores[i]<scores[i+1]:
				var temp = scores[i]
				scores[i] = scores[i+1]
				scores[i+1] = temp
				temp = names[i]
				names[i] = names[i+1]
				names[i+1] = temp
				
