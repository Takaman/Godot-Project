extends Sprite2D


@onready var hud := $"/root/FoodCourt/HUD"
@onready var interactable := $"/root/FoodCourt/QuestionmarkFolder/SharePasswordHint"
@onready var actionable = $Actionable

func _ready():
	interactable.exclamation_mark()
	pass
	
func interact() -> void:
	print("interaction started")
	hud.show_dialog(
		"JerryHint",
		{
			"$begin":
			Utils.dialog_part(
				"""
				Don't you think that there is a better way than storing our password on this whiteboard?

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
		if Score.get_result("sharepassword","policy") > 0:
			actionable.monitorable = false
			interactable.visible  = false
