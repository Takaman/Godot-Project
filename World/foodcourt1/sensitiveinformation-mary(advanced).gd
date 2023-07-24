extends Sprite2D


@onready var hud := $"/root/FoodCourt/HUD"
@onready var interactable := $"/root/FoodCourt/QuestionmarkFolder/Interactable-sensitiveinformation(advanced)"

func _ready():
	interactable.correct()
	interactable.visible = false
	pass
	
func interact() -> void:
	print("interaction started")
	hud.show_dialog(
		"sensitiveinformationadvanced",
		{
			"$begin":
			Utils.dialog_part(
				"""
				[b]Mary[/b]
				
				How can we proactively identify and detect any potential mishandling or unauthorized disposal of sensitive client documents?
				
				[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$change:correct]I will assign dedicated staff to perform routine checks of trash bins and recycling areas for any discarded sensitive documents.[/url]?>[/right]
				[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$nochange:wrong]I will implement a document tracking system to monitor the movement and disposal of sensitive client documents.[/url]?>[/right]
				[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$nochange1:wrong]I will conduct surprise audits to ensure employees are following proper document disposal practices.[/url]?>[/right]
				
				"""
			),
			"$change":
				Utils.dialog_part(
				"""
				That's the right decision.
				Regular checks ensure that discarded sensitive documents are promptly identified and properly handled to prevent unauthorized access or data breaches.
				
				[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]Exit[/url]?>[right]
				"""
				),
			"$nochange":
				Utils.dialog_part(
				"""
				That's incorrect.
				While implementing a document tracking system can be beneficial for monitoring the movement and disposal of sensitive client documents, it may not be as effective in proactively identifying and detecting potential mishandling or unauthorized disposal.
				
				[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]Exit[/url]?>[/right]
				"""
				),
			"$nochange1":
				Utils.dialog_part(
				"""
				That's incorrect.
				Conducting surprise audits can be helpful in ensuring employees are following proper document disposal practices. However, it may not be as proactive in identifying potential mishandling or unauthorized disposal.
				
				[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]Exit[/url]?>[right]
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
		if Score.get_result("sensitiveinformationadvanced","policy") == 1:
			interactable.correct()
			interactable.visible  = true
		if Score.get_result("sensitiveinformationadvanced","policy") == 2:
			interactable.visible  = true
			interactable.reset()
