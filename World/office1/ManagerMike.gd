extends Sprite2D


@onready var hud := $"/root/Office1/HUD"
@onready var interactable := $"/root/Office1/QuestionmarkFolder/ManagerMike"

func _ready():
	interactable.exclamation_mark()
	pass
	
func interact() -> void:
	print("interaction started")
	hud.show_dialog(
		"TomHint",
		{
			"$begin":
			Utils.dialog_part(
				"""
				[b]Ken[/b]
				
				Welcome to our department!
				
				You should talking to my employees, some of them might need the help they can get.
				
				Goodluck!
				
				[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]Thanks, I would walk around![/url]?>[/right]

				"""
			),
		},
		"training"
	)
	
func _on_area_2d_area_entered(area):
	print("interactable!")
	if area.is_in_group("Player"):
		interact()
