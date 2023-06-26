extends Sprite2D

@onready var hud := $"/root/Base_Map/HUD"

func interact() -> void:
	print("interaction started")
	hud.show_dialog(
		"Elevator",
		{
			"$begin":
				Utils.dialog_part(
				"""
				Where would you like to go?
							 
				<?[url=$end:lvl1]Bad Practices, Office1 [/url]?>
				<?[url=$end:lvl2]Phishing, Phishingemail [/url]?>
				"""
				)
			},
			"training"
		)


func _on_hud_lvl_1():
	get_tree().change_scene_to_file("res://World/office1/office1.tscn")

func _on_hud_lvl_2():
	get_tree().change_scene_to_file("res://World/phishingemail/house_internal_phishingemail.tscn")
