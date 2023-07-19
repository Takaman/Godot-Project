extends Sprite2D


@onready var hud := $"/root/FoodCourt/HUD"
@onready var interactable := $"/root/FoodCourt/QuestionmarkFolder/TailgateHint"
@onready var progress = $"../Progress"
@onready var actionable = $Actionable

func _ready():
	interactable.exclamation_mark()
	pass
	
func interact() -> void:
	print("interaction started")
	hud.show_dialog(
		"Tim",
		{
			"$begin":
			Utils.dialog_part(
				"""
				Don't you think that we should do something about that thumbdrive?
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
		if Score.get_result("tailgate","socialengineering") > 0:
			actionable.monitorable = false
			interactable.visible  = false
