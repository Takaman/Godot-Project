extends Sprite2D


@onready var hud := $"/root/FoodCourt/HUD"
@onready var interactable := $"/root/FoodCourt/QuestionmarkFolder/DustbinHint"
@onready var actionable = $Actionable

func _ready():
	interactable.exclamation_mark()
	pass
	
func interact() -> void:
	print("interaction started")
	hud.show_dialog(
		"DustbinHint",
		{
			"$begin":
			Utils.dialog_part(
				"""
				[b]Peter[/b]
				
				I feel like we should do something more than just throwing confidential stuff into the dustbin.
				
				Maybe the lady beside might be thinking something similar.

				[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]Yea, I should check both of them out.[/url]?>[/right]

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
		if Score.get_result("sensitiveinformationadvanced","policy") > 0:
			actionable.monitorable = false
			interactable.visible  = false
