extends Sprite2D

@onready var hud := $"/root/house_internal_phishingemail/HUD"
@onready var marker := get_node("marker")
@onready var state = -1
@onready var itguy := $"/root/house_internal_phishingemail/ITGuy"
@onready var itguyinprogress : bool = false

func _on_hud_partsignaller():
	if hud.part_name == "$haleynoclick":
		if state == 0:
			state = 2
		if marker != null and marker is Node:
			marker.in_progress()
	elif hud.part_name == "$haleyclick":
		if state == 0:
			state = 1
		if marker != null and marker is Node:
			marker.correct()
	elif hud.part_name == "$haleywrongdone":
		if marker != null and marker is Node:
			marker.wrong()
		state = 3

func _physics_process(delta: float) -> void:
	if Score.get_result("realemail4","socialengineering") == 1:
		state = 1
		if marker != null and marker is Node:
			marker.correct()
	elif Score.get_result("realemail4","socialengineering") == 2:
		state = 3
		if marker != null and marker is Node:
			marker.wrong()
			
	#Disables interaction while another question is in progress
	if itguy.get_itguy_state() == "base" or itguy.get_itguy_state() == "haley" or itguy.get_itguy_state() == "haley2":
		itguyinprogress = false
		if marker != null and marker is Node:
			marker.toggle_visibility(true)
	else:
		itguyinprogress = true
		if marker != null and marker is Node:
			marker.toggle_visibility(false)

func interact() -> void:
	print("interaction started")
	if itguyinprogress == true:
		hud.show_dialog(
			"realemail4",
			{
				"$begin":
					Utils.dialog_part(
						"""
						[b]Haley[/b]
						
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
				"realemail4",
				{
					"$begin":
						Utils.dialog_part(
							"""
							[b]Haley[/b]
							
							Hi! I need some help to check an email.
							
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$haleynext]Sure, I can take a look.[/url]?>[/right]
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]Not right now.[/url]?>[/right]
							"""
						),
					"$haleynext":
						Utils.dialog_part(
							"""
							Twitter <verify@twitter.com>
							
							Subject: New login to Twitter from ChromeDesktop on Windows
							
							[b]We noticed a login to your account @haley123322 from a new device. Was this you?[/b]
							
							New login
								Location*		Unknown location
								Device			ChromeDesktop on Windows
								
							*Location is approximate based on the login's IP address.
							
							[b]If this was you[/b]
							You can ignore this message. There's no need to take any action.
							
							[b]If this wasn't you[/b]
							Complete these steps now to protect your account.
							
							[ul]
							[url=https://twitter.com/account/begin_password_reset]Change your password.[/url] You'll be logged out of all your active Twitter sessions except the one you're using at this time.
							Review the apps that have access to your account and revoke access to any unfamiliar apps. [url=https://help.twitter.com/managing-your-account/connect-or-revoke-access-to-third-party-apps]Learn more[/url].
							[/ul]
							
							[center][url=https://support.twitter.com/articles/76036]Help[/url] | [url=https://help.twitter.com/en/safety-and-security/fake-twitter-emails]Email security tips[/url][/center]
							[center]We sent this email to @haley123322[/center]
							[center]X Corp. 1355 Market Street, Suite 900 San Francisco, CA 94103[/center]
							
							
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$haleyclick:correct]You should probably change your password.[/url]?>[/right]
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$haleynoclick]I think you should send a support ticket to Twitter to check if this is a real email.[/url]?>[/right]
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]Give me some time to think about it.[/url]?>[/right]
							"""
						),
					"$haleyclick":
						Utils.dialog_part(
							"""
							[b]Haley[/b]
							
							You're right! Better change my password in case someone hacked my account.
							
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]Go for it.[/url]?>[/right]
							"""
						),
					"$haleynoclick":
						Utils.dialog_part(
							"""
							[b]Haley[/b]
							
							Really? It's going to take a while to get a response... but I suppose it's safer. Come back in a bit when I get a reply/
							
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]Ok.[/url]?>[/right]
							"""
						),
				},
				"socialengineering"
			)
		elif state == 1:
			hud.show_dialog(
				"realemail4",
				{
					"$begin":
						Utils.dialog_part(
							"""
							[b]Haley[/b]
							
							Hi! I managed to change my password and secure my account! Thanks for helping me.
							
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]Welcome.[/url]?>[/right]
							"""
						),
				},
				"socialengineering"
			)
		elif state == 2:
			hud.show_dialog(
				"realemail4",
				{
					"$begin":
						Utils.dialog_part(
							"""
							[b]Haley[/b]
							
							I finally got a reply from customer service and they said the email was genuine. Did I really have to waste so much time worrying about it?
							
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$haleywrongdone]Oh...[/url]?>[/right]
							"""
						),
					"$haleywrongdone":
						Utils.dialog_part(
							"""
							[b]Haley[/b]
							
							There's a bunch of [b]posters at the back[/b] of the office that teach this stuff - we should take a look so this doesn't happen again!
							
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end:wrong]I'll do so.[/url]?>[/right]
							"""
						),
				},
				"socialengineering"
			)
		elif state == 3:
			hud.show_dialog(
				"realemail4",
				{
					"$begin":
						Utils.dialog_part(
							"""
							[b]Haley[/b]
							
							Have you taken a look at the [b]posters[/b]?
							
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]I'll do so.[/url]?>[/right]
							"""
						),
				},
				"socialengineering"
			)

