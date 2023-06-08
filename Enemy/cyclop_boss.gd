extends StaticBody2D

# Constants for movement and physics
const SPEED = 100
const MAX_HEIGHT = 100
const MIN_HEIGHT = 0

# Variables for movement and physics
var direction = 1
var dialog_shown = false #Tracking whether dialog has already been shown
var dialog_open_time = 0 #Tracking how long the dialog has already been open
var close_dialog = false #Whether dialog can be closed or not
@onready var animationPlayer = get_node("AnimatedSprite2D")
@onready var cyclop_dialog_box = get_node("/root/DungeonWorld/CanvasLayer/cyclop_dialog")
@onready var cyclop_dialog_label = get_node("/root/DungeonWorld/CanvasLayer/cyclop_dialog/TextureRect/Label2")

func _ready():
	add_to_group("Boss")
	#Connecting with player signal
	var player = get_node("/root/DungeonWorld/Player")
	player.connect("collided_with_boss", Callable(self , "_on_player_collided_with_boss"))
	animationPlayer.play("idle")
	process_mode = Node.PROCESS_MODE_ALWAYS #So that the node still processes after pausing for dialog
	
# Called when the node enters the scene tree for the first time.
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#If the dialog has been set to true, it runs the timer
	if dialog_shown:
		dialog_open_time += delta
		if dialog_open_time > 2:
			close_dialog = true


		
	
func _input(event):
	if event is InputEventKey and event.is_pressed() and close_dialog:
		#A key pressed. Means skip the dialog
		cyclop_dialog_box.hide()
		get_tree().paused = false
		dialog_open_time = 0
		close_dialog = false

func show_popout_interface():
	cyclop_dialog_label.start_typing()
	cyclop_dialog_box.show()
	get_tree().paused = true
	
func _on_area_2d_body_entered(body):
	if body.is_in_group("Player") and not dialog_shown:
		print("Detected!")
		show_popout_interface()
		dialog_shown = true
	
