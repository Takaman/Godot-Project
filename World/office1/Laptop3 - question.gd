extends Sprite2D

@onready var hud := $"/root/Office1/HUD"
@onready var interactable := $"/root/Office1/QuestionmarkFolder/Interactable3"
@onready var state = 0
@onready var password : String = ""

func _ready():
	interactable.visible = false
	pass

func interact() -> void:
	print("interaction started")
	if state == 0:
		hud.show_dialog(
			"passwordpolicy",
			{
				"$begin":
				Utils.dialog_part(
					"""
					[b]Joe[/b]
					
					What? Our company is implementing a new password policy? Well, I think my current password [i]hunter2[/i] is really strong.
					
					[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$changepass]I think you need a new password.[/url]?>[/right]
					
					[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$nochangepass:wrong]That password is pretty strong.[/url]?>[/right]
					
					"""
				),
				"$changepass":
					Utils.dialog_part(
					"""
					[b]Joe[/b]
					
					Really? But I've been using [i]hunter2[/i] for all my accounts... in that case, could you help me come up with a new password?
					
					[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]Of course.[/url]?>[/right]
					"""
					),
				"$nochangepass":
					Utils.dialog_part(
					"""
					[b]Joe[/b]
					
					Of course it is! I've been using it for every account I've created!
					
					[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]Maybe I should reconsider what I said...[/url]?>[/right]
					"""
					),
			},
			"policy"
		)
	elif state == 1:
		hud.show_dialog(
			"passwordpolicy",
			{
				"$begin":
				Utils.dialog_part(
					"""
					[b]Joe[/b]
					Help me think of a new password! Type it in the text box in the next screen.
					
					[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]Alright.[/url]?>[/right]
					"""
				)
			},
			"policy"
		)
		hud.show_player_input()
	elif state == 2:
		hud.show_dialog(
			"passwordpolicy",
			{
				"$begin":
				Utils.dialog_part(
					"""
					[b]Joe[/b]
					Thanks for your help! I should probably change the passwords of my other accounts now...
					
					[i]Disclaimer: Please do not reveal your password to anyone.[/i]
					
					[center]<#[url=https://learn.microsoft.com/en-us/microsoft-365/admin/misc/password-policy-recommendations?view=o365-worldwide]Click here to learn more.[/url]#>[/center]
				
					[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]No problem, I'm glad to be of help.[/url]?>[/right]
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
	if hud.part_name == "$changepass":
		state = 1
		interactable.visible = true
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
			"passwordpolicy",
			{
				"$begin":
				Utils.dialog_part(
					"""
					[b]Joe[/b]
					Hmm... I think that password might not be a good choice. Let's see... our password policy says that we need at least [b]one uppercase letter[/b], [b]one lowercase letter[/b], [b]one number[/b], [b]one special character[/b], and it needs to be at least [b]eight characters long[/b].
					
					[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end:wrong]Alright, I'll try again.[/url]?>[/right]
					"""
				)
			},
			"policy"
		)
	else:
		hud.show_dialog(
			"passwordpolicy",
			{
				"$begin":
				Utils.dialog_part(
					"""
					[b]Joe[/b]
					Wow! This looks like a really strong password. Thanks!
					
					[i]Disclaimer: Please do not reveal your password to anyone.[/i]
					
					[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end:correct]No problem, I'm glad to be of help.[/url]?>[/right]
					"""
				)
			},
			"policy"
		)

func _physics_process(delta: float) -> void:
	if interactable != null and interactable is Node:
		if Score.get_result("passwordpolicy","policy") == 2:
			interactable.visible = true
			interactable.reset()
			if state == 1:
				interactable.in_progress()
		if Score.get_has_correct("passwordpolicy","policy") == true:
			interactable.visible = true
			state = 2
			interactable.correct()
