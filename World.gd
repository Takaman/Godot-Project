extends Node2D

signal world_changed(map_name)
signal dialogue_closed

@onready var hud := $"/root/Base_Map/HUD"

# Called when the node enters the scene tree for the first time.
func _ready():
	if Global.hud_shown == false:
		
		hud.show_dialog(		
			"welcome",
			{
				"$begin":
				Utils.dialog_part(
					"""
					We at ITPGroup11 welcome you as our new employee :) Give yourself some time to explore this part of building and then complete challenges in the building! 
					
					Remember to have fun!

					Use the arrow keys <! ↑ ↓ → ← !> to move, <! E !>to interact, and use your mouse to select options.

					[center]<?[url=$end]CLOSE[/url]?>[/center]
					"""
				),
			},
			"training"
			
			)
		Global.hud_shown = true
	
	pass # Replace with function body.

func _on_dialogue_closed():
	print("Dialogue closed!")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	change_scene()


func _on_area_2d_body_entered(body):
	if body.has_method("player"):
		Global.transition_scene = true
		


func _on_area_2d_body_exited(body):
	if body.has_method("player"):
		Global.transition_scene = false
	
func change_scene():
	if Global.transition_scene == true:
		if Global.current_scene == "world":
			get_tree().change_scene_to_file("res://World/office1/office1.tscn")
			Global.finish_changescenes() 
