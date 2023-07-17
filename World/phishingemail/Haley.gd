extends Sprite2D

@onready var hud := $"/root/house_internal_phishingemail/HUD"
@onready var marker := get_node("marker")
@onready var state = -1

func _on_hud_partsignaller():
	pass # Replace with function body.

func _physics_process(delta: float) -> void:
	if Score.get_result("realemail4","socialengineering") != 0:
		if marker != null and marker is Node:
				marker.visible = false
	if Score.get_result("realemail4","socialengineering") == 1:
		state == 1
	elif Score.get_result("realemail4","socialengineering") == 2:
		state == 5

func interact() -> void:
	print("interaction started")
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
						placeholder email
						
						[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$haleyclick:correct]Isn't this quite important for our company? You should follow what the email says.[/url]?>[/right]
						[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$haleynoclick]I think you should check with the bank.[/url]?>[/right]
						[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]Give me some time to think about it.[/url]?>[/right]
						"""
					),
				"$haleyclick":
					Utils.dialog_part(
						"""
						[b]Haley[/b]
						
						[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]Go for it.[/url]?>[/right]
						"""
					),
				"$haleynoclick":
					Utils.dialog_part(
						"""
						[b]Haley[/b]
						
						[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]Ok.[/url]?>[/right]
						"""
					),
			},
			"socialengineering"
		)

