extends Sprite2D

@onready var hud := $"/root/FoodCourt/HUD"
@onready var interactable := $"/root/FoodCourt/GantryEnter/Interactable3"

func _ready():
	interactable.exclamation_mark()
	pass
	
func interact() -> void:
	print("interaction started")
	hud.show_dialog(
		"gantryenter",
		{
			"$begin":
				Utils.dialog_part(
					"""
					Please scan your access card to enter the facility. 
					<?[url=$enter:signaller1]Scan[/url]?>
					<?[url=$noenter:signaller2]Don't scan[/url]?>
					"""
				),
			"$enter":
				Utils.dialog_part(
					"""
					The gantry has opened.
					<?[url=$end]Exit[/url]?>
					"""
				),
			"$noenter":
				Utils.dialog_part(
					"""
					The gantry has not opened.
					<?[url=$end]Exit[/url]?>
					"""
				),
			"$end":
				Utils.dialog_part("You can now enter the facility.")
		},
		"training"
	)
	
func _on_hud_partsignaller():
	print(hud.part_name)
	if hud.part_name == "$enter":
		open_gantry()
		var timer = get_node("/root/FoodCourt/GantryEnter/Timer")
		timer.timeout.connect(_on_timer_timeout)
		timer.start(5)

func open_gantry():
	if interactable != null and interactable is Node:
		interactable.remove_mark()
	self.visible = false
	get_node("/root/FoodCourt/GantryEnter/StaticBody2D/CollisionShape2D").set_deferred("disabled", true)
	
func _on_timer_timeout():
	print("TIEMR")
	self.visible = true
	get_node("/root/FoodCourt/GantryEnter/StaticBody2D/CollisionShape2D").set_deferred("disabled", false)


