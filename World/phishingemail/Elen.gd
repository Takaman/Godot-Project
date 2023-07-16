extends Sprite2D

@onready var hud := $"/root/house_internal_phishingemail/HUD"
@onready var marker := get_node("marker")
@onready var state = -1

func _on_hud_partsignaller():
	pass # Replace with function body.

func _physics_process(delta: float) -> void:
	if Score.get_result("realemail1","socialengineering") != 0:
		if marker != null and marker is Node:
				marker.visible = false
	if Score.get_result("realemail1","socialengineering") == 1:
		state == 1
	elif Score.get_result("realemail1","socialengineering") == 2:
		state == 5

func interact() -> void:
	print("interaction started")
	if state == -1:
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
						IT Department <it_department@itgrp11.com>
						
						Subject: [Urgent] Company Account Security Alert - Action Required
						
						Dear Caren,
						
						Our security systems have detected unusual login activity from your company email account. We believe that your account may have been compromised, and advise you to take immediate action to safeguard company and personal data.
						
						Please refer to the following instructions to ensure the security of your email account.
						
						[ol]
						[li]Click the following link to access our company's email portal: [url]placeholder[/url][/li]
						[li]Enter your current email login credentials to verify your identity.[/li]
						[li]Once successfully verified, you will be able to change your password. Please use a combination of uppercase and lowercase letters, numbers, and special characters to create a strong password.[/li]
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
						
						I'd hate to waste their time... but I'll go look for someone from IT. Come talk to me again in a bit.
						
						[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]Ok.[/url]?>[/right]
						"""
					),
			},
			"socialengineering"
		)

