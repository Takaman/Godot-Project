extends Sprite2D

@onready var hud := $"/root/FoodCourt/HUD"
@onready var interactable := $"/root/FoodCourt/WhitewallsGantryEnter/Interactable3"

func _ready():
	interactable.exclamation_mark()
	pass
	
func interact() -> void:
	print("interaction started")
	hud.show_dialog(
		"WhitewallsGantryEnter",
		{
			"$begin":
				Utils.dialog_part(
					"""
					Please scan your access card to enter the food court. 
					<?[url=$enterfood]Scan[/url]?>
					<?[url=$noenterfood]Don't scan[/url]?>
					"""
				),
			"$enterfood":
				Utils.dialog_part(
					"""
					The gantry has opened.
					<?[url=$end]Exit[/url]?>
					"""
				),
			"$noenterfood":
				Utils.dialog_part(
					"""
					The gantry has not opened.
					<?[url=$end]Exit[/url]?>
					"""
				),
			"$end":
				Utils.dialog_part("You can now enter the food court.")
		},
		"training"
	)

func _on_hud_partsignaller():
	if hud.part_name == "$enterfood":
		open_gantry()
		var timer = get_node("/root/FoodCourt/WhitewallsGantryEnter/Timer")
		timer.timeout.connect(_on_timer_timeout)
		timer.start(5)

func open_gantry():
	if interactable != null and interactable is Node:
		interactable.remove_mark()
	self.visible = false
	get_node("/root/FoodCourt/WhitewallsGantryEnter/StaticBody2D/CollisionShape2D").set_deferred("disabled", true)

func _on_timer_timeout():
	print("TIEMR")
	self.visible = true
	get_node("/root/FoodCourt/WhitewallsGantryEnter/StaticBody2D/CollisionShape2D").set_deferred("disabled", false)

