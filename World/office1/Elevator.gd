extends Sprite2D

@onready var hud := $"/root/Office1/HUD"
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
							 
				<?[url=$lvl0][right]Ground Floor[/right][/url]?>
				<?[url=$lvl2][right]Phishing[/right][/url]?>
				"""
				),
				"$lvl0":Utils.dialog_part("""Going to ground floor."""), 
				"$lvl2":Utils.dialog_part("""Going to phishing.""")
			},
			"training"
		)

func _on_hud_partsignaller():
	if hud.part_name == "$lvl0":
		SceneTransition.change_scene("res://World/world.tscn")
	elif hud.part_name == "$lvl2":
		SceneTransition.change_scene("res://World/phishingemail/house_internal_phishingemail.tscn")
		
#func _on_hud_lvlbase():
##	if Global.save_state("Office1", "office1_saved") == true:
##		print("saved")
#	if ResourceLoader.exists("res://Save_States/world_saved.tscn"):
#		SceneTransition.change_scene("res://Save_States/world_saved.tscn")
#	else:
#		SceneTransition.change_scene("res://World/world.tscn")
#
#
#func _on_hud_lvl_2():
##	if Global.save_state("Office1", "office1_saved") == true:
##		print("saved")
#	if ResourceLoader.exists("res://Save_States/house_internal_phishingemail_saved.tscn"):
#		SceneTransition.change_scene("res://Save_States/house_internal_phishingemail_saved.tscn")
#	else:
#		SceneTransition.change_scene("res://World/phishingemail/house_internal_phishingemail.tscn")

