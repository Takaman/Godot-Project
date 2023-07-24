extends Sprite2D


@onready var hud := $"/root/FoodCourt/HUD"
@onready var interactable := $"/root/FoodCourt/QuestionmarkFolder/TailgateHint"
@onready var progress = $"../Progress"

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
				[b]Bei[/b]
				
				That guy seems to be standing there aimlessly. I think we should check if there's a problem.
				
				[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]Yea, I'll check it out.[/url]?>[/right]
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
		

