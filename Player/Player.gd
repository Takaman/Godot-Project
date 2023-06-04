extends CharacterBody2D

#Constant values for movement and physics
const SPEED = 5000
const MAX_SPEED = 100
const FRICTION = 350
const JUMP_VELOCITY = -400.0


var gravity = ProjectSettings.get_setting("physics/2d/default_gravity");
#Needs the ready function to instantiate the animationPlayer. Need to get access to the node of your child
@onready var animationPlayer = get_node("AnimatedSprite2D")

func _physics_process(delta):
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
