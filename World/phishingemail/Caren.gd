extends Sprite2D

@onready var hud := $"/root/house_internal_phishingemail/HUD"
@onready var marker := get_node("marker")
@onready var state = -1

func _on_hud_partsignaller():
	pass # Replace with function body.

func _physics_process(delta: float) -> void:
	if Score.get_result("phishingemail2","socialengineering") != 0:
		if marker != null and marker is Node:
				marker.visible = false
	if Score.get_result("phishingemail2","socialengineering") == 1:
		state == 1
	elif Score.get_result("phishingemail2","socialengineering") == 2:
		state == 5

func interact() -> void:
	print("interaction started")
	if state == -1 or state == 0:
		state = 0
		hud.show_dialog(
			"phishingemail2",
			{
				"$begin":
					Utils.dialog_part(
						"""
						[b]Caren[/b]
						
						Hi there! I just received this email, but I'm not sure if I should respond... could you help me out?
						
						[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$carennext]Sure, I can take a look.[/url]?>[/right]
						[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]Not right now.[/url]?>[/right]
						"""
					),
				"$carennext":
					Utils.dialog_part(
						"""
						IT Department <it_departrnent@itgrp11.com>
						
						Subject: [Urgent] Company Account Security Alert - Immediate Action Required
						
						Dear Caren,
						
						Our security systems have detected unusual login activity from your company email account. We believe that your account may have been compromised, and advise you to take immediate action to safeguard company and personal data.
						
						Please refer to the following instructions to ensure the security of your email account.
						
						[ol]
						[li]Click the following link to access our company's email portal: [url]placeholder[/url][/li]
						[li]Enter your current email login credentials to verify your identity.[/li]
						[li]Once successfully verified, you will be able to change your password. Please use a combination of uppercase and lowercase letters, numbers, and special characters to create a strong password.[/li]
						[/ol]
						
						Note that you must complete this process in the next 24 hours, or your account will be locked out. Please understand the urgency of this matter, and we appreciate your prompt response.
						
						If you require assistance, please do not hesitate to reply to this email.
						
						Sincerely,
						
						IT Department
						ITPGRP11
						
						[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$carenclick]There's not much time left! You'd better change your password now.[/url]?>[/right]
						[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$carennoclick:correct]Have you checked with the IT department?[/url]?>[/right]
						[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]Give me some time to think about it.[/url]?>[/right]
						"""
					),
				"$carenclick":
					Utils.dialog_part(
						"""
						[b]Caren[/b]
						
						You're right, I'd better do it quickly. Let's see... that's strange, the website looks a little different from usual, but I guess it's been a while.
						
						[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]...?[/url]?>[/right]
						"""
					),
				"$carennoclick":
					Utils.dialog_part(
						"""
						[b]Caren[/b]
						
						Really? I wouldn't want to waste their time... but I guess its a good idea.
						
						[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]No problem, better safe than sorry.[/url]?>[/right]
						"""
					)
			},
			"socialengineering"
		)

