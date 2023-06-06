extends StaticBody2D

# Constants for movement and physics
const SPEED = 100
const MAX_HEIGHT = 100
const MIN_HEIGHT = 0

# Variables for movement and physics
var direction = 1
@onready var animationPlayer = get_node("AnimatedSprite2D")

func _ready():
	add_to_group("Boss")
	#Connecting with player signal
	var player = get_node("/root/DungeonWorld/Player")
	player.connect("collided_with_boss", Callable(self , "_on_player_collided_with_boss"))
	animationPlayer.play("idle")
	# Register the _on_body_entered signal
	
# Called when the node enters the scene tree for the first time.
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func show_popout_interface():
	var cyclop_dialog_box = get_node("/root/DungeonWorld/cyclop_dialog")
	cyclop_dialog_box.show()
	get_tree().paused = true
	
func _on_area_2d_body_entered(body):
	if body.is_in_group("Player"):
		print("Detected!")
		show_popout_interface()
	
