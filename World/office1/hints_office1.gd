extends CanvasLayer

@onready var hud = $"../HUD"

func interact() -> void:
	print("interaction started")
	var dialogue = """
		<<Hints>>
		1) QR Code - Vending Machine <![INCOMPLETED]!>
		2) Thumbdrive <![INCOMPLETED]!>
		3) Weakpassword <![INCOMPLETED]!>
		4) System Update <![INCOMPLETED]!>
		5) Unattended Device <![INCOMPLETED]!>
		6) Messy Desk <![INCOMPLETED]!>
		7) Adware <![INCOMPLETED]!>
		
		
		[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]EXIT[/url]?>[/right]
	"""
	
	if Score.get_has_correct("vendingmachine1", "socialengineering"):
		dialogue = dialogue.replace("QR Code - Vending Machine <![INCOMPLETED]!>", "QR Code - Vending Machine <~[COMPLETED]~>")
	if Score.get_has_correct("thumbdrive1", "socialengineering"):
		dialogue = dialogue.replace("Thumbdrive <![INCOMPLETED]!>", "Thumbdrive <~[COMPLETED]~>")
	if Score.get_has_correct("passwordpolicy", "policy"):
		dialogue = dialogue.replace("Weakpassword <![INCOMPLETED]!>", "Weakpassword <~[COMPLETED]~>")
	if Score.get_has_correct("laptop5", "policy"):
		dialogue = dialogue.replace("System Update <![INCOMPLETED]!>", "System Update <~[COMPLETED]~>")
	if Score.get_has_correct("unattendedlaptop", "policy"):
		dialogue = dialogue.replace("Unattended Device <![INCOMPLETED]!>", "Unattended Device <~[COMPLETED]~>")
	if Score.get_has_correct("messyarea1", "policy"):
		dialogue = dialogue.replace("Messy Desk <![INCOMPLETED]!>", "Messy Desk <~[COMPLETED]~>")
	if Score.get_has_correct("laptop16", "malware"):
		dialogue = dialogue.replace("Adware <![INCOMPLETED]!>", "Adware <~[COMPLETED]~>")

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

