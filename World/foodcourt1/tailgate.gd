extends Sprite2D


@onready var hud := $"/root/FoodCourt/HUD"
@onready var interactable := $"/root/FoodCourt/QuestionmarkFolder/Interactabletailgateperson"

func _ready():
	hud._close_panel()
	hud.close_player_input()
	interactable.correct()
	interactable.visible  = false
	pass
	
func interact() -> void:
	print("interaction started")
	hud.show_dialog(
		"tailgate",
		{
			"$begin":
			Utils.dialog_part(
				"""
				[b]Alloy[/b]
				
				Excuse me, I forgot my access card for the gantry. Could you please let me in? I need to enter to do my work.

				[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$wrong:wrong][u]Ignore him and walk away.[/u][/url]?>[/right]
				[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$correct:correct]I'm sorry, but I cannot help you out.[/url]?>[/right]
				[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$wronge2:wrong]No worries. I'll swipe my card, and you can follow me.[/url]?>[/right]
				
				"""
			),
			"$correct":
				Utils.dialog_part(
				"""
				Correct!
				
				By following this approach, you prioritise security protocols and encourage the person to take the appropriate steps to gain legitimate access.
				
				[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]Exit[/url]?>[/right]
				
				"""
				),
			"$wrong":
				Utils.dialog_part(
				"""
				That's rude.
				
				While it's important to be cautious, ignoring someone in need can come across as rude or unhelpful.
				
				You need to also have some sort of respect towards anyone you meet.
				
				[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]Exit[/url]?>[/right]
				"""
				),
			"$wrong2":
				Utils.dialog_part(
				"""
				That's risky.
				
				Allowing someone in without verifying their identity can potentially compromise the security of an area.
				
				[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]Exit[/url]?>[/right]
				"""
				),
		},
		"socialengineering"
	)

func _on_area_2d_area_entered(area):
	print("interactable!")
	if area.is_in_group("Player"):
		interact()

func _physics_process(delta: float) -> void:
	if interactable!= null and interactable is Node:
		if Score.get_result("tailgate","socialengineering") == 1:
			interactable.correct()
			interactable.visible  = true
		if Score.get_result("tailgate","socialengineering") == 2:
			interactable.visible  = true
			interactable.reset()

