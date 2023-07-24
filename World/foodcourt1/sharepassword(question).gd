extends Sprite2D


@onready var hud := $"/root/FoodCourt/HUD"
@onready var interactable := $"/root/FoodCourt/QuestionmarkFolder/Interactablewhiteboard"
func _ready():
	interactable.correct()
	interactable.visible = false
	pass
	
func interact() -> void:
	print("interaction started")
	hud.show_dialog(
		"sharepassword",
		{
			"$begin":
			Utils.dialog_part(
				"""
				There's a password written on the whiteboard for everyone to see.
				
				[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$change:correct]Let's erase the password from the whiteboard now and report this incident.[/url]?>[/right]
				[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$nochange:wrong]Leave it. It provides a convenient way for the team to remeber the password.[/url]?>[/right]
				
				"""
			),
			"$change":
				Utils.dialog_part(
				"""
				That's the correct decision.
				
				By removing the password from the whiteboard, you are taking a proactive step to enhance security and protect our data.
				
				Also, reporting this incident can help maintain the integrity of security of sensitive information.
				
				[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]Exit[/url]?>[/right]
				"""
				),
			"$nochange":
				Utils.dialog_part(
				"""
				That is a horrible choice.
				Leaving passwords visible compromises the security of our systems and sensitive information.
				
				It's important to prioritize data protection by removing the password from the whiteboard and implementing more secure methods for sharing passwords, such as company approved apps like cloud secrets.
				
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
		if Score.get_result("sharepassword","policy") == 1:
			interactable.correct()
			interactable.visible  = true
		if Score.get_result("sharepassword","policy") == 2:
			interactable.visible  = true
			interactable.reset()

