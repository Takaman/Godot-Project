extends CharacterBody2D

#Constant values for movement and physics
const SPEED = 5000
const MAX_SPEED = 100
const FRICTION = 350
const JUMP_VELOCITY = -400.0
signal healthChanged


@export var maxHealth = 3
@onready var currentHealth: int = 3
@onready var timer = $Timer
@onready var foot_steps = $FootSteps

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity");
#Needs the ready function to instantiate the animationPlayer. Need to get access to the node of your child
@onready var animationPlayer = get_node("AnimatedSprite2D")
@onready var actionable_finder: Area2D = $Direction/ActionableFinder
@onready var ontouch_finder: Area2D = $Direction/OnTouchFinder
@onready var dialoguecheck: bool = false
@onready var inputcheck: bool = false
var input_vector: Vector2 = Vector2.ZERO
var current_dir = "front"

#Called when its started in the scene for the first time
func _ready():
	add_to_group("Player") 
	var hud = get_tree().get_nodes_in_group("HUD_Group")
	
	hud[0].connect("dialogue_opened", Callable(self,"_on_dialogue_opened"))
	hud[0].connect("dialogue_closed", Callable(self,"_on_dialogue_closed"))
	hud[0].connect("input_opened", Callable(self,"_on_input_opened"))
	hud[0].connect("input_closed", Callable(self,"_on_input_closed"))
	
	var hud2 = get_tree().get_nodes_in_group("PanelHUD_Group")
	if hud2.size() > 0:
		hud2[0].connect("panel_closed", Callable(self, "_on_panel_closed"))
		hud2[0].connect("panel_closed", Callable(self,"_on_dialogue_closed")) 
	
	
	if not Global.is_player_frozen:
		dialoguecheck = false
	#$"/root/Base_Map/HUD".connect("dialogue_closed",Callable(self,"_on_dialogue_closed"))

func _trigger_decreasehealth():
	currentHealth -= 1
	healthChanged.emit(currentHealth)

func player():
	pass

func _unhandled_input(_event: InputEvent) -> void:
	
	if Input.is_action_just_pressed("interact") && dialoguecheck == false:
		print("test!")
		var actionables = actionable_finder.get_overlapping_areas()
		if actionables.size() > 0:
			print("ACTIONABLE detected!")
			var interactable = actionables[0].get_parent()
			if interactable.has_method("interact"):
				dialoguecheck=true
				Global.is_player_frozen=true
				print("action")
				interactable.interact()
	
	#For ontouch.tscn under helpers - uses collision layer 6 so shouldn't affect actionable
	if ontouch_finder.has_overlapping_areas() == true && dialoguecheck == false:
		var ontouch = ontouch_finder.get_overlapping_areas()
		if ontouch.size() > 0:
			print("ONTOUCH detected!")
			var interact_ontouch = ontouch[0].get_parent()
			if interact_ontouch.has_method("interact_ontouch"):
				dialoguecheck = true
				Global.is_player_frozen = true
				interact_ontouch.interact_ontouch()
				#deletes collision instance so it only works once
				ontouch[0].queue_free()
				return
#	dialoguecheck = false
	

func _physics_process(delta) -> void:
	
	if dialoguecheck == false and inputcheck == false:
		#Getting the input direction and handle movement and acceleration
		#Normalising means speed will be the same with two keys pressed when compared to one key
		velocity.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
		velocity.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
		velocity = velocity.normalized()
		#Flipping of animation to run left as well. Sprite sheet limited
		if velocity != Vector2.ZERO:
			if velocity.x > 0:
				current_dir = "right"
				animationPlayer.play("runright")
				$AnimatedSprite2D.flip_h = false
			elif velocity.x <0 :
				current_dir = "left"
				animationPlayer.play("runleft")
				#$AnimatedSprite2D.flip_h = true
			elif velocity.y > 0:
				current_dir = "front"
				animationPlayer.play("runbottom")
			elif velocity.y < 0:
				current_dir = "back"
				animationPlayer.play("runtop")
			
			#For more natural movement to hit max speed and bringing it down for natural movement
			velocity = velocity.move_toward(velocity * MAX_SPEED, SPEED * delta)
		if velocity == Vector2.ZERO:
			if current_dir == "right":
				animationPlayer.play("idle_right")
			elif current_dir == "left":
				animationPlayer.play("idle_left")
			elif current_dir == "front":
				animationPlayer.play("idle_front")	
			elif current_dir == "back":
				animationPlayer.play("idle_back")
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		else:
			if timer.time_left <=0:
				foot_steps.pitch_scale= randf_range(0.8, 1.2)
				foot_steps.play()
				timer.start(0.30)
			
		
		#Moving and sliding the character
		move_and_slide()

func _on_dialogue_opened():
	dialoguecheck = true
	Global.is_player_frozen = true

func _on_dialogue_closed():
	dialoguecheck = false
	Global.is_player_frozen = false

func _on_input_closed():
	inputcheck = false

func _on_input_opened():
	print("on_input_opened")
	inputcheck = true

func _on_area_2d_body_entered(body):
	pass # Replace with function body.


func _on_area_2d_body_exited(body):
	pass # Replace with function body.

func _on_panel_closed():
	Global.is_player_frozen = false
