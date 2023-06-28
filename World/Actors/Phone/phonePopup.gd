extends Node2D

@onready var phone = get_node("phone")
@onready var t = 0.0

func _physics_process(delta):
	if t < 1.0:
		t += delta * 2.5
		#print(t)
		phone.position = Vector2(179,278).lerp(Vector2(179,90), t)
	else:
		pass
