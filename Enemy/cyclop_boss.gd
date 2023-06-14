extends StaticBody2D

const SPEED = 100
const MAX_HEIGHT = 100
const MIN_HEIGHT = 0

var direction = 1
var dialog_shown = false
var dialog_open_time = 0
var close_dialog = false
@onready var animationPlayer = get_node("AnimatedSprite2D")

var dialogue_start: String = "start"
var dialogue_resource: DialogueResource

func _ready():
	add_to_group("Boss")
	var player = get_node("/root/Level1/Player")
	player.connect("collided_with_boss", Callable(self, "_on_player_collided_with_boss"))
	animationPlayer.play("idle")
	process_mode = Node.PROCESS_MODE_ALWAYS

	# Load the dialogue resource from the file
	dialogue_resource = load("res://dialogue/main.dialogue")

func _input(event):
	if event is InputEventKey and event.is_pressed():
		if close_dialog:
			hide_dialogue() # Close the dialogue

func show_popout_interface():
	DialogueManager.show_example_dialogue_balloon(dialogue_resource, dialogue_start) # Show the dialogue using the DialogueManager plugin

func hide_dialogue():
	DialogueManager.hide_dialogue() # Hide the dialogue using the DialogueManager plugin

func _on_area_2d_body_entered(body):
	if body.is_in_group("Player") and not dialog_shown:
		print("Detected!")
		show_popout_interface()
		dialog_shown = true
