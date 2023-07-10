extends Sprite2D


@onready var hud := $"/root/FoodCourt/HUD"
@onready var interactable := $"/root/FoodCourt/QuestionmarkFolder/Interactablewhiteboard"
func _ready():
	interactable.correct()
	pass
	
func interact() -> void:
	print("interaction started")
	hud.show_dialog(
		"sharepassword",
		{
			"$begin":
			Utils.dialog_part(
				"""
				There is a password written on the whiteboard for everyone to see. This poses a significant security risk as it allows unauthorized individuals to easily access sensitive information


				[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$change:correct]I will immediately erase the password from the whiteboard to prevent unauthorized access and protect our sensitive information.[/url]?>[/right]
				[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$nochange:wrong]I don't think it's a problem to leave the password there. We trust our team, and it's convenient for everyone to have easy access to it.[/url]?>[/right]
				
				"""
			),
			"$change":
				Utils.dialog_part(
				"""
That's the correct decision. By removing the password from the whiteboard, you are taking a proactive step to enhance security and protect our data.
[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]EXIT[/url]?>[/right]
				"""
				),
			"$nochange":
				Utils.dialog_part(
				"""
That is a horrible choice. Leaving password visible compromises the security of our systems and sensitive information.

It's important to prioritize data protection by removing the password from the whiteboard and implementing more secure methods for sharing passwords.
[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]EXIT[/url]?>[/right]
				"""
				),
		},
		"policy"
	)
	
func _on_area_2d_area_entered(area):
	print("interactable!")
	if area.is_in_group("Player"):
		interact()


func _physics_process(delta: float) -> void:
	if interactable!= null and interactable is Node:
		interactable.visible  = Score.get_has_correct("sharepassword","policy")

