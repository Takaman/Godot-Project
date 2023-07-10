extends CanvasLayer

@onready var hud := $"/root/FoodCourt/HUD"
@onready var interactable := $"/root/FoodCourt/QuestionmarkFolder/Interactablehint"


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
		dialogue = dialogue.replace("red hair. <![INCOMPLETED]!>", "red hair. <~[COMPLETED]~>")
	if Score.get_has_correct("sensitiveinformation", "policy"):
		dialogue = dialogue.replace("a dustbin. <![INCOMPLETED]!>", "a dustbin <~[COMPLETED]~>")
	if Score.get_has_correct("sensitiveinformationadvanced", "policy"):
		dialogue = dialogue.replace("the dustbin. <![INCOMPLETED]!>", "the dustbin <~[COMPLETED]~>")
	if Score.get_has_correct("sharepassword","policy"):
		dialogue = dialogue.replace("whiteboard. <![INCOMPLETED]!>", "whiteboard. <~[COMPLETED]~>")	
	
	hud.show_dialog(
		"hints",
		{
			"$begin": Utils.dialog_part(dialogue),
		},
		"hints"
	)
	
		
func _physics_process(delta: float) -> void:
	if interactable != null and interactable is Node:
		interactable.visible 


func _on_button_pressed():
	print("interactable!")
	interact()

