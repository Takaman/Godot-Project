extends Sprite2D

@onready var hud := $"/root/FoodCourt/HUD"

func _ready():
	pass
	
func interact() -> void:
	print("interaction started")
	hud.show_dialog(
		"helpdesk",
		{
			"$begin":
				Utils.dialog_part(
					"""
					Hello, how may I assist you today?
					<?[url=$exit:signaller1]Excuse me, I need to find the conference room. Which way should I go? [/url]?>
					<?[url=$noexit:signaller2]Excuse me, I need to find the resting area. Which way should I go?[/url]?>
					"""
				),
			"$exit":
				Utils.dialog_part(
					"""
					The conference room is located behind you. Turn around, and you'll find the conference room
					<?[url=$end]Exit[/url]?>
					"""
				),
			"$noexit":
				Utils.dialog_part(
					"""
					The resting area is situated on the right-hand side. Simply walk down the hallway, and you'll spot it a short distance away.
					<?[url=$end]Exit[/url]?>
					"""
				),
			"$end":
				Utils.dialog_part("You can now exit the facility.")
		},
		"training"
	)


