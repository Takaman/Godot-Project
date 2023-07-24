extends Sprite2D


@onready var hud := $"/root/Office1/HUD"
@onready var interactable := $"/root/Office1/QuestionmarkFolder/ThumbdriveHint"
@onready var actionable = $Actionable

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
				[b]Tom[/b]
				
				Someone should check out that thumbdrive.
				
				[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]I'll take a look.[/url]?>[/right]
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
		if Score.get_result("thumbdrive1","socialengineering") > 0:
			actionable.monitorable = false
			interactable.visible  = false
