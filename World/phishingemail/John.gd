extends Sprite2D

@onready var hud := $"/root/house_internal_phishingemail/HUD"
@onready var marker := get_node("marker")
@onready var state = -1
signal IT_Guy

func _on_hud_correct():
	if state == 0:
		state = 1
		if marker is Node:
			marker.remove_mark()

func _on_hud_wrong():
	if state == 0:
		state = 2
		if marker is Node:
			marker.in_progress()

func _on_it_guy_john_next():
	state = 4

func interact() -> void:
	print("interaction started")
	if state == -1:
		state = 0
		hud.show_dialog(
			"John",
			{
				"$begin":
				Utils.dialog_part(
					"""
					[b]John[/b]
					Hey... I just received this email and it looks quite important. Do you think I should follow the link and change my password?
					
					[center][img=240x200]res://World/phishingemail/Images/email1.png[/img][/center]
					
					<?[url=$correct:correct][right]Have you checked with the IT department?[/right][/url]?>
					<?[url=$wrong:wrong][right]There's not much time left! You'd better change your password now.[/right][/url]?>
					<?[url=$end][right]Give me some time to think about it.[/right][/url]?>
					"""
					),
				"$correct":
					Utils.dialog_part(
					"""
					[b]John[/b]
					Hmm... that seems like a good idea! I'll drop them an email to check.
					
					<?[url=$end][right]No problem, better safe than sorry.[/right][/url]?>
					"""
					),
				"$wrong":
					Utils.dialog_part(
						"""
						[b]John[/b]
						You're right, I'd better do it quickly. Let's see... that's strange, the website looks a little different from usual, but I guess it's been a while.
						
						<?[url=$end][right]... ?[/right][/url]?>
						"""
					),
			},
			"socialengineering"
		)
	elif state == 1:
		hud.show_dialog(
			"John",
			{
				"$begin":
					Utils.dialog_part(
						"""
						[b]John[/b]
						Hey, its you again! Thanks for your help! I managed to avoid falling for a phishing email thanks to you.
						
						<?[url=$end][right]No problem, I was glad to be of help.[/right][url]
						"""
					)
			},
			"training"
		)
	elif state == 2:
		hud.show_dialog(
			"John",
			{
				"$begin":
					Utils.dialog_part(
						"""
						[b]John[/b]
						I should download the PDF file to check if I did it correctly as well. Huh? My antivirus says its not safe... what's going on?
						
						<?[url=$wrong3][right]... ![/right][/url]?>
						"""
					),
				"$wrong3":
				Utils.dialog_part(
					"""
					[b]John[/b]
					Oh well, I'll just submit my password.
					
					<?[url=$wrong4][right]Hold on! That might have been a phishing email![/right][/url]?>
					"""
					),
				"$wrong4":
					Utils.dialog_part(
						"""
						[b]John[/b]
						What!? But I already gave them my password... Oh no... Could you help me inform the IT department?
						
						<?[url=$end][right]OK.[/right][/url]?>
						"""
					)
			},
			"training"
		)
		state = 3
		emit_signal("IT_Guy")
	elif state == 3:
		hud.show_dialog(
			"John",
			{
				"$begin":
					Utils.dialog_part(
						"""
						[b]John[/b]
						Have you informed the IT department? Please help me do so... I hope nothing bad happens...
						
						<?[url=$end][right]OK.[/right][/url]?>
						"""
					)
			}
		)
	elif state == 4:
		hud.show_dialog(
			"John",
			{
				"$begin":
					Utils.dialog_part(
						"""
						[b]John[/b]
						What did they tell you? I should change my password and run an antivirus scan?
						
						<?[url=$next][right]Thankfully we reported it quickly.[/right][/url]?>
						"""
					),
				"$next":
					Utils.dialog_part(
						"""
						[b]John[/b]
						No kidding... Falling for a phishing email is really scary. I should have paid more attention to the [b]posters at the back of the office[/b]...
						
						<?[url=$end][right]Posters? Maybe I should check them out myself.[/right][/url]?>
						"""
					)
			},
			"training"
		)
		if marker is Node:
			marker.remove_mark()
		state == 5
	elif state == 5:
		hud.show_dialog(
			"John",
			{
				"$begin":
					Utils.dialog_part(
						"""
						[b]John[/b]
						Did you check those posters out? I hope I don't fall for another phishing email...
						
						<?[url=$end][right]I hope so too.[/right][/url]?>
						"""
					)
			},
			"training"
		)

func _on_area_2d_area_entered(area):
	print("interactable!")
	if area.is_in_group("Player"):
		interact()
