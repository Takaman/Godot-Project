extends Sprite2D

@onready var hud := get_tree().get_nodes_in_group("HUD_Group")[0]

func _ready():
	hud.connect("partsignaller", Callable(self,"_on_hud_partsignaller"))
	pass

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
				<?[url=$lvl1][right]Food Court[/right][/url]?>
				<?[url=$lvl2][right]Office Policies[/right][/url]?>
				<?[url=$lvl3][right]Phishing[/right][/url]?>
				"""
				),
				"$lvl0":Utils.dialog_part("""Going to the ground floor."""),
				"$lvl1":Utils.dialog_part("""Going to the food court."""), 
				"$lvl2":Utils.dialog_part("""Going to office policies."""), 
				"$lvl3":Utils.dialog_part("""Going to phishing.""")
			},
			"training"
		)
		
func _on_hud_partsignaller():
	if hud.part_name == "$lvl0":
		SceneTransition.change_scene("res://World/world.tscn")
	elif hud.part_name == "$lvl1":
		SceneTransition.change_scene("res://World/foodcourt1/foodcourt.tscn")
	elif hud.part_name == "$lvl2":
		SceneTransition.change_scene("res://World/office1/office1.tscn")
	elif hud.part_name == "$lvl3":
		SceneTransition.change_scene("res://World/phishingemail/house_internal_phishingemail.tscn")
