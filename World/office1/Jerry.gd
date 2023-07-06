extends Sprite2D


@onready var hud := $"/root/Office1/HUD"
@onready var interactable := $"/root/Office1/QuestionmarkFolder/Interactable8"
@onready var state = 0

signal jerrydone

func _ready():
	if interactable != null and interactable is Node:
		interactable.toggle_visibility(false)
	pass

func _on_laptop_9__question_lookaround():
	state = 1
	if interactable != null and interactable is Node:
		interactable.toggle_visibility(true)

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
					
					<?[url=$end][right]I see.[/right][/url]
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
						
						<?[url=$next][right]Hey, did you leave your PC unlocked?[/right][/url]
						<?[url=$end][right]I see.[/right][/url]
						"""
					),
				"$next":
					Utils.dialog_part(
						"""
						[b]Jerry[/b]
						
						My PC? Yea, I just left it when I came to buy a drink.
						
						<?[url=$next2][right]That's not a good practice. What if someone malicious came and used your PC?[/right][/url]
						"""
					),
				"$next2":
					Utils.dialog_part(
						"""
						[b]Jerry[/b]
						
						Oh... I didn't consider that...
						
						<?[url=$next3:correct][right]I've helped you lock your PC this time. Remember to do so in the future, or you might get into trouble for breaching office policies.[/right][/url]
						"""
					),
				"$next3":
					Utils.dialog_part(
						"""
						[b]Jerry[/b]
						
						Thanks for telling me - I'll be more careful in the future.
						
						<?[url=$end][right]No problem.[/right][/url]
						"""
					)
			},
			"policy"
		)
		state = 2
		emit_signal("jerrydone")
		if interactable != null and interactable is Node:
			interactable.toggle_visibility(false)
	elif state == 2:
		hud.show_dialog(
			"unattendedlaptop",
			{
				"$begin":
					Utils.dialog_part(
						"""
						[b]Jerry[/b]
						
						Thanks for telling me - I'll be more careful in the future.
						
						<?[url=$end][right]No problem.[/right][/url]
						"""
					)
			},
			"policy"
		)
		
func _physics_process(delta: float) -> void:
	if Score.get_has_correct("unattendedlaptop","policy") == true:
		state = 2
		if interactable != null and interactable is Node:
			interactable.toggle_visibility(false)
