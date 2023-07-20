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
				
				Hi!
				This is customer service, what can i help you with?
				
				[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$change:correct]I want to report that there is someone suspicious infront of the gantry  [/url]?>[/right]
				
				[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$nochange:wrong]Its nothing much. [/url]?>[/right]
				"""
			),
			"$change":
				Utils.dialog_part(
				"""
				That's the right decision.
				It's never too much to be extra safe, helping to report such scenarios might prevent any unnessary risks.
				
				[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]EXIT[/url]?>[/right]
				"""
				),
			"$nochange":
				Utils.dialog_part(
				"""
				That's risky.
				You should be more wary of your surroundings.
				
				Help play your part and report any suspicious activity can come a long way into improving our security.
				
				[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]EXIT[/url]?>[/right]
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
