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
							 
				<?[url=$lvl1][right]Office Policies[/right][/url]?>
				<?[url=$lvl2][right]Phishing[/right][/url]?>
				"""
				),
				"$lvl1":Utils.dialog_part("""Going to office policies."""), 
				"$lvl2":Utils.dialog_part("""Going to phishing.""")
			},
			"training"
		)
		
func _on_hud_partsignaller():
	if hud.part_name == "$lvl1":
		SceneTransition.change_scene("res://World/office1/office1.tscn")
	elif hud.part_name == "$lvl2":
		SceneTransition.change_scene("res://World/phishingemail/house_internal_phishingemail.tscn")

#func _on_hud_lvl_1():
#	if Global.save_state("Base_Map", "world_saved") == true:
#		print("saved")
#	if ResourceLoader.exists("res://Save_States/office1_saved.tscn"):
#		SceneTransition.change_scene("res://Save_States/office1_saved.tscn")
#	else:
#		SceneTransition.change_scene("res://World/office1/office1.tscn")
#
#func _on_hud_lvl_2():
#	if Global.save_state("Base_Map", "world_saved") == true:
#		print("saved")
#	if ResourceLoader.exists("res://Save_States/house_internal_phishingemail_saved.tscn"):
#		SceneTransition.change_scene("res://Save_States/house_internal_phishingemail_saved.tscn")
#	else:
#		SceneTransition.change_scene("res://World/phishingemail/house_internal_phishingemail.tscn")


