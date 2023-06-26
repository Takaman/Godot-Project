extends Sprite2D

@onready var _follow :PathFollow2D = get_parent()
var _speed :float = 120.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every physics frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	_follow.set_progress(_follow.get_progress() + _speed * delta)
