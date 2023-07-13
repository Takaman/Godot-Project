extends CanvasLayer

@onready var hud := $"/root/FoodCourt/HUD"

func interact() -> void:
	print("interaction started")
	var dialogue = """
	
		[center] 1) Tailgating <![INCOMPLETE]!> [/center]
		
		[center] 2) Reporting Suspicious Activity <![INCOMPLETE]!> [/center]
		
		[center] 3) SensitiveInformation <![INCOMPLETE]!> [/center]
		
		[center] 4) SensitiveInformation(part2) <![INCOMPLETE]!> [/center]
		
		[center] 5) Sharepassword <![INCOMPLETE]!> [/center]
		
		[center] 6) QR Code <![INCOMPLETE]!> [/center]
		
		[center] 7) Unattended Device <![INCOMPLETE]!> [/center]
		
		[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]EXIT[/url]?>[/right]
	"""
	
	if Score.get_has_correct("tailgate", "socialengineering"):
		dialogue = dialogue.replace("Tailgating <![INCOMPLETE]!>", "Tailgating <~[COMPLETED]~>>")
	if Score.get_has_correct("ReportSusAct", "policy"):
		dialogue = dialogue.replace("Reporting Suspicious Activity <![INCOMPLETE]!>", "Reporting Suspicious Activity <~[COMPLETED]~>>")
	if Score.get_has_correct("sensitiveinformation", "policy"):
		dialogue = dialogue.replace("SensitiveInformation <![INCOMPLETE]!>", "SensitiveInformation <~[COMPLETED]~>>")
	if Score.get_has_correct("sensitiveinformationadvanced", "policy"):
		dialogue = dialogue.replace("SensitiveInformation(part2) <![INCOMPLETE]!>", "SensitiveInformation(part2) <~[COMPLETED]~>>")
	if Score.get_has_correct("sharepassword","policy"):
		dialogue = dialogue.replace("Sharepassword <![INCOMPLETE]!>", "Sharepassword <~[COMPLETED]~>>")
	if Score.get_has_correct("vendingmachine1", "socialengineering"):
		dialogue = dialogue.replace("QR Code <![INCOMPLETE]!>", "QR Code <~[COMPLETED]~>")
	if Score.get_has_correct("unattendedlaptop", "policy"):
		dialogue = dialogue.replace("Unattended Device <![INCOMPLETE]!>", "Unattended Device <~[COMPLETED]~>")
		
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

