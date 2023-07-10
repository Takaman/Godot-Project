extends CanvasLayer

@onready var hud := $"/root/FoodCourt/HUD"

func interact() -> void:
	print("interaction started")
	var dialogue = """
		<<Hints>>
		1) Tailgating - Guy with a white shirt and red hair [right]<![INCOMPLETE]!>[/right]
		2) SensitiveInformation - Dustbin [right]<![INCOMPLETE]!>[/right]
		3) SensitiveInformation(part2)- Female standing beside a dustbin [right]<![INCOMPLETE]!>[/right]
		4) Sharepassword - Whiteboard [right]<![INCOMPLETE]!>[/right]
		
		
		[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]EXIT[/url]?>[/right]
	"""
	
	if Score.get_has_correct("tailgate", "socialengineering"):
		dialogue = dialogue.replace("Guy with a white shirt and red hair [right]<![INCOMPLETE]!>[/right]", "Guy with a white shirt and red hair [right]<~[COMPLETED]~>>[/right]")
	if Score.get_has_correct("sensitiveinformation", "policy"):
		dialogue = dialogue.replace("SensitiveInformation - Dustbin [right]<![INCOMPLETE]!>[/right]", "SensitiveInformation - Dustbin [right]<~[COMPLETED]~>>[/right]")
	if Score.get_has_correct("sensitiveinformationadvanced", "policy"):
		dialogue = dialogue.replace("SensitiveInformation(part2)- Female standing beside a dustbin [right]<![INCOMPLETE]!>[/right]", "SensitiveInformation(part2)- Female standing beside a dustbin [right]<~[COMPLETED]~>>[/right]")
	if Score.get_has_correct("sharepassword","policy"):
		dialogue = dialogue.replace("Sharepassword - Whiteboard [right]<![INCOMPLETE]!>[/right]", "Sharepassword - Whiteboard [right]<~[COMPLETED]~>>[/right]")	
	
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

