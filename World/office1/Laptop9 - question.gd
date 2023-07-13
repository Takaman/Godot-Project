extends Sprite2D


@onready var hud := $"/root/FoodCourt/HUD"
@onready var interactable := $"/root/FoodCourt/QuestionmarkFolder/Interactable"
@onready var state = 0

signal lookaround
signal leave

func _ready():
	interactable.visible = false
	pass
	
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
					I shouldn't touch someone else's things.
					[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]Leave.[/url]?>[/right]
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
	elif state == 3:
		hud.show_dialog(
			"unattendedlaptop",
			{
				"$begin":
					Utils.dialog_part(
						"""
						[b]10 minutes later...[/b]
						
						Hey, it's the PC I decided to leave. I wonder if the owner came back to lock it?
						
						[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$checkpc]Take a closer look.[/url]?>[/right]
						"""
					),
				"$checkpc":
					Utils.dialog_part(
						"""
						Oh no... someone changed the desktop wallpaper to a strange picture. Was this someone's idea of a prank? I should find the PC's user and inform them.
						
						Let's check around the [b]vending machines[/b] for them.
						
						[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]Check the vending machines.[/url]?>[/right]
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
			interactable.correct()
	
func _on_jerry_jerrydone():
	state = 2

func _on_hud_partsignaller():
	if hud.part_name == "$lookaround":
		emit_signal("lookaround")
		state = 1
		interactable.visible = true
		if interactable!= null and interactable is Node:
			interactable.in_progress()
	elif hud.part_name == "$leave":
		state = 3
		if interactable!= null and interactable is Node:
			interactable.in_progress()
	elif hud.part_name == "$checkpc":
		emit_signal("leave")
		state = 1
