extends Sprite2D


@onready var hud := $"/root/FoodCourt/HUD"
@onready var interactable := $"/root/FoodCourt/QuestionmarkFolder/TomHint"

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
				You should use the machine on my right to get your drink.

				[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]Thanks, I should check it out.[/url]?>[/right]

				"""
			),
		},
		"training"
	)
	
func _on_area_2d_area_entered(area):
	print("interactable!")
	if area.is_in_group("Player"):
		interact()

func _physics_process(delta: float) -> void:
	if interactable!= null and interactable is Node:
		interactable.visible  = !Score.get_has_correct("vendingmachine1","socialengineering")
