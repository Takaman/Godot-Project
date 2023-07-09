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
				
				[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$lvl0]Ground Floor[/url]?>[/right]
				[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$lvl1]Food Court[/url]?>[/right]
				[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$lvl2]Office Policies[/url]?>[/right]
				[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$lvl3]Phishing[/url]?>[/right]
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
