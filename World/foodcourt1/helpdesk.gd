extends Sprite2D

@onready var hud := $"/root/FoodCourt/HUD"
@onready var interactable := $"/root/FoodCourt/QuestionmarkFolder/helpdeskgirl"

func _ready():
	interactable.exclamation_mark()
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
					[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$exit:signaller1]Excuse me, I need to find the conference room. Which way should I go? [/url]?>[/right]
					[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$noexit:signaller2]Excuse me, I need to find the snack area. Which way should I go?[/url]?>[/right]
					
					"""
				),
			"$exit":
				Utils.dialog_part(
					"""
					The conference room is located behind you. Turn around, and you'll find the conference room
					[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$last]Exit[/url]?>[/right]
					"""
				),
			"$noexit":
				Utils.dialog_part(
					"""
					The snack area is situated on the right-hand side. Simply walk down the hallway, and you'll spot it a short distance away.
					[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$last]Exit[/url]?>[/right]
					"""
				),
			"$last":
				Utils.dialog_part(
					"""
					By any chance you were to go to the snack room, you would be able to meet my colleague there!
					[i]Notice that theres a laptop without anyone mannning it.[/i]
					[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]Oh thank you![/url]?>[/right]
					"""
					)
		},
		"training"
	)

func _on_area_2d_area_entered(area):
	print("interactable!")
	if area.is_in_group("Player"):
		interact()

func _physics_process(delta: float) -> void:
	if interactable!= null and interactable is Node:
		interactable.visible  = !Score.get_has_correct("helpdesk","socialengineering")

