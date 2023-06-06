extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# assuming your button is a Button node
@onready var button = get_node("Button")  # replace with the actual path to your button
@onready var cyclop_dialog_box = get_node("cyclop_dialog")



# connect the button's pressed signal to this method
func _on_Button_pressed():
	cyclop_dialog_box.hide()
	get_tree().paused = false
