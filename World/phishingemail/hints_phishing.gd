extends CanvasLayer

@onready var hud = $"../HUD"

func interact() -> void:
	print("interaction started")
	var dialogue = """
		<<Hints>>
		1) Caren's Email [right]<![INCOMPLETE]!>[/right]
		2) Danny's Email [right]<![INCOMPLETE]!>[/right]
		3) Elen's Email [right]<![INCOMPLETE]!>[/right]
		4) Frank's Email [right]<![INCOMPLETE]!>[/right]
		5) Gary's Email [right]<![INCOMPLETE]!>[/right]
		6) Haley's Email [right]<![INCOMPLETE]!>[/right]
		7) John's Email [right]<![INCOMPLETE]!>[/right]
		
		[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]EXIT[/url]?>[/right]
	"""
	
	if Score.get_has_correct("phishingemail2", "socialengineering"):
		dialogue = dialogue.replace("Caren's Email [right]<![INCOMPLETE]!>[/right]", "Caren's Email [right]<~[COMPLETED]~>[/right]")
	if Score.get_has_correct("phishingemail3", "socialengineering"):
		dialogue = dialogue.replace("Danny's Email [right]<![INCOMPLETE]!>[/right]", "Danny's Email [right]<~[COMPLETED]~>[/right]")
	if Score.get_has_correct("realemail1", "socialengineering"):
		dialogue = dialogue.replace("Elen's Email [right]<![INCOMPLETE]!>[/right]", "Elen's Email [right]<~[COMPLETED]~>[/right]")
	if Score.get_has_correct("realemail2", "socialengineering"):
		dialogue = dialogue.replace("Frank's Email [right]<![INCOMPLETE]!>[/right]", "Frank's Email [right]<~[COMPLETED]~>[/right]")
	if Score.get_has_correct("realemail3", "socialengineering"):
		dialogue = dialogue.replace("Gary's Email [right]<![INCOMPLETE]!>[/right]", "Gary's Email [right]<~[COMPLETED]~>[/right]")
	if Score.get_has_correct("realemail4", "socialengineering"):
		dialogue = dialogue.replace("Haley's Email [right]<![INCOMPLETE]!>[/right]", "Haley's Email [right]<~[COMPLETED]~>[/right]")
	if Score.get_has_correct("phishingemail1", "socialengineering"):
		dialogue = dialogue.replace("John's Email [right]<![INCOMPLETE]!>[/right]", "John's Email [right]<~[COMPLETED]~>[/right]")

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

