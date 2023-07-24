extends Sprite2D


@onready var hud := $"/root/FoodCourt/HUD"
@onready var interactable := $"/root/FoodCourt/QuestionmarkFolder/ReportSusAct"

func _ready():
	interactable.correct()
	interactable.visible = false
	pass

func interact() -> void:
	print("interaction started")
	hud.show_dialog(
		"ReportSusAct",
		{
			"$begin":
			Utils.dialog_part(
				"""
				[b]Alice[/b]
				
				Hello, this is customer service. How can I help?
				
				[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$change:correct]I want to report a suspicious person in front of the gantries. [/url]?>[/right]
				
				[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$nochange:wrong]Thanks, but I don't need any help right now.[/url]?>[/right]
				"""
			),
			"$change":
				Utils.dialog_part(
				"""
				That's the right decision.
				It's never too much to be extra safe, and helping to report such scenarios might prevent any unnessary risks.
				
				[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]Exit[/url]?>[/right]
				"""
				),
			"$nochange":
				Utils.dialog_part(
				"""
				That's risky.
				You should be more wary of your surroundings.
				
				Helping to play your part and reporting any suspicious activity can go a long way to improving our security.
				
				[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]Exit[/url]?>[/right]
				"""
				),
		},
		"policy"
	)
	
func _on_area_2d_area_entered(area):
	print("interactable!")
	if area.is_in_group("Player"):
		interact()
		
func _physics_process(delta: float) -> void:
	if interactable!= null and interactable is Node:
		if Score.get_result("ReportSusAct","policy") == 1:
			interactable.correct()
			interactable.visible  = true
		if Score.get_result("ReportSusAct","policy") == 2:
			interactable.visible  = true
			interactable.reset()
