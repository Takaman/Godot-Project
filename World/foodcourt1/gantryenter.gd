extends Sprite2D

@onready var hud := $"/root/FoodCourt/HUD"

func interact() -> void:
	print("interaction started")
	queue_free()
	hud.show_dialog(
		"gantryenter",
		{
			"$begin":
				Utils.dialog_part(
					"""
					Please scan your access card to enter the facility. 
					<?[url=$enter]1) Sure [/url]?>
					<?[url=$noenter]2) Okay [/url]?>
					"""
				),
			"$enter":
				Utils.dialog_part(
					"""
					You have entered the room
					<?[url=$end]EXIT[/url]?>
					"""
				),
			"$noenter":
				Utils.dialog_part(
					"""
					You have entered the room
					<?[url=$end]EXIT[/url]?>
					"""
				),
			"$end":
				Utils.dialog_part("Thank you for your response!")
		},
		"training"
	)

func _on_dialogue_closed(option_chosen: String) -> void:
	if option_chosen == "$enter":
		queue_free()  # Remove the object when the player chooses to enter
