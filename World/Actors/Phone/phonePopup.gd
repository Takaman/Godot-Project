extends Node2D

@onready var phone = get_node("phone")
@onready var t = 0.0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if t < 1.0:
		t += delta * 2.5
		print(t)
		phone.position = Vector2(179,278).lerp(Vector2(179,120), t)
	else:
		pass
