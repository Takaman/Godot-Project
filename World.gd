extends Node2D

signal world_changed(map_name)
signal dialogue_closed

@onready var hud := $"/root/Base_Map/HUD"
@onready var hud2 := $"/root/Base_Map/PanelHUD"
@onready var sessionVar = get_node("/root/Seshvar")
# Called when the node enters the scene tree for the first time.
func _ready():
	hud._close_panel()
	hud.close_player_input()
	hud2._close_panel()
	
	if sessionVar._session:
		var username = sessionVar._session.get("username")
	else:
		SceneTransition.change_scene("res://../menu/Login.tscn")
	pass # Replace with function body.

func _on_dialogue_closed():
	print("Dialogue closed!")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	change_scene()
#
#
#func _on_area_2d_body_entered(body):
#	if body.has_method("player"):
#		Global.transition_scene = true
#
#
#
#func _on_area_2d_body_exited(body):
#	if body.has_method("player"):
#		Global.transition_scene = false
#
#func change_scene():
#	if Global.transition_scene == true:
#		if Global.current_scene == "world":
#			get_tree().change_scene_to_file("res://World/office1/office1.tscn")
#			Global.finish_changescenes() 
