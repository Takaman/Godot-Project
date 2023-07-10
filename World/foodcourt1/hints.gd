extends CanvasLayer

@onready var hud := $"/root/FoodCourt/HUD"
@onready var interactable := $"/root/FoodCourt/QuestionmarkFolder/Interactablehint"


func interact() -> void:
	print("interaction started")
	var dialogue = """
		There are currently 3 bad practices and 1 social engineering challenge that you need to find in this room. Good luck in finding the 4 challenges in this room.
		
		Whenever you successfully complete a question, the status of the hint will change from <![INCOMPLETED]"!> to <~[COMPLETED]~>.
		
		<<Hints>>
		1)Tailgating - Look for a guy with a white shirt and red hair. <![INCOMPLETED]!>
		2)SensitiveInformation - Look for a dustbin. <![INCOMPLETED]!>
		3)SensitiveInformation(part2)- Look for a female standing beside the dustbin. <![INCOMPLETED]!>
		4)Sharepassword - Look for a whiteboard. <![INCOMPLETED]!>
		
		
		<?[url=$end]EXIT[/url]?>
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
