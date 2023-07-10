extends CanvasLayer

@onready var hud = $"../HUD"

func interact() -> void:
	print("interaction started")
	var dialogue = """
		<<Hints>>
		1) QR Code - Vending Machine [right]<![INCOMPLETE]!>[/right]
		2) Thumbdrive [right]<![INCOMPLETE]!>[/right]
		3) Weakpassword [right]<![INCOMPLETE]!>[/right]
		4) System Update [right]<![INCOMPLETE]!>[/right]
		5) Unattended Device [right]<![INCOMPLETE]!>[/right]
		6) Messy Desk [right]<![INCOMPLETE]!>[/right]
		7) Adware [right]<![INCOMPLETE]!>[/right]
		
		
		[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]EXIT[/url]?>[/right]
	"""
	
	if Score.get_has_correct("vendingmachine1", "socialengineering"):
		dialogue = dialogue.replace("QR Code - Vending Machine [right]<![INCOMPLETE]!>[/right]", "QR Code - Vending Machine [right]<~[COMPLETED]~>[/right]")
	if Score.get_has_correct("thumbdrive1", "socialengineering"):
		dialogue = dialogue.replace("Thumbdrive [right]<![INCOMPLETE]!>[/right]", "Thumbdrive [right]<~[COMPLETED]~>[/right]")
	if Score.get_has_correct("passwordpolicy", "policy"):
		dialogue = dialogue.replace("Weakpassword [right]<![INCOMPLETE]!>[/right]", "Weakpassword [right]<~[COMPLETED]~>[/right]")
	if Score.get_has_correct("laptop5", "policy"):
		dialogue = dialogue.replace("System Update [right]<![INCOMPLETE]!>[/right]", "System Update [right]<~[COMPLETED]~>[/right]")
	if Score.get_has_correct("unattendedlaptop", "policy"):
		dialogue = dialogue.replace("Unattended Device [right]<![INCOMPLETE]!>[/right]", "Unattended Device [right]<~[COMPLETED]~>[/right]")
	if Score.get_has_correct("messyarea1", "policy"):
		dialogue = dialogue.replace("Messy Desk [right]<![INCOMPLETE]!>[/right]", "Messy Desk [right]<~[COMPLETED]~>[/right]")
	if Score.get_has_correct("laptop16", "malware"):
		dialogue = dialogue.replace("Adware [right]<![INCOMPLETE]!>[/right]", "Adware [right]<~[COMPLETED]~>[/right]")

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

