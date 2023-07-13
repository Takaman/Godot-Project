extends CanvasLayer

@onready var hud = $"../HUD"

func interact() -> void:
	print("interaction started")
	var dialogue = """

		[center] 1) Thumbdrive <![INCOMPLETE]!> [/center]
		[center] 2) Weak Password <![INCOMPLETE]!> [/center]
		[center] 3) System Update <![INCOMPLETE]!> [/center]
		[center] 4) Messy Desk <![INCOMPLETE]!> [/center]
		[center] 5) Adware <![INCOMPLETE]!> [/center]
		
		[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]EXIT[/url]?>[/right]
	"""
	
	if Score.get_has_correct("thumbdrive1", "socialengineering"):
		dialogue = dialogue.replace("Thumbdrive <![INCOMPLETE]!>", "Thumbdrive <~[COMPLETED]~>")
	if Score.get_has_correct("passwordpolicy", "policy"):
		dialogue = dialogue.replace("Weak Password <![INCOMPLETE]!>", "Weak Password <~[COMPLETED]~>")
	if Score.get_has_correct("laptop5", "policy"):
		dialogue = dialogue.replace("System Update <![INCOMPLETE]!>", "System Update <~[COMPLETED]~>")
	if Score.get_has_correct("messyarea1", "policy"):
		dialogue = dialogue.replace("Messy Desk <![INCOMPLETE]!>", "Messy Desk <~[COMPLETED]~>")
	if Score.get_has_correct("laptop16", "malware"):
		dialogue = dialogue.replace("Adware <![INCOMPLETE]!>", "Adware <~[COMPLETED]~>")

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

