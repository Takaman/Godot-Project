extends CanvasLayer

@onready var hud = $"../HUD"

func interact() -> void:
	print("interaction started")
	var dialogue = """

		[center] 1) Thumbdrive <#[INCOMPLETE]#> [/center]
		
		[center] 2) Weak Password <#[INCOMPLETE]#> [/center]
		
		[center] 3) System Update <#[INCOMPLETE]#> [/center]
		
		[center] 4) Messy Desk <#[INCOMPLETE]#> [/center]
		
		[center] 5) Adware <#[INCOMPLETE]#> [/center]
		
		[center] 6) Ransomware <#[INCOMPLETE]#> [/center]
		
		[center] 7) Insider Threat <#[INCOMPLETE]#> [/center]
		
		[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]EXIT[/url]?>[/right]
	"""
	
	if Score.get_result("thumbdrive1", "socialengineering") == 1:
		dialogue = dialogue.replace("Thumbdrive <#[INCOMPLETE]#>", "Thumbdrive <~[COMPLETED]~>")
		dialogue = dialogue.replace("Thumbdrive <![WRONG]!>", "Thumbdrive <~[COMPLETED]~>")
	if Score.get_result("passwordpolicy", "policy") == 1:
		dialogue = dialogue.replace("Weak Password <#[INCOMPLETE]#>", "Weak Password <~[COMPLETED]~>")
		dialogue = dialogue.replace("Weak Password <![WRONG]!>", "Weak Password <~[COMPLETED]~>")
	if Score.get_result("laptop5", "policy") == 1:
		dialogue = dialogue.replace("System Update <#[INCOMPLETE]#>", "System Update <~[COMPLETED]~>")
		dialogue = dialogue.replace("System Update <![WRONG]!>", "System Update <~[COMPLETED]~>")
	if Score.get_result("messyarea1", "policy") == 1:
		dialogue = dialogue.replace("Messy Desk <#[INCOMPLETE]#>", "Messy Desk <~[COMPLETED]~>")
		dialogue = dialogue.replace("Messy Desk <![WRONG]!>", "Messy Desk <~[COMPLETED]~>")
	if Score.get_result("laptop16", "malware") == 1:
		dialogue = dialogue.replace("Adware <#[INCOMPLETE]#>", "Adware <~[COMPLETED]~>")
		dialogue = dialogue.replace("Adware <![WRONG]!>", "Adware <~[COMPLETED]~>")
	if Score.get_result("ransomware", "malware") == 1:
		dialogue = dialogue.replace("Ransomware <#[INCOMPLETE]#>", "Ransomware <~[COMPLETED]~>")
		dialogue = dialogue.replace("Ransomware <![WRONG]!>", "Ransomware <~[COMPLETED]~>")
	if Score.get_result("insiderthreat1", "policy") == 1:
		dialogue = dialogue.replace("Insider Threat <#[INCOMPLETE]#>", "Insider Threat <~[COMPLETED]~>")
		dialogue = dialogue.replace("Insider Threat <![WRONG]!>", "Insider Threat <~[COMPLETED]~>")
		
	if Score.get_result("thumbdrive1", "socialengineering") == 2:
		dialogue = dialogue.replace("Thumbdrive <#[INCOMPLETE]#>", "Thumbdrive <![WRONG]!>")
	if Score.get_result("passwordpolicy", "policy") == 2:
		dialogue = dialogue.replace("Weak Password <#[INCOMPLETE]#>", "Weak Password <![WRONG]!>")
	if Score.get_result("laptop5", "policy") == 2:
		dialogue = dialogue.replace("System Update <#[INCOMPLETE]#>", "System Update <![WRONG]!>")
	if Score.get_result("messyarea1", "policy") == 2:
		dialogue = dialogue.replace("Messy Desk <#[INCOMPLETE]#>", "Messy Desk <![WRONG]!>")
	if Score.get_result("laptop16", "malware") == 2:
		dialogue = dialogue.replace("Adware <#[INCOMPLETE]#>", "Adware <![WRONG]!>")
	if Score.get_result("ransomware", "malware") == 2:
		dialogue = dialogue.replace("Ransomware <#[INCOMPLETE]#>", "Ransomware <![WRONG]!>")
	if Score.get_result("insiderthreat1", "policy") == 2:
		dialogue = dialogue.replace("Insider Threat <#[INCOMPLETE]#>", "Insider Threat <![WRONG]!>")

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

