extends Node

@onready var scene = PackedScene.new()
var current_scene = "world"
var transition_scene = false 
var is_player_frozen = true

var hud_shown: bool 

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

func save_state(tscn_name : String, save_name : String) -> bool:
	var result = scene.pack(get_node("/root/" + tscn_name))
	if result == OK:
		var error = ResourceSaver.save(scene, "res://Save_States/" + save_name +  ".tscn")
		if error != OK:
			push_error("An error occurred while saving the scene to disk.")
			return false
		else:
			print("SAVED")
			return true
	else:
		return false
