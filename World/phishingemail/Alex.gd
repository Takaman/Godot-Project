extends Sprite2D

@onready var hud := $"/root/house_internal_phishingemail/HUD"

func interact() -> void:
	get_node("marker").queue_free()
	print("interaction started")
	hud.show_dialog(
		"John",
		{
			"$begin":
			Utils.dialog_part(
				"""
				John: Hey... I just received this email and it looks quite important. Do you think I should follow the link and change my password?
				
				[center][img=240x200]res://World/phishingemail/Images/email1.png[/img][/center]
				
				<?[url=$correct]Have you checked with the IT department?[/url]?>
				<?[url=$wrong]There's not much time left! You'd better change your password now.[/url]?>
				<?[url=$end]Give me some time to think about it.[/url]?>
				"""
				),
			"$correct":
				Utils.dialog_part(
				"""
				John: Hmm... that seems like a good idea! I'll drop them an email to check.
				
				<?[url=$end]No problem, better safe than sorry.[/url]?>
				"""
				),
			"$wrong":
				Utils.dialog_part(
					"""
					John: You're right, I'd better do it quickly. Let's see... that's strange, the website looks a little different from usual, but I guess it's been a while.
					
					<?[url=wrong2]... ?[/url]?>
					"""
				),
			"$wrong2":
				Utils.dialog_part(
					"""
					John: I should download the PDF file to check if I did it correctly as well. Huh? My antivirus says its not safe... what's going on?
					
					<?[url=wrong3]... ![/url]?>
					"""
				),
			"$wrong3":
			Utils.dialog_part(
				"""
				John: Oh well, I'll just submit my password.
				
				<?[url=wrong4]Hold on! That might have been a phishing email![/url]?>
				"""
			),
			"$wrong4":
				Utils.dialog_part(
					"""
					John: What!? But I already gave them my password...
					
					<?[url=wrong3]... ![/url]?>
					"""
				)
		}
		
	)

func _on_area_2d_area_entered(area):
	print("interactable!")
	if area.is_in_group("Player"):
		interact()
