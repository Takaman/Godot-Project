extends CanvasLayer

@onready var hud := $"/root/FoodCourt/HUD"

func interact() -> void:
	print("interaction started")
	var dialogue = """
	
		[center] 1) Tailgating <#[INCOMPLETE]#> [/center]
		
		[center] 2) Reporting Suspicious Activity <#[INCOMPLETE]#> [/center]
		
		[center] 3) SensitiveInformation <#[INCOMPLETE]#> [/center]
		
		[center] 4) SensitiveInformation(part2) <#[INCOMPLETE]#> [/center]
		
		[center] 5) Sharepassword <#[INCOMPLETE]#> [/center]
		
		[center] 6) QR Code <#[INCOMPLETE]#> [/center]
		
		[center] 7) Unattended Device <#[INCOMPLETE]#> [/center]
		
		[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]EXIT[/url]?>[/right]
	"""
	
	if Score.get_result("tailgate", "socialengineering") == 1:
		dialogue = dialogue.replace("Tailgating <#[INCOMPLETE]#>", "Tailgating <~[COMPLETED]~>")
		dialogue = dialogue.replace("Tailgating <![WRONG]!>", "Tailgating <~[COMPLETED]~>")
	if Score.get_result("ReportSusAct", "policy") == 1:
		dialogue = dialogue.replace("Reporting Suspicious Activity <#[INCOMPLETE]#>", "Reporting Suspicious Activity <~[COMPLETED]~>")
		dialogue = dialogue.replace("Reporting Suspicious Activity <![WRONG]!>", "Reporting Suspicious Activity <~[COMPLETED]~>")
	if Score.get_result("sensitiveinformation", "policy") == 1:
		dialogue = dialogue.replace("SensitiveInformation <#[INCOMPLETE]#>", "SensitiveInformation <~[COMPLETED]~>")
		dialogue = dialogue.replace("SensitiveInformation <![WRONG]!>", "SensitiveInformation <~[COMPLETED]~>")
	if Score.get_result("sensitiveinformationadvanced", "policy") == 1:
		dialogue = dialogue.replace("SensitiveInformation(part2) <#[INCOMPLETE]#>", "SensitiveInformation(part2) <~[COMPLETED]~>")
		dialogue = dialogue.replace("SensitiveInformation(part2) <![WRONG]!>", "SensitiveInformation(part2) <~[COMPLETED]~>")
	if Score.get_result("sharepassword","policy") == 1:
		dialogue = dialogue.replace("Sharepassword <#[INCOMPLETE]#>", "Sharepassword <~[COMPLETED]~>")
		dialogue = dialogue.replace("Sharepassword <![WRONG]!>", "Sharepassword <~[COMPLETED]~>")
	if Score.get_result("vendingmachine1", "socialengineering") == 1:
		dialogue = dialogue.replace("QR Code <#[INCOMPLETE]#>", "QR Code <~[COMPLETED]~>")
		dialogue = dialogue.replace("QR Code <![WRONG]!>", "QR Code <~[COMPLETED]~>")
	if Score.get_result("unattendedlaptop", "policy") == 1:
		dialogue = dialogue.replace("Unattended Device <#[INCOMPLETE]#>", "Unattended Device <~[COMPLETED]~>")
		dialogue = dialogue.replace("Unattended Device <![WRONG]!>", "Unattended Device <~[COMPLETED]~>")

	if Score.get_result("tailgate", "socialengineering") == 2:
		dialogue = dialogue.replace("Tailgating <#[INCOMPLETE]#>", "Tailgating <![WRONG]!>")
	if Score.get_result("ReportSusAct", "policy") == 2:
		dialogue = dialogue.replace("Reporting Suspicious Activity <#[INCOMPLETE]#>", "Reporting Suspicious Activity <![WRONG]!>")
	if Score.get_result("sensitiveinformation", "policy") == 2:
		dialogue = dialogue.replace("SensitiveInformation <#[INCOMPLETE]#>", "SensitiveInformation <![WRONG]!>")
	if Score.get_result("sensitiveinformationadvanced", "policy") == 1:
		dialogue = dialogue.replace("SensitiveInformation(part2) <#[INCOMPLETE]#>", "SensitiveInformation(part2) <![WRONG]!>")
	if Score.get_result("sharepassword","policy") == 2:
		dialogue = dialogue.replace("Sharepassword <#[INCOMPLETE]#>", "Sharepassword <![WRONG]!>")
	if Score.get_result("vendingmachine1", "socialengineering") == 2:
		dialogue = dialogue.replace("QR Code <#[INCOMPLETE]#>", "QR Code <![WRONG]!>")
	if Score.get_result("unattendedlaptop", "policy") == 2:
		dialogue = dialogue.replace("Unattended Device <#[INCOMPLETE]#>", "Unattended Device <![WRONG]!>")

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

