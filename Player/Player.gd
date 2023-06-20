extends CharacterBody2D

#Constant values for movement and physics
const SPEED = 5000
const MAX_SPEED = 100
const FRICTION = 350
const JUMP_VELOCITY = -400.0
signal healthChanged

@export var maxHealth = 3
@onready var currentHealth: int = 3

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity");
#Needs the ready function to instantiate the animationPlayer. Need to get access to the node of your child
@onready var animationPlayer = get_node("AnimatedSprite2D")
@onready var actionable_finder: Area2D = $Direction/ActionableFinder
@onready var ontouch_finder: Area2D = $Direction/OnTouchFinder
var dialoguecheck: bool = false
var input_vector: Vector2 = Vector2.ZERO

#Add the player to a group
func _ready():
	add_to_group("Player") 

func _trigger_decreasehealth():
	currentHealth -= 1
	healthChanged.emit(currentHealth)

func player():
	pass

func _unhandled_input(_event: InputEvent) -> void:
	if ontouch_finder.has_overlapping_areas() == true && Global.sam_check == false:
		var ontouch = ontouch_finder.get_overlapping_areas()
		if ontouch.size() > 0:
			dialoguecheck = true
			ontouch[0].action()
			return
	if Input.is_action_just_pressed("ui_accept"):
		var actionables = actionable_finder.get_overlapping_areas()
		if actionables.size() > 0:
			dialoguecheck = true
			actionables[0].action()
			return
	dialoguecheck = false

func _physics_process(delta) -> void:
	if dialoguecheck == false:
		#Getting the input direction and handle movement and acceleration
		#Normalising means speed will be the same with two keys pressed when compared to one key
		velocity.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
		velocity.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
		velocity = velocity.normalized()
		#Flipping of animation to run left as well. Sprite sheet limited
		if velocity != Vector2.ZERO:
			if velocity.x > 0:
				animationPlayer.play("runright")
				$AnimatedSprite2D.flip_h = false
			else:
				animationPlayer.play("runright")
				$AnimatedSprite2D.flip_h = true
			
			#For more natural movement to hit max speed and bringing it down for natural movement
			velocity = velocity.move_toward(velocity * MAX_SPEED, SPEED * delta)
		else:		
			animationPlayer.play("idleright")
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		
		
		#Moving and sliding the character
		move_and_slide()


func _on_area_2d_body_entered(body):
	pass # Replace with function body.


func _on_area_2d_body_exited(body):
	pass # Replace with function body.
