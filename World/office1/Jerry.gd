extends Sprite2D


@onready var hud := $"/root/FoodCourt/HUD"
@onready var interactable := $"/root/FoodCourt/QuestionmarkFolder/Interactable8"
@onready var state = 0

signal jerrydone

func _ready():
	interactable.visible = false
	pass

func _on_computerwhitebase_2_lookaround():
	state = 1


func _on_computerwhitebase_2_leave():
	state = 3
	
func interact() -> void:
	print("interaction started")
	if state == 0:
		hud.show_dialog(
			"unattendedlaptop",
			{
				"$begin":
					Utils.dialog_part(
					"""
					[b]Jerry[/b]
					
					I'm really thirsty.
					[i]I think I might have forgotten to do something before leaving my desk[/i]
					
					[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]I see.[/url]?>[/right]
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
						[b]Jerry[/b]
						
						I'm really thirsty.
						
						[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$next:correct]Hey, did you leave your PC unlocked?[/url]?>[/right]
						[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]I will leave you to do your thing.[/url]?>[/right]
						"""
					),
				"$next":
					Utils.dialog_part(
						"""
						[b]Jerry[/b]
						
						My PC? Yea, I just left it when I came to buy a drink.
						
						[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$next2]That's not a good idea. What if someone malicious came and used your PC?[/url]?>[/right]
						"""
					),
				"$next2":
					Utils.dialog_part(
						"""
						[b]Jerry[/b]
						
						Oh... I didn't consider that...
						
						[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$next3:correct]I've helped you to lock your PC this time. Remember to do so in the future, or you might get into trouble for breaching office policies.[/url]?>[/right]
						"""
					),
				"$next3":
					Utils.dialog_part(
						"""
						[b]Jerry[/b]
						
						Thanks for telling me - I'll be more careful in the future.
						
						[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]No problem.[/url]?>[/right]
						"""
					)
			},
			"policy"
		)
		state = 2
		emit_signal("jerrydone")
	elif state == 2:
		hud.show_dialog(
			"unattendedlaptop",
			{
				"$begin":
					Utils.dialog_part(
						"""
						[b]Jerry[/b]
						
						Thanks for telling me - I'll be more careful in the future.
						
						[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]No problem.[/url]?>[/right]
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
						[b]Jerry[/b]
						
						I'm really thirsty.
						
						[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$next]Hey, did you leave your PC unlocked?[/url]?>[/right]
						[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]I see.[/url]?>[/right]
						"""
					),
				"$next":
					Utils.dialog_part(
						"""
						[b]Jerry[/b]
						
						My PC? Yea, I just left it when I came to buy a drink.
						
						[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$next2]You should go check your PC. I think someone changed your wallpaper.[/url]?>[/right]
						"""
					),
				"$next2":
					Utils.dialog_part(
						"""
						[b]Jerry[/b]
						
						Changed my wallpaper? Why would anyone do that?
						
						[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$next3]It could have been a prank? But if someone was able to change your wallpaper, there's no telling what other malicious actions they could have taken...[/url]?>[/right]
						"""
					),
				"$next3":
					Utils.dialog_part(
						"""
						[b]Jerry[/b]
						
						Oh... I didn't consider that. Thanks for telling me. I'll go lock my PC now and check if they did anything else.
						
						[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]Keep that in mind.[/url]?>[/right]
						"""
					)
			},
			"policy"
		)
		state = 2
		emit_signal("jerrydone")
		
func _physics_process(delta: float) -> void:
	if Score.get_has_correct("unattendedlaptop","policy") == true:
		state = 2
	if interactable!= null and interactable is Node:
		if Score.get_result("unattendedlaptop","policy") == 1:
			interactable.correct()
			interactable.visible  = true
		if Score.get_result("unattendedlaptop","policy") == 2:
			interactable.wrong()
			interactable.visible  = true
		
