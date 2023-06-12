extends Node2D

#Instantiate variables for loading. Should be done in every map 
@onready var HeartsContainer = $CanvasLayer/HeartBoxContainer
@onready var player = $Player
# Called when the node enters the scene tree for the first time.
func _ready():
	HeartsContainer.setMaxHearts(player.maxHealth)
	HeartsContainer.updateHearts(player.currentHealth)
	player.healthChanged.connect(HeartsContainer.updateHearts)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
