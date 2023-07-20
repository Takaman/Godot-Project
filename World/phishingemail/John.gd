extends Sprite2D

@onready var hud := $"/root/house_internal_phishingemail/HUD"
@onready var marker := get_node("marker")
@onready var state = -1
@onready var itguy := $"/root/house_internal_phishingemail/ITGuy"
@onready var itguyinprogress : bool = false

signal IT_Guy
signal john_done

func _on_hud_partsignaller():
	if hud.part_name == "$johnnoclick":
		if state == 0:
			state = 1
		if marker != null and marker is Node:
			marker.remove_mark()
	elif hud.part_name == "$johnclick":
		if state == 0:
			state = 2
		if marker != null and marker is Node:
			marker.in_progress()
	elif hud.part_name == "$johnwrongdone":
		if marker != null and marker is Node:
			marker.remove_mark()
		state = 5
		emit_signal("john_done")

func _physics_process(delta: float) -> void:
	if Score.get_result("phishingemail1","socialengineering") != 0:
		if marker != null and marker is Node:
				marker.visible = false
	if Score.get_result("phishingemail1","socialengineering") == 1: #if result is correct
		state = 1
	elif Score.get_result("phishingemail1","socialengineering") == 2: #if result is wrong
		state = 5
	
	#Disables interaction while another question is in progress
	if itguy.get_itguy_state() == "base" or itguy.get_itguy_state() == "john" or itguy.get_itguy_state() == "john2":
		itguyinprogress = false
		if marker != null and marker is Node:
			marker.toggle_visibility(true)
	else:
		itguyinprogress = true
		if marker != null and marker is Node:
			marker.toggle_visibility(false)

func _on_it_guy_john_next():
	state = 4

func interact() -> void:
	print("interaction started")
	if itguyinprogress == true:
		hud.show_dialog(
			"phishingemail1",
			{
				"$begin":
					Utils.dialog_part(
						"""
						[b]John[/b]
						
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
				"phishingemail1",
				{
					"$begin":
					Utils.dialog_part(
						"""
						[b]John[/b]
						
						Hey... I just received this email and it looks quite important. Do you think I should follow the link and change my password?
						
						[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$johnnext]Sure, I can take a look.[/url]?>[/right]
						[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]Not right now.[/url]?>[/right]
						"""
						),
					"$johnnext":
					Utils.dialog_part(
						"""
						IT Department <itdepartment_itpgrp11@gmail.com>
						
						Subject: [IMPORTANT NOTICE] Your password is expiring! - Immediate Action Required
						
						Dear John,
						
						This email is meant to inform you that the password to your corporate email is expiring in: [b]1 day[/b]
						
						Please click the link below to reset your password. A PDF document has been attached with instructions if you are unfamiliar with the password reset process.
						
						[url=]placeholder[/url]
						
						Note that failure to reset your password may result in your account being locked out.
						
						Sincerely,
						
						IT Department
						ITPGRP11
						
						[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$johnclick]There's not much time left! You'd better change your password now.[/url]?>[/right]
						[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$johnnoclick:correct]Have you checked with the IT department?[/url]?>[/right]
						[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]Give me some time to think about it.[/url]?>[/right]
						"""
						),
					"$johnnoclick":
						Utils.dialog_part(
						"""
						[b]John[/b]
						
						Hmm... that seems like a good idea! I'll drop them an email to check.
						
						[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]No problem, better safe than sorry.[/url]?>[/right]
						"""
						),
					"$johnclick":
						Utils.dialog_part(
						"""
						[b]John[/b]
						
						You're right, I'd better do it quickly. Let's see... that's strange, the website looks a little different from usual, but I guess it's been a while.
						
						[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]... ?[/url]?>[/right]
						"""
						),
				},
				"socialengineering"
			)
		elif state == 1:
			hud.show_dialog(
				"phishingemail1",
				{
					"$begin":
						Utils.dialog_part(
							"""
							[b]John[/b]
							
							Hey, its you again! Thanks for your help! I managed to avoid falling for a phishing email thanks to you.
							
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]No problem, I was glad to be of help.[/url]?>[/right]
							"""
						)
				},
				"socialengineering"
			)
		elif state == 2:
			hud.show_dialog(
				"phishingemail1",
				{
					"$begin":
						Utils.dialog_part(
							"""
							[b]John[/b]
							
							I should download the PDF file to check if I did it correctly as well. Huh? My antivirus says its not safe... what's going on?
							
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$wrong3]... ![/url]?>[/right]
							"""
						),
					"$wrong3":
						Utils.dialog_part(
							"""
							[b]John[/b]
							
							Oh well, I'll just submit my password.
							
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$wrong4]Hold on! That might have been a phishing email![/url]?>[/right]
							"""
						),
					"$wrong4":
						Utils.dialog_part(
							"""
							[b]John[/b]
							
							What!? But I already gave them my password... Oh no... Could you help me inform the IT department? Tell them that I received an email from someone impersonating our IT department, and I gave them my corporate email account credentials.
							
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]OK.[/url]?>[/right]
							"""
						)
				},
				"socialengineering"
			)
			state = 3
			emit_signal("IT_Guy")
		elif state == 3:
			hud.show_dialog(
				"phishingemail1",
				{
					"$begin":
						Utils.dialog_part(
							"""
							[b]John[/b]
							
							Have you informed the IT department? Tell them that I received an email from someone impersonating our IT department, and I gave them my corporate email account credentials. Please help me do so... I hope nothing bad happens...
							
							Here's the email in case you need to refer to it.
							
							IT Department <itdepartment_itpgrp11@gmail.com>
						
							Subject: [IMPORTANT NOTICE] Your password is expiring! - Immediate Action Required
							
							Dear John,
							
							This email is meant to inform you that the password to your corporate email is expiring in: [b]1 day[/b]
							
							Please click the link below to reset your password. A PDF document has been attached with instructions if you are unfamiliar with the password reset process.
							
							[url=]placeholder[/url]
							
							Note that failure to reset your password may result in your account being locked out.
							
							Sincerely,
							
							IT Department
							ITPGRP11
							
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]OK.[/url]?>[/right]
							"""
						)
				},
				"socialengineering"
			)
		elif state == 4:
			hud.show_dialog(
				"phishingemail1",
				{
					"$begin":
						Utils.dialog_part(
							"""
							[b]John[/b]
							
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
							[b]John[/b]
							
							Didn't I already do so?
							
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$begin]Let me try to remember.[/url]?>[/right]
							"""
						),
					"$back1":
						Utils.dialog_part(
							"""
							[b]John[/b]
							
							Is that really what I should do next?
							
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$begin]Let me try to remember.[/url]?>[/right]
							"""
						),
					"$back2":
						Utils.dialog_part(
							"""
							[b]John[/b]
							
							That really doesn't sound right...
							
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$begin]Let me try to remember.[/url]?>[/right]
							"""
						),
					"$next":
						Utils.dialog_part(
							"""
							[b]John[/b]
							
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
							[b]John[/b]
							
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
							[b]John[/b]
							
							And the last step?
							
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$back2]Send the email to your colleagues.[/url]?>[/right]
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$johnwrongdone]Monitor your account for any strange activity.[/url]?>[/right]
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$back]Report to the IT department.[/url]?>[/right]
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$back2]Delete your account.[/url]?>[/right]
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]Let me try to remember.[/url]?>[/right]
							"""
						),
					"$johnwrongdone":
						Utils.dialog_part(
							"""
							[b]John[/b]
							
							Wow, okay. I hope that this solves the problem. Falling for a phishing email is really scary! I should have paid more attention to those [b]posters at the back[/b].
							
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end:wrong]Posters? I should check them out.[/url]?>[/right]
							"""
						),
				},
				"socialengineering"
			)
		elif state == 5:
			hud.show_dialog(
				"phishingemail1",
				{
					"$begin":
						Utils.dialog_part(
							"""
							[b]John[/b]
							
							Did you check those posters out? I hope I don't fall for another phishing email...
							
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]I hope so too.[/url]?>[/right]
							"""
						)
				},
				"socialengineering"
			)

func _on_area_2d_area_entered(area):
	print("interactable!")
	if area.is_in_group("Player"):
		interact()
