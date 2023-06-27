extends Sprite2D

@onready var hud := $"/root/Base_Map/HUD"
@onready var scene = PackedScene.new()

func interact() -> void:
	print("interaction started")
	hud.show_dialog(
		"Elevator",
		{
			"$begin":
				Utils.dialog_part(
				"""
				Where would you like to go?
							 
				<?[url=$end:lvl1][right]Office Policies[/right][/url]?>
				<?[url=$end:lvl2][right]Phishing[/right][/url]?>
				"""
				)
			},
			"training"
		)

func save_state():
	var result = scene.pack(get_node("/root/Base_Map"))
	if result == OK:
		var error = ResourceSaver.save(scene, "res://Save_States/world_saved.tscn")
		if error != OK:
			push_error("An error occurred while saving the scene to disk.")
		else:
			print("SAVED")

func _on_hud_lvl_1():
	#save_state()
	if ResourceLoader.exists("res://Save_States/office1_saved.tscn"):
		SceneTransition.change_scene("res://Save_States/office1_saved.tscn")
	else:
		SceneTransition.change_scene("res://World/office1/office1.tscn")

func _on_hud_lvl_2():
	#save_state()
	if ResourceLoader.exists("res://Save_States/house_internal_phishingemail_saved.tscn"):
		SceneTransition.change_scene("res://Save_States/house_internal_phishingemail_saved.tscn")
	else:
		SceneTransition.change_scene("res://World/phishingemail/house_internal_phishingemail.tscn")
