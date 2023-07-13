extends AnimatedSprite2D

# NPC movement variables
var speed = 15  # Adjust this value to control the NPC's speed
var target_positions = [Vector2(-163,-51),Vector2(-168,-20 ),Vector2(-70, -53)]  # Replace with your desired target positions
var current_target_index = 0

#@onready var hud := $"/root/FoodCourt/HUD"

# AnimatedSprite node reference
#@onready var animatedSprite = $FoodCourt/Movablecharacter/AnimatedSprite2D
@onready var animatedSprite := $"/root/FoodCourt/Movablecharacter/greyshirtguy"



func _process(delta):
	# NPC movement logic
	var velocity = Vector2.ZERO

	# Get the current target position
	var target_position = target_positions[current_target_index]

	# Determine the direction the NPC should move in (e.g., towards the target position)
	var direction = (target_position - position).normalized()
	velocity = direction * speed

	# Move the NPC
	position += velocity * delta

	# Check if the NPC has reached the target position
	if position.distance_to(target_position) < speed * delta:
		# Move to the next target position
		current_target_index += 1
		if current_target_index >= target_positions.size():
			current_target_index = 0

			# Check if the NPC has reached the last target position to close the loop
			if current_target_index == target_positions.size() - 1:
				if position.distance_to(target_positions[0]) < speed * delta:
					current_target_index = 0

	# Update the animation based on the NPC's movement
	if velocity.x > 0:
		animatedSprite.play("walkright")
	elif velocity.x < 0:
		animatedSprite.play("walkleft")
	else:
		animatedSprite.play("idle")
