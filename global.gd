extends Node

var current_scene = "world"
var transition_scene = false 

var player_exit_basemap_x = 0
var player_exit_basemap_y = 0
var player_start_basemap_posx = 0
var player_start_basemap_poxy = 0

func finish_changescenes():
	if transition_scene == true:
		transition_scene == false
		if current_scene == "world":
			current_scene = "house_internal2"
		else:
			current_scene = "world"

var sam_check = false
