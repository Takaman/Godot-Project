extends Node2D

const BOUNCE_MAGNITUDE := 2
const BOUNCE_SPEED_MULTIPLIER := 8
var _delta := 0.0

@onready var sprite = $Sprite2D

func _physics_process(delta: float) -> void:
	_delta += delta
	sprite.position.y = sin(_delta * BOUNCE_SPEED_MULTIPLIER) * BOUNCE_MAGNITUDE
