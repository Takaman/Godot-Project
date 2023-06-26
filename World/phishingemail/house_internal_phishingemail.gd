extends TileMap

@onready var hud := $HUD

# Called when the node enters the scene tree for the first time.
func _ready():
	hud._close_panel()
	hud.close_player_input()
	pass # Replace with function body.
