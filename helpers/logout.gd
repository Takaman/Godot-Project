extends CanvasLayer
@onready var sessionVar = get_node("/root/SeshVar")
@onready var hud = $"../HUD"

func interact() -> void:
	print("interaction started")
	
	hud.show_dialog(
		"logout",
		{
			"$begin": Utils.dialog_part(
				"""
				[center][img=12x12]res://World/HUD/Pointer.png[/img][url=$logout][color=blue]Logout[/color][/url][/center]
				
				[center][img=12x12]res://World/HUD/Pointer.png[/img][url=$quit][color=blue]Quit[/color][/url][/center]
				
				[center][img=12x12]res://World/HUD/Pointer.png[/img][url=$end][color=red]Back[/color][/url][/center]
				"""
			),
			"$logout": Utils.dialog_part(
				"""
				[center]Are you sure you want to logout?[/center]
				
				
				[center][img=12x12]res://World/HUD/Pointer.png[/img][url=$logoutcnfm][color=blue]Logout[/color][/url][/center]
				
				[center][img=12x12]res://World/HUD/Pointer.png[/img][url=$begin][color=red]Back[/color][/url][/center]
				"""
			),
			"$quit": Utils.dialog_part(
				"""
				[center]Are you sure you want to quit?[/center]
				
				
				[center][img=12x12]res://World/HUD/Pointer.png[/img][url=$quitcnfm][color=blue]Quit[/color][/url][/center]
				
				[center][img=12x12]res://World/HUD/Pointer.png[/img][url=$begin][color=red]Back[/color][/url][/center]
				"""
			),
			"$logoutcnfm": Utils.dialog_part("""[center]Logging out...[/center]"""),
			"$quitcnfm": Utils.dialog_part("""[center]Quitting...[/center]""")
		},
		"logout"
	)

func _on_button_pressed():
	print("interactable!")
	interact()

func _on_hud_partsignaller():
	if hud.part_name == "$logoutcnfm":
		sessionVar._session = null
		sessionVar.company = null
		SceneTransition.change_scene("res://../menu/Login.tscn")
	if hud.part_name == "$quitcnfm":
		sessionVar._session = null
		sessionVar.company = null
		get_tree().quit()
