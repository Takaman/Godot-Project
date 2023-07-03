extends Sprite2D

@onready var hud := $"/root/Office1/HUD"
@onready var interactable := $"/root/Office1/QuestionmarkFolder/Interactable3"
@onready var state = 0
@onready var password : String = ""
func interact() -> void:
	print("interaction started")
	if state == 0:
		hud.show_dialog(
			"laptop3",
			{
				"$begin":
				Utils.dialog_part(
					"""
					[b]Joe[/b]
					What? Our company is implementing a new password policy? Well, I think my current password [i]hunter2[/i] is really strong.
					
					<?[url=$change][right]I think you need a new password.[/right][/url]?>
					<?[url=$nochange][right]That password is pretty strong.[/right][/url]?>
					<?[url=$end][right]I see.[/right][/url]?>
					"""
				),
				"$change":
					Utils.dialog_part(
					"""
					[b]Joe[/b]
					Really? But I've been using [i]hunter2[/i] for all my accounts... in that case, could you help me come up with a new password?
					
					<?[url=$end][right]Of course.[/right][/url]?>
					"""
					),
				"$nochange":
					Utils.dialog_part(
					"""
					[b]Joe[/b]
					Of course it is! I've been using it for every account I've created!
					
					<?[url=$end][right]Hmm... Maybe I should reconsider what I said...[/right][/url]?>
					"""
					),
			},
			"policy"
		)
	elif state == 1:
		hud.show_dialog(
			"laptop3",
			{
				"$begin":
				Utils.dialog_part(
					"""
					[b]Joe[/b]
					Help me think of a new password! Type it in the text box in the next screen.
					
					<?[url=$end][right]Alright.[/right][/url]?>
					"""
				)
			},
			"policy"
		)
		hud.show_player_input()
	elif state == 2:
		hud.show_dialog(
			"laptop3",
			{
				"$begin":
				Utils.dialog_part(
					"""
					[b]Joe[/b]
					Thanks for your help! I should probably change the passwords of my other accounts now...
					
					[i]Disclaimer: Please do not reveal your password to anyone.[/i]
					
					<?[url=$end][right]No problem, I'm glad to be of help.[/right][/url]?>
					"""
				)
			},
			"policy"
		)
		
func _on_area_2d_area_entered(area):
	print("interactable!")
	if area.is_in_group("Player"):
		interact()

func _on_hud_partsignaller():
	if hud.part_name == "$change":
		state = 1
		if interactable != null and interactable is Node:
			interactable.in_progress()

func _on_hud_input_submitted():
	password = hud.player_input_text
	#print(password)
	hud.close_player_input()

func _on_hud_input_closed():
	var regex = RegEx.new()
	var check : bool = false
	regex.compile("(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-])")
	print(password)
	if regex.search(password):
		print("REGEX PASS")
		check = true
	if check == false or password.length() < 8:
		hud.show_dialog(
			"laptop3",
			{
				"$begin":
				Utils.dialog_part(
					"""
					[b]Joe[/b]
					Hmm... I think that password might not be a good choice. Let's see... our password policy says that we need at least [b]one uppercase letter[/b], [b]one lowercase letter[/b], [b]one number[/b], [b]one special character[/b], and it needs to be at least [b]eight characters long[/b].
					
					<?[url=$end:wrong][right]Alright, I'll try again.[/right][/url]?>
					"""
				)
			},
			"policy"
		)
	else:
		hud.show_dialog(
			"laptop3",
			{
				"$begin":
				Utils.dialog_part(
					"""
					[b]Joe[/b]
					Wow! This looks like a really strong password. Thanks!
					
					[i]Disclaimer: Please do not reveal your password to anyone.[/i]
					
					<?[url=$end:correct][right]No problem, I'm glad to be of help.[/right][/url]?>
					"""
				)
			},
			"policy"
		)
		state = 2
		if interactable is Node:
			interactable.remove_mark()
			interactable = null

func _physics_process(delta: float) -> void:
	if interactable != null and interactable is Node:
		interactable.visible  = !Score.is_correct("laptop3","policy")
