extends CanvasLayer

@onready var hud := $"/root/FoodCourt/HUD"

func interact() -> void:
	print("interaction started")
	var dialogue = """
		<<Hints>>
		1) Tailgating - Guy with a white shirt and red hair <![INCOMPLETED]!>
		2) SensitiveInformation - Dustbin <![INCOMPLETED]!>
		3) SensitiveInformation(part2)- Female standing beside a dustbin <![INCOMPLETED]!>
		4) Sharepassword - Whiteboard <![INCOMPLETED]!>
		
		
		[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]EXIT[/url]?>[/right]
	"""
	
	if Score.get_has_correct("tailgate", "socialengineering"):
		dialogue = dialogue.replace("Guy with a white shirt and red hair <![INCOMPLETED]!>", "Guy with a white shirt and red hair <~[COMPLETED]~>")
	if Score.get_has_correct("sensitiveinformation", "policy"):
		dialogue = dialogue.replace("SensitiveInformation - Dustbin <![INCOMPLETED]!>", "SensitiveInformation - Dustbin <~[COMPLETED]~>")
	if Score.get_has_correct("sensitiveinformationadvanced", "policy"):
		dialogue = dialogue.replace("SensitiveInformation(part2)- Female standing beside a dustbin <![INCOMPLETED]!>", "SensitiveInformation(part2)- Female standing beside a dustbin <~[COMPLETED]~>")
	if Score.get_has_correct("sharepassword","policy"):
		dialogue = dialogue.replace("Sharepassword - Whiteboard <![INCOMPLETED]!>", "Sharepassword - Whiteboard <~[COMPLETED]~>")	
	
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

