extends Sprite2D

@onready var hud := $"/root/Office1/HUD"

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
	get_tree().change_scene_to_file("res://World/world.tscn")


func _on_hud_lvl_2():
	get_tree().change_scene_to_file("res://World/phishingemail/house_internal_phishingemail.tscn")
