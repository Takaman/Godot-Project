extends Sprite2D


@onready var hud := $"/root/Office1/HUD"
@onready var interactable := $"/root/Office1/QuestionmarkFolder/Interactable"
@onready var state = 0

signal lookaround

func interact() -> void:
	if state == 0:
		print("interaction started")
		hud.show_dialog(
			"unattendedlaptop",
			{
				"$begin":
				Utils.dialog_part(
					"""
					It looks like someone has left their PC unlocked and unattended...
					
					[center][img=180x120]res://World/office1/images/Question/Unattended.jpg[/img][/center]
					[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$leave:wrong]Leave it alone.[/url]?>[/right]
					[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$lookaround]Look around for its user.[/url]?>[/right]
					
					"""
				),
				"$leave":
					Utils.dialog_part(
					"""
					Hmm... I don't think that's a good idea. What if someone unauthorized came and used the PC? I'd better look for its owner...
					[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$lookaround]Look around for its user.[/url]?>[/right]
					"""
					),
				"$lookaround":
					Utils.dialog_part(
					"""
					I wonder where its user went? Maybe I should try checking the [b]vending machines[/b]. Also, I should help lock the PC.
					
					[i]Win + L on a Windows machine or Cmd + Ctrl + Q on an Apple machine to lock.[/i]
					[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]Lock the PC and check the vending machines.[/url]?>[/right]
					"""
					)
			},
			"policy"
		)
		emit_signal("lookaround")
		state = 1
		if interactable!= null and interactable is Node:
			interactable.in_progress()
	elif state == 1:
		hud.show_dialog(
			"unattendedlaptop",
			{
				"$begin":
					Utils.dialog_part(
						"""
						I should check the [b]vending machines[/b] for the PC's user.
						
						[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]Check the vending machines.[/url]?>[/right]
						"""
					)
			},
			"policy"
		)
	elif state == 2:
		hud.show_dialog(
			"unattendedlaptop",
			{
				"$begin":
					Utils.dialog_part(
						"""
						Its a locked PC.
						
						[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]Leave.[/url]?>[/right]
						"""
					)
			},
			"policy"
		)
	
func _on_area_2d_area_entered(area):
	print("interactable!")
	if area.is_in_group("Player"):
		interact()

func _physics_process(delta: float) -> void:
	if Score.get_has_correct("unattendedlaptop","policy") == true:
		state = 2
		if interactable != null and interactable is Node:
			interactable.toggle_visibility(false)
	
func _on_jerry_jerrydone():
	state = 2
