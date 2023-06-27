extends Sprite2D

@onready var hud := $"/root/house_internal_phishingemail/HUD"
@onready var marker := get_node("marker")
@onready var state = 0
signal john_next

func _ready():
	if marker is Node:
		marker.toggle_visibility(false)
	pass

func _on_john_it_guy():
	state = 1
	if marker is Node:
		marker.toggle_visibility(true)

func interact() -> void:
	print("interaction started")
	if state == 0:
		hud.show_dialog(
			"IT Guy",
			{
				"$begin":
					Utils.dialog_part(
						"""
						[b]IT Guy[/b]
						Hi, I'm the IT guy.
						
						<?[url=$end][right]I see.[/right][/url]
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
						[b]IT Guy[/b]
						Hi, I'm the IT guy.
						
						<?[url=$next][right]Hey, John fell for a phishing email. What should we do?[/right][/url]
						<?[url=$end][right]I see.[/right][/url]
						"""
					),
				"$next":
					Utils.dialog_part(
						"""
						[b]IT Guy[/b]
						What!? That's bad news... for starters, please get him to [b]change his password[/b] and [b]run an antivirus scan[/b].
						
						<?[url=$next2][right]Will do. What else?[/right][/url]
						"""
					),
				"$next2":
					Utils.dialog_part(
						"""
						[b]IT Guy[/b]
						Well, since you reported it so quickly, there shouldn't be much else we need to do, but I'll check through our systems on my side just to be safe.
						
						<?[url=$end][right]Alright.[/right][/url]
						"""
					)
			},
			"training"
		)
		emit_signal("john_next")
		if marker is Node:
			marker.remove_mark()
