extends Sprite2D

@onready var hud := $"/root/house_internal_phishingemail/HUD"
@onready var marker := get_node("marker")
@onready var state = -1
@onready var itguy := $"/root/house_internal_phishingemail/ITGuy"
@onready var itguyinprogress : bool = false

signal IT_Guy_Caren

func _on_hud_partsignaller():
	if hud.part_name == "$carenoclick":
		if state == 0:
			state = 1
		if marker != null and marker is Node:
			marker.remove_mark()
	elif hud.part_name == "$carenclick":
		if state == 0:
			state = 2
		if marker != null and marker is Node:
			marker.in_progress()

func _physics_process(delta: float) -> void:
	if Score.get_result("phishingemail2","socialengineering") != 0:
		if marker != null and marker is Node:
				marker.visible = false
	if Score.get_result("phishingemail2","socialengineering") == 1:
		state = 1
	elif Score.get_result("phishingemail2","socialengineering") == 2:
		state = 5
	
	#Disables interaction while another question is in progress
	if itguy.get_itguy_state() != "base":
		itguyinprogress = true
		if marker != null and marker is Node:
			marker.toggle_visibility(false)
	else:
		itguyinprogress = false
		if marker != null and marker is Node:
			marker.toggle_visibility(true)

func interact() -> void:
	print("interaction started")
	if itguyinprogress == true:
		hud.show_dialog(
			"phishingemail2",
			{
				"$begin":
					Utils.dialog_part(
						"""
						[b]Caren[/b]
						
						Are you helping someone right now? You should hurry up before something happens.
						
						[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]Ok.[/url]?>[/right]
						"""
					)
			},
			"socialengineering"
		)
	else:
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
							
							You're right, I'd better do it quickly. Hm? This website looks kinda different from before.
							
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
		elif state == 1:
			hud.show_dialog(
				"phishingemail2",
				{
					"$begin":
						Utils.dialog_part(
							"""
							[b]Caren[/b]
							
							Oh, hi again! Guess what? The IT department said that they didn't send this email, and it's probably a phishing email. Luckily you spotted it so nothing happened!
							
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]Happy to help.[/url]?>[/right]
							"""
						),
				},
				"socialengineering"
			)
		elif state == 2:
			hud.show_dialog(
				"phishingemail2",
				{
					"$begin":
						Utils.dialog_part(
							"""
							[b]Caren[/b]
							
							Let's see... my username and password... new password... done.
							
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$carennext]Wait! Can you check the URL of the website?[/url]?>[/right]
							"""
						),
					"$carennext":
						Utils.dialog_part(
							"""
							[b]Caren[/b]
							
							Is there something wrong? Let's see... the URL I'm currently on is [u]placeholder url[/u]. Oh. That doesn't look right.
							
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$carennext2]That might have been a phishing link...[/url]?>[/right]
							"""
						),
					"$carennext2":
						Utils.dialog_part(
							"""
							[b]Caren[/b]
							
							I already submitted my credentials... what should I do now? I'm gonna get into trouble...
							
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$carennext3]You should check with the IT department.[/url]?>[/right]
							"""
						),
					"$carennext3":
						Utils.dialog_part(
							"""
							[b]Caren[/b]
							
							That's a good idea. Can you help me ask the IT staff on this floor what to do?
							
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]Ok.[/url]?>[/right]
							"""
						)
				},
				"socialengineering"
			)
		state = 3
		emit_signal("IT_Guy_Caren")
		if marker != null and marker is Node:
			marker.in_progress()
