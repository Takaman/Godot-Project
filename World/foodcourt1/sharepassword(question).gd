extends Sprite2D


@onready var hud := $"/root/FoodCourt/HUD"
@onready var interactable := $"/root/FoodCourt/QuestionmarkFolder/Interactablewhiteboard"

func interact() -> void:
	print("interaction started")
	hud.show_dialog(
		"sharepassword",
		{
			"$begin":
			Utils.dialog_part(
				"""
				There is a password written on the whiteboard for everyone to see. This poses a significant security risk as it allows unauthorized individuals to easily access sensitive information


				<?[url=$change:correct]1) I will immediately erase the password from the whiteboard to prevent unauthorized access and protect our sensitive information [/url]?>
				<?[url=$nochange:wrong]2) I don't think it's a problem to leave the password there. We trust our team, and it's convenient for everyone to have easy access to it. [/url]?>
				
				"""
			),
			"$change":
				Utils.dialog_part(
				"""
That's the correct decision. By removing the password from the whiteboard, you are taking a proactive step to enhance security and protect our data.
<?[url=$end]EXIT[/url]?>
				"""
				),
			"$nochange":
				Utils.dialog_part(
				"""
That is a horrible choice. Leaving password visible compromises the security of our systems and sensitive information.

It's important to prioritize data protection by removing the password from the whiteboard and implementing more secure methods for sharing passwords.
<?[url=$end]EXIT[/url]?>
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
		interactable.visible  = !Score.get_has_correct("sharepassword","policy")

