extends Node2D

const BOUNCE_MAGNITUDE := 2
const BOUNCE_SPEED_MULTIPLIER := 8
var _delta := 0.0

@onready var sprite = $Sprite2D

func _physics_process(delta: float) -> void:
	_delta += delta
	sprite.position.y = sin(_delta * BOUNCE_SPEED_MULTIPLIER) * BOUNCE_MAGNITUDE

func exclamation_mark() -> void:
	if get_node("Sprite2D") is Node:
		get_node("Sprite2D").texture = load("res://World/Actors/IsInteractable/exclamation_mark.png")
		
func correct() -> void:
	if get_node("Sprite2D") is Node:
		get_node("Sprite2D").texture = load("res://World/Actors/IsInteractable/correct.png")
		
func wrong() -> void:
	if get_node("Sprite2D") is Node:
		get_node("Sprite2D").texture = load("res://World/Actors/IsInteractable/wrong.png")
		
func reset() -> void:
	if get_node("Sprite2D") is Node:
		get_node("Sprite2D").texture = load("res://World/Actors/IsInteractable/interactabletest.png")
		
func in_progress() -> void:
	if get_node("Sprite2D") is Node:
		get_node("Sprite2D").texture = load("res://World/Actors/IsInteractable/in_prog.png")

func remove_mark() -> void:
	if self is Node:
		self.queue_free()

func toggle_visibility(vis: bool) -> void:
	if get_node("Sprite2D") is Node:
		if vis == true:
			self.visible = true
		elif vis == false:
			self.visible = false
