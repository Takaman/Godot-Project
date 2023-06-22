extends Sprite2D

@onready var hud := $"/root/house_internal_phishingemail/HUD"
@onready var state = 0
signal john_next

func _on_john_it_guy():
	state = 1
	get_node("marker").texture = load("res://World/phishingemail/Images/in_prog.png")

func interact() -> void:
	print("interaction started")
	if state == 0:
		hud.show_dialog(
			"IT Guy",
			{
				"$begin":
					Utils.dialog_part(
						"""
						IT Guy: Hi, I'm the IT guy.
						
						<?[url=$end]I see.[/url]
						"""
					)
			},
			"training"
		)
	elif state == 1:
		hud.show_dialog(
			"IT Guy",
			{
				"$begin":
					Utils.dialog_part(
						"""
						IT Guy: Hi, I'm the IT guy.
						
						<?[url=$next]Hey, John fell for a phishing email. What should we do?[/url]
						<?[url=$end]I see.[/url]
						"""
					),
				"$next":
					Utils.dialog_part(
						"""
						IT Guy: What!? That's bad news... for starters, please get him to change his password and run an antivirus scan.
						
						<?[url=$next2]Will do. What else?[/url]
						"""
					),
				"$next2":
					Utils.dialog_part(
						"""
						IT Guy: Well, since you reported it so quickly, there shouldn't be much else we need to do, but I'll check through our systems on my side just to be safe.
						
						<?[url=$end]Alright.[/url]
						"""
					)
			},
			"training"
		)
		emit_signal("john_next")
