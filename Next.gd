extends Button


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func back_on_pressed():
	#SceneTransition.change_scene("res://World/world.tscn")# Replace with function body.
	SceneTransition.change_scene("res://menu/interactinstruction.tscn")
