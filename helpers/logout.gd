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
				[center]<![url=$logout]Logout[/url]!>[/center]
				[center]<![url=$quit]Quit[/url]!>[/center]
				[center]<![url=$end]Back[/url]!>[/center]
				"""
			),
			"$logout": Utils.dialog_part(
				"""
				[center]Are you sure you want to logout?[/center]
				[center]<![url=$logoutcnfm]Logout[/url]!>[/center]
				[center]<![url=$begin]Back[/url]!>[/center]
				"""
			),
			"$quit": Utils.dialog_part(
				"""
				[center]Are you sure you want to quit?[/center]
				[center]<![url=$quitcnfm]Quit[/url]!>[/center]
				[center]<![url=$begin]Back[/url]!>[/center]
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
