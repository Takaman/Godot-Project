extends Sprite2D

@onready var hud := $"/root/house_internal_phishingemail/HUD"
@onready var marker := get_node("marker")
@onready var state = -1
@onready var itguy := $"/root/house_internal_phishingemail/ITGuy"
@onready var itguyinprogress : bool = false

signal IT_Guy_Elen
signal elen_done

func _on_hud_partsignaller():
	if hud.part_name == "$elennoclick":
		if state == 0:
			state = 2
			emit_signal("IT_Guy_Elen")
		if marker != null and marker is Node:
			marker.in_progress()
	elif hud.part_name == "$elenclick":
		if state == 0:
			state = 1
		if marker != null and marker is Node:
			marker.remove_mark()
	elif hud.part_name == "$elenwrongdone":
		if marker != null and marker is Node:
			marker.remove_mark()
		state = 4
		emit_signal("elen_done")

func _physics_process(delta: float) -> void:
	if Score.get_result("realemail1","socialengineering") != 0:
		if marker != null and marker is Node:
				marker.visible = false
	if Score.get_result("realemail1","socialengineering") == 1:
		state = 1
	elif Score.get_result("realemail1","socialengineering") == 2:
		state = 4
	
	#Disables interaction while another question is in progress
	if itguy.get_itguy_state() == "base" or itguy.get_itguy_state() == "elen" or itguy.get_itguy_state() == "elen2":
		itguyinprogress = false
		if marker != null and marker is Node:
			marker.toggle_visibility(true)
	else:
		itguyinprogress = true
		if marker != null and marker is Node:
			marker.toggle_visibility(false)

func _on_it_guy_elen_next():
	state = 3

func interact() -> void:
	print("interaction started")
	if itguyinprogress == true:
		hud.show_dialog(
			"realemail1",
			{
				"$begin":
					Utils.dialog_part(
						"""
						[b]Elen[/b]
						
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
				"realemail1",
				{
					"$begin":
						Utils.dialog_part(
							"""
							[b]Elen[/b]
							
							Hello! If you have time, could you help me take a look at an email?
							
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$elennext]Sure, I can take a look.[/url]?>[/right]
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]Not right now.[/url]?>[/right]
							"""
						),
					"$elennext":
						Utils.dialog_part(
							"""
							IT Department <it_department@itpgrp11.com>
							
							Subject: [Urgent] Company Account Security Alert - Action Required
							
							Dear Elen,
							
							Our security systems have detected unusual login activity from your company email account. We believe that your account may have been compromised, and advise you to take immediate action to safeguard company and personal data.
							
							Please refer to the following instructions to ensure the security of your email account.
							
							[ol]
							Click the following link to access our company's email portal: intranet.itpgrp11.com/staff/email
							Enter your current email login credentials to verify your identity.
							Once successfully verified, you will be able to change your password. Please use a combination of uppercase and lowercase letters, numbers, and special characters to create a strong password.
							[/ol]
							
							Please complete this as soon as possible so as to preserve the security of your personal and company information.
							
							If you require assistance, please do not hesitate to reply to this email or look for one of our IT staff.
							
							Sincerely,
							
							IT Department
							ITPGRP11
							
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$elenclick:correct]You'd better change your password quickly before any information gets compromised.[/url]?>[/right]
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$elennoclick]Have you checked with the IT department?[/url]?>[/right]
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]Give me some time to think about it.[/url]?>[/right]
							"""
						),
					"$elenclick":
						Utils.dialog_part(
							"""
							[b]Elen[/b]
							
							You're right - I'll do it quickly.
							
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]Good idea.[/url]?>[/right]
							"""
						),
					"$elennoclick":
						Utils.dialog_part(
							"""
							[b]Elen[/b]
							
							I'd hate to waste their time... Help me look for someone from IT and ask them.
							
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]Ok.[/url]?>[/right]
							"""
						),
				},
				"socialengineering"
			)
		elif state == 1:
			hud.show_dialog(
				"realemail1",
				{
					"$begin":
						Utils.dialog_part(
							"""
							[b]Elen[/b]
							
							Hello! I was able to change my email account password successfully, so thanks for helping me determine that the email was real!
							
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]Happy to help.[/url]?>[/right]
							"""
						),
				},
				"socialengineering"
			)
		elif state == 2:
			hud.show_dialog(
				"realemail1",
				{
					"$begin":
						Utils.dialog_part(
							"""
							[b]Elen[/b]
							
							Have you found someone from IT?
							
							Here's the email if you want to read it again.
							
							IT Department <it_department@itpgrp11.com>
							
							Subject: [Urgent] Company Account Security Alert - Action Required
							
							Dear Elen,
							
							Our security systems have detected unusual login activity from your company email account. We believe that your account may have been compromised, and advise you to take immediate action to safeguard company and personal data.
							
							Please refer to the following instructions to ensure the security of your email account.
							
							[ol]
							Click the following link to access our company's email portal: intranet.itpgrp11.com/staff/email
							Enter your current email login credentials to verify your identity.
							Once successfully verified, you will be able to change your password. Please use a combination of uppercase and lowercase letters, numbers, and special characters to create a strong password.
							[/ol]
							
							Please complete this as soon as possible so as to preserve the security of your personal and company information.
							
							If you require assistance, please do not hesitate to reply to this email or look for one of our IT staff.
							
							Sincerely,
							
							IT Department
							ITPGRP11
							
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]Ok.[/url]?>[/right]
							"""
						),
				},
				"socialengineering"
			)
		elif state == 3:
			hud.show_dialog(
				"realemail1",
				{
					"$begin":
						Utils.dialog_part(
							"""
							[b]Elen[/b]
							
							It was a real email? Oh dear, that must have been annoying for the IT staff, but better safe than sorry I guess.
							
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$elenwrongdone]It's how we learn.[/url]?>[/right]
							"""
						),
					"$elenwrongdone":
						Utils.dialog_part(
							"""
							[b]Elen[/b]
							
							True! I'll make sure to look at the posters so I can identify emails myself in the future.
							
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end:wrong]That's a good idea.[/url]?>[/right]
							"""
						)
				},
				"socialengineering"
			)
		elif state == 4:
			hud.show_dialog(
				"realemail1",
				{
					"$begin":
						Utils.dialog_part(
							"""
							[b]Elen[/b]
							
							Have you looked at the posters? They're quite educational.
							
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]Sounds like a good idea.[/url]?>[/right]
							"""
						)
				},
				"socialengineering"
			)
