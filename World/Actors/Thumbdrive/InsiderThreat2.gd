extends Sprite2D


@onready var hud := $"/root/Office1/HUD"
@onready var interactable := $"/root/Office1/QuestionmarkFolder/InsiderThreatHint"
@onready var actionable = $Actionable

func _ready():
	interactable.exclamation_mark()
	pass
	
func interact() -> void:
	print("interaction started")
	hud.show_dialog(
		"MessyTableHint",
		{
			"$begin":
			Utils.dialog_part(
				"""
				[i]Sounds like they are having a conversation[/i]
				
				[b]Ryan[/b]: Hey Emma, have you seen Tom's desk lately? It's an absolute disaster!

				[b]Emma[/b]: Oh, you mean that mountain of papers and random objects? It's like a tornado swept through his workspace!

				[b]Ryan[/b]: Exactly! I don't know how he finds anything in that chaos. It's a miracle if he can locate a single pen.
				
				[b]Emma[/b]: I can't bear to see if there's confidential documents everywhere.

				[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end][i]I think I should check it out.[/i][/url]?>[/right]
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
		if Score.get_result("messyarea1","policy") > 0:
			actionable.monitorable = false
			interactable.visible  = false

