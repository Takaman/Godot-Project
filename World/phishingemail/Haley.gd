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
	if state == -1:
		state = 0
		hud.show_dialog(
			"realemail4",
			{
				"$begin":
					Utils.dialog_part(
						"""
						[b]Haley[/b]
						
						Hi! I need some help to check an email.
						
						placeholder image
						
						[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]Give me some time to think about it.[/url]?>[/right]
						"""
					)
			},
			"socialengineering"
		)

