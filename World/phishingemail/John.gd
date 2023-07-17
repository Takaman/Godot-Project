extends Sprite2D

@onready var hud := $"/root/house_internal_phishingemail/HUD"
@onready var marker := get_node("marker")
@onready var state = -1
signal IT_Guy

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

func _on_it_guy_john_next():
	state = 4

func interact() -> void:
	print("interaction started")
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
					
					Please click the link below to reset your password. A PDF document has been attached with instructions if you are unfamiliar with the pasword reset process.
					
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
						
						What!? But I already gave them my password... Oh no... Could you help me inform the IT department?
						
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
						
						Have you informed the IT department? Please help me do so... I hope nothing bad happens...
						
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
						
						What did they tell you? I should [b]change my password[/b] and [b]run an antivirus scan[/b]?
						
						[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$next]Thankfully we reported it quickly.[/url]?>[/right]
						"""
					),
				"$next":
					Utils.dialog_part(
						"""
						[b]John[/b]
						
						No kidding... Falling for a phishing email is really scary. I should have paid more attention to the [b]posters at the back of the office[/b]...
						
						[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end:wrong]Posters? Maybe I should check them out myself.[/url]?>[/right]
						"""
					)
			},
			"socialengineering"
		)
		if marker != null and marker is Node:
			marker.remove_mark()
		state = 5
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

func _physics_process(delta: float) -> void:
	if Score.get_result("phishingemail1","socialengineering") != 0:
		if marker != null and marker is Node:
				marker.visible = false
	if Score.get_result("phishingemail1","socialengineering") == 1: #if result is correct
		state = 1
	elif Score.get_result("phishingemail1","socialengineering") == 2: #if result is wrong
		state = 5
