extends Sprite2D

@onready var hud := $"/root/house_internal_phishingemail/HUD"
@onready var marker := get_node("marker")
@onready var state : String = "base"

func _on_hud_partsignaller():
	pass # Replace with function body.

func _ready():
	if marker != null and marker is Node:
		marker.toggle_visibility(false)
	pass

func get_itguy_state() -> String:
	return state

func _on_john_it_guy():
	state = "john"
	if marker != null and marker is Node:
		marker.toggle_visibility(true)
		marker.in_progress()

func interact() -> void:
	print("interaction started")
	if state == "base":
		hud.show_dialog(
			"IT Guy",
			{
				"$begin":
					Utils.dialog_part(
						"""
						[b]IT Guy[/b]
						Hi, I'm the IT guy.
						
						[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]I see.[/url]?>[/right]
						"""
					)
			},
			"training"
		)
	elif state == "john":
		hud.show_dialog(
			"IT Guy",
			{
				"$begin":
					Utils.dialog_part(
						"""
						[b]IT Guy[/b]
						Hi, I'm the IT guy.
						
						[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$next]Hey, John fell for a phishing email. What should we do?[/url]?>[/right]
						[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]I see.[/url]?>[/right]
						"""
					),
				"$next":
					Utils.dialog_part(
						"""
						[b]IT Guy[/b]
						What!? That's bad news... for starters, please get him to [b]change his password[/b] and [b]run an antivirus scan[/b].
						
						[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$next2]Will do. What else?[/url]?>[/right]
						"""
					),
				"$next2":
					Utils.dialog_part(
						"""
						[b]IT Guy[/b]
						Well, since you reported it so quickly, there shouldn't be much else we need to do, but I'll check through our systems on my side just to be safe.
						
						[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]Alright.[/url]?>[/right]
						"""
					)
			},
			"training"
		)
		state = "base"
		emit_signal("john_next")
		if marker != null and marker is Node:
			marker.remove_mark()
		


