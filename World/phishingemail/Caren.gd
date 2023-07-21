extends Sprite2D

@onready var hud := $"/root/house_internal_phishingemail/HUD"
@onready var marker := get_node("marker")
@onready var state = -1
@onready var itguy := $"/root/house_internal_phishingemail/ITGuy"
@onready var itguyinprogress : bool = false

signal IT_Guy_Caren
signal caren_done

func _on_hud_partsignaller():
	if hud.part_name == "$carenoclick":
		if state == 0:
			state = 1
		if marker != null and marker is Node:
			marker.correct()
	elif hud.part_name == "$carenclick":
		if state == 0:
			state = 2
		if marker != null and marker is Node:
			marker.in_progress()
	elif hud.part_name == "$carenwrongdone":
		if marker != null and marker is Node:
			marker.wrong()
		state = 5
		emit_signal("caren_done")

func _physics_process(delta: float) -> void:
	if Score.get_result("phishingemail2","socialengineering") == 1:
		state = 1
		if marker != null and marker is Node:
			marker.correct()
	elif Score.get_result("phishingemail2","socialengineering") == 2:
		state = 5
		if marker != null and marker is Node:
			marker.wrong()
			
	#Disables interaction while another question is in progress
	if itguy.get_itguy_state() == "base" or itguy.get_itguy_state() == "caren" or itguy.get_itguy_state() == "caren2":
		itguyinprogress = false
		if marker != null and marker is Node:
			marker.toggle_visibility(true)
	else:
		itguyinprogress = true
		if marker != null and marker is Node:
			marker.toggle_visibility(false)

func _on_it_guy_caren_next():
	state = 4

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
							IT Department <it_departrnent@itpgrp11.com>
							
							Subject: [Urgent] Company Account Security Alert - Immediate Action Required
							
							Dear Caren,
							
							Our security systems have detected unusual login activity from your company email account. We believe that your account may have been compromised, and advise you to take immediate action to safeguard company and personal data.
							
							Please refer to the following instructions to ensure the security of your email account.
							
							[ol]
							Click the following link to access our company's email portal: bit.ly/email-account-reset-itpgrp11
							Enter your current email login credentials to verify your identity.
							Once successfully verified, you will be able to change your password. Please use a combination of uppercase and lowercase letters, numbers, and special characters to create a strong password.
							[/ol]
							
							Note that you must complete this process in the next [u]24 hours[/u], or your account will be locked out. Please understand the urgency of this matter, and we appreciate your prompt response.
							
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
							
							Is there something wrong? Let's see... the URL I'm currently on is http://www.itpgrp11resetemail.net. Oh. That doesn't look right. It definitely used to end in .com.
							
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
							
							That's a good idea. Can you help me ask the IT staff on this floor what to do? Tell them I got an email from someone pretending to be our IT department and gave them my email account credentials.
							
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]Ok.[/url]?>[/right]
							"""
						)
				},
				"socialengineering"
			)
			state = 3
			emit_signal("IT_Guy_Caren")
		elif state == 3:
			hud.show_dialog(
				"phishingemail2",
				{
					"$begin":
						Utils.dialog_part(
							"""
							[b]Caren[/b]
							
							Could you help me ask the IT staff what to do? Tell them I got an email from someone pretending to be our IT department and gave them my email account credentials.
							
							Here's the email if you need more details.
							
							IT Department <it_departrnent@itpgrp11.com>
							
							Subject: [Urgent] Company Account Security Alert - Immediate Action Required
							
							Dear Caren,
							
							Our security systems have detected unusual login activity from your company email account. We believe that your account may have been compromised, and advise you to take immediate action to safeguard company and personal data.
							
							Please refer to the following instructions to ensure the security of your email account.
							
							[ol]
							Click the following link to access our company's email portal: bit.ly/email-account-reset-itpgrp11
							Enter your current email login credentials to verify your identity.
							Once successfully verified, you will be able to change your password. Please use a combination of uppercase and lowercase letters, numbers, and special characters to create a strong password.
							[/ol]
							
							Note that you must complete this process in the next [u]24 hours[/u], or your account will be locked out. Please understand the urgency of this matter, and we appreciate your prompt response.
							
							If you require assistance, please do not hesitate to reply to this email.
							
							Sincerely,
							
							IT Department
							ITPGRP11
							
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]Ok.[/url]?>[/right]
							"""
						),
				},
				"socialengineering"
			)
		elif state == 4:
			hud.show_dialog(
				"phishingemail2",
				{
					"$begin":
						Utils.dialog_part(
							"""
							[b]Caren[/b]
							
							What did the IT department say I should do first?
							
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$back1]Run an antivirus scan.[/url]?>[/right]
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$back2]Send the email to your colleagues.[/url]?>[/right]
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$back1]Monitor your account for any strange activity.[/url]?>[/right]
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$back]Report to the IT department.[/url]?>[/right]
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$next]Change the password for your account.[/url]?>[/right]
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$back2]Delete your account.[/url]?>[/right]
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$back1]Enable two-factor authentication.[/url]?>[/right]
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]Let me try to remember.[/url]?>[/right]
							"""
						),
					"$back":
						Utils.dialog_part(
							"""
							[b]Caren[/b]
							
							Haven't I already done that?
							
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$begin]Let me try to remember.[/url]?>[/right]
							"""
						),
					"$back1":
						Utils.dialog_part(
							"""
							[b]Caren[/b]
							
							Is that really what I should do next?
							
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$begin]Let me try to remember.[/url]?>[/right]
							"""
						),
					"$back2":
						Utils.dialog_part(
							"""
							[b]Caren[/b]
							
							That sounds wrong...
							
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$begin]Let me try to remember.[/url]?>[/right]
							"""
						),
					"$next":
						Utils.dialog_part(
							"""
							[b]Caren[/b]
							
							And then?
							
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$back1]Run an antivirus scan.[/url]?>[/right]
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$back2]Send the email to your colleagues.[/url]?>[/right]
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$back1]Monitor your account for any strange activity.[/url]?>[/right]
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$back]Report to the IT department.[/url]?>[/right]
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$back2]Delete your account.[/url]?>[/right]
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$next2]Enable two-factor authentication.[/url]?>[/right]
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]Let me try to remember.[/url]?>[/right]
							"""
						),
					"$next2":
						Utils.dialog_part(
							"""
							[b]Caren[/b]
							
							What next?
							
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$next3]Run an antivirus scan.[/url]?>[/right]
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$back2]Send the email to your colleagues.[/url]?>[/right]
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$back1]Monitor your account for any strange activity.[/url]?>[/right]
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$back]Report to the IT department.[/url]?>[/right]
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$back2]Delete your account.[/url]?>[/right]
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]Let me try to remember.[/url]?>[/right]
							"""
						),
					"$next3":
						Utils.dialog_part(
							"""
							[b]Caren[/b]
							
							And the last step?
							
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$back2]Send the email to your colleagues.[/url]?>[/right]
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$carenwrongdone]Monitor your account for any strange activity.[/url]?>[/right]
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$back]Report to the IT department.[/url]?>[/right]
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$back2]Delete your account.[/url]?>[/right]
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]Let me try to remember.[/url]?>[/right]
							"""
						),
					"$carenwrongdone":
						Utils.dialog_part(
							"""
							[b]Caren[/b]
							
							Thanks for your help - I wouldn't know what to do without you. Maybe I should spend some time looking at those [b]posters at the back[/b].
							
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end:wrong]Posters? I should check them out.[/url]?>[/right]
							"""
						),
				},
				"socialengineering"
			)
		elif state == 5:
			hud.show_dialog(
				"phishingemail2",
				{
					"$begin":
						Utils.dialog_part(
							"""
							[b]Caren[/b]
							
							Those posters taught me a lot! I don't think I'll fall for another phishing email anytime soon.
							
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]I hope so too.[/url]?>[/right]
							"""
						)
				},
				"socialengineering"
			)

