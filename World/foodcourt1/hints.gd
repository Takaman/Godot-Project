extends CanvasLayer

@onready var hud := $"/root/FoodCourt/HUD"

func interact() -> void:
	print("interaction started")
	var dialogue = """
		<<Hints>>
		1) Tailgating [right]<![INCOMPLETE]!>[/right]
		2) Reporting Suspicious Activity [right]<![INCOMPLETE]!>[/right]
		3) SensitiveInformation [right]<![INCOMPLETE]!>[/right]
		4) SensitiveInformation(part2) [right]<![INCOMPLETE]!>[/right]
		5) Sharepassword [right]<![INCOMPLETE]!>[/right]
		
		
		[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]EXIT[/url]?>[/right]
	"""
	
	if Score.get_has_correct("tailgate", "socialengineering"):
		dialogue = dialogue.replace("Tailgating [right]<![INCOMPLETE]!>[/right]", "Tailgating [right]<~[COMPLETED]~>>[/right]")
	if Score.get_has_correct("ReportSusAct", "policy"):
		dialogue = dialogue.replace("Reporting Suspicious Activity [right]<![INCOMPLETE]!>[/right]", "Reporting Suspicious Activity [right]<~[COMPLETED]~>>[/right]")
	if Score.get_has_correct("sensitiveinformation", "policy"):
		dialogue = dialogue.replace("SensitiveInformation [right]<![INCOMPLETE]!>[/right]", "SensitiveInformation [right]<~[COMPLETED]~>>[/right]")
	if Score.get_has_correct("sensitiveinformationadvanced", "policy"):
		dialogue = dialogue.replace("SensitiveInformation(part2) [right]<![INCOMPLETE]!>[/right]", "SensitiveInformation(part2) [right]<~[COMPLETED]~>>[/right]")
	if Score.get_has_correct("sharepassword","policy"):
		dialogue = dialogue.replace("Sharepassword [right]<![INCOMPLETE]!>[/right]", "Sharepassword [right]<~[COMPLETED]~>>[/right]")	
	
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

