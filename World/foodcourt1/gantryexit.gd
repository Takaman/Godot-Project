extends Sprite2D

@onready var hud := $"/root/FoodCourt/HUD"
@onready var interactable := $"/root/FoodCourt/GantryExit/Interactable4"

func _ready():
	interactable.exclamation_mark()
	pass
	
func interact() -> void:
	print("interaction started")
	hud.show_dialog(
		"gantryexit",
		{
			"$begin":
				Utils.dialog_part(
					"""
					Please scan your access card to exit the facility. 
					
					[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$exit:signaller1]Scan[/url]?>[/right]
					
					[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$noexit:signaller2]Don't scan[/url]?>[/right]
					"""
				),
			"$exit":
				Utils.dialog_part(
					"""
					The gantry has opened.
					[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]Exit[/url]?>[/right]
					"""
				),
			"$noexit":
				Utils.dialog_part(
					"""
					The gantry has not opened.
					[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]Exit[/url]?>[/right]
					"""
				),
			"$end":
				Utils.dialog_part("You can now exit the facility.")
		},
		"training"
	)

func _on_hud_partsignaller():
	if hud.part_name == "$exit":
		open_gantry()
		var timer = get_node("/root/FoodCourt/GantryExit/Timer")
		timer.timeout.connect(_on_timer_timeout)
		timer.start(5)
		
func open_gantry():
	if interactable != null and interactable is Node:
		interactable.remove_mark()
	self.visible = false
	get_node("/root/FoodCourt/GantryExit/StaticBody2D/CollisionShape2D").set_deferred("disabled", true)

func _on_timer_timeout():
	print("TIEMR")
	self.visible = true
	get_node("/root/FoodCourt/GantryExit/StaticBody2D/CollisionShape2D").set_deferred("disabled", false)



