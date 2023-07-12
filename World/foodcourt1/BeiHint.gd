extends Sprite2D


@onready var hud := $"/root/FoodCourt/HUD"
@onready var interactable := $"/root/FoodCourt/QuestionmarkFolder/TailgateHint"

func _ready():
	interactable.exclamation_mark()
	pass
	
func interact() -> void:
	print("interaction started")
	hud.show_dialog(
		"Bei",
		{
			"$begin":
			Utils.dialog_part(
				"""
				Don't you think that guy with a white shirt and red hair looks a little suspicious?
				Maybe we should report it to the counter too.
				[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]Yea, I should check it out.[/url]?>[/right]

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
		interactable.visible  = !Score.get_has_correct("tailgate","socialengineering")

