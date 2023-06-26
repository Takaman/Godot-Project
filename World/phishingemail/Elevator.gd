extends Sprite2D

@onready var hud := $"/root/house_internal_phishingemail/HUD"

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
				<?[url=$end:lvl1][right]Office Policies[/right][/url]?>
				"""
				)
			},
			"training"
		)


func _on_hud_lvlbase():
	get_tree().change_scene_to_file("res://World/world.tscn")

func _on_hud_lvl_1():
	get_tree().change_scene_to_file("res://World/office1/office1.tscn")
