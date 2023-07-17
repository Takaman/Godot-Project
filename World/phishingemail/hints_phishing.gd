extends CanvasLayer

@onready var hud = $"../HUD"

func interact() -> void:
	print("interaction started")
	var dialogue = """

		[center] 1) Caren's Email <#[INCOMPLETE]#> [/center]
		
		[center] 2) Danny's Email <#[INCOMPLETE]#> [/center]
		
		[center] 3) Elen's Email <#[INCOMPLETE]#> [/center]
		
		[center] 4) Frank's Email <#[INCOMPLETE]#> [/center]
		
		[center] 5) Gary's Email <#[INCOMPLETE]#> [/center]
		
		[center] 6) Haley's Email <#[INCOMPLETE]#> [/center]
		
		[center] 7) John's Email <#[INCOMPLETE]#> [/center]
		
		[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]EXIT[/url]?>[/right]
	"""
	
	if Score.get_result("phishingemail2", "socialengineering") == 1:
		dialogue = dialogue.replace("Caren's Email <#[INCOMPLETE]#>", "Caren's Email <~[CORRECT]~>")
	elif Score.get_result("phishingemail2", "socialengineering") == 2:
		dialogue = dialogue.replace("Caren's Email <#[INCOMPLETE]#>", "Caren's Email <![WRONG]!>")
	
	if Score.get_result("phishingemail3", "socialengineering") == 1:
		dialogue = dialogue.replace("Danny's Email <#[INCOMPLETE]#>", "Danny's Email <~[CORRECT]~>")
	elif Score.get_result("phishingemail3", "socialengineering") == 2:
		dialogue = dialogue.replace("Danny's Email <#[INCOMPLETE]#>", "Danny's Email <![WRONG]!>")
	
	if Score.get_result("realemail1", "socialengineering") == 1:
		dialogue = dialogue.replace("Elen's Email <#[INCOMPLETE]#>", "Elen's Email <~[CORRECT]~>")
	elif Score.get_result("realemail1", "socialengineering") == 2:
		dialogue = dialogue.replace("Elen's Email <#[INCOMPLETE]#>", "Elen's Email <![WRONG]!>")
	
	if Score.get_result("realemail2", "socialengineering") == 1:
		dialogue = dialogue.replace("Frank's Email <#[INCOMPLETE]#>", "Frank's Email <~[CORRECT]~>")
	elif Score.get_result("realemail2", "socialengineering") == 2:
		dialogue = dialogue.replace("Frank's Email <#[INCOMPLETE]#>", "Frank's Email <![WRONG]!>")
	
	if Score.get_result("realemail3", "socialengineering") == 1:
		dialogue = dialogue.replace("Gary's Email <#[INCOMPLETE]#>", "Gary's Email [<~[CORRECT]~>")
	elif Score.get_result("realemail3", "socialengineering") == 2:
		dialogue = dialogue.replace("Gary's Email <#[INCOMPLETE]#>", "Gary's Email <![WRONG]!>")
	
	if Score.get_result("realemail4", "socialengineering") == 1:
		dialogue = dialogue.replace("Haley's Email <#[INCOMPLETE]#>", "Haley's Email <~[CORRECT]~>")
	elif Score.get_result("realemail4", "socialengineering") == 2:
		dialogue = dialogue.replace("Haley's Email <#[INCOMPLETE]#>", "Haley's Email <![WRONG]!>")
	
	if Score.get_result("phishingemail1", "socialengineering") == 1:
		dialogue = dialogue.replace("John's Email <#[INCOMPLETE]#>", "John's Email <~[CORRECT]~>")
	elif Score.get_result("phishingemail1", "socialengineering") == 2:
		dialogue = dialogue.replace("John's Email <#[INCOMPLETE]#>", "John's Email <![WRONG]!>")

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

