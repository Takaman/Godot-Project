extends CanvasLayer

@onready var hud := $"/root/Base_Map/HUD"

func interact() -> void:
	print("interaction started")
	var dialogue = """
	
		[center] 1) QR Code <#[INCOMPLETE]#> [/center]
		
		[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]EXIT[/url]?>[/right]
	"""
	
	if Score.get_result("poster1", "socialengineering") == 1:
		dialogue = dialogue.replace("QR Code <#[INCOMPLETE]#>", "QR Code <~[COMPLETE]!!~>")
		
	hud.show_dialog(
		"hints",
		{
			"$begin": Utils.dialog_part(dialogue),
		},
		"hints"
	)

func _on_button_pressed():
	print("interactable!")
	interact()

