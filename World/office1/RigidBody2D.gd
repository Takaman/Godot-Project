extends Control

var speed = 100  # Adjust the speed value as needed

func _process(delta: float) -> void:
	var velocity = Vector2(speed, 0) * delta
	position += velocity
