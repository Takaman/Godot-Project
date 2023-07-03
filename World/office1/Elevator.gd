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
							 
				<?[url=$end:lvlbase][right]Outside[/right][/url]?>
				<?[url=$end:lvl2][right]Phishing[/right][/url]?>
				"""
				)
			},
			"training"
		)
		
func _on_hud_lvlbase():
#	if Global.save_state("Office1", "office1_saved") == true:
#		print("saved")
	if ResourceLoader.exists("res://Save_States/world_saved.tscn"):
		SceneTransition.change_scene("res://Save_States/world_saved.tscn")
	else:
		SceneTransition.change_scene("res://World/world.tscn")


func _on_hud_lvl_2():
#	if Global.save_state("Office1", "office1_saved") == true:
#		print("saved")
	if ResourceLoader.exists("res://Save_States/house_internal_phishingemail_saved.tscn"):
		SceneTransition.change_scene("res://Save_States/house_internal_phishingemail_saved.tscn")
	else:
		SceneTransition.change_scene("res://World/phishingemail/house_internal_phishingemail.tscn")
