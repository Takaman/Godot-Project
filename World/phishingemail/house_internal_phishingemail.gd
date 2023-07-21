extends TileMap

@onready var hud := $HUD
@onready var sessionVar = get_node("/root/Seshvar")

# Called when the node enters the scene tree for the first time.
func _ready():
	hud._close_panel()
	hud.close_player_input()
	
	if sessionVar._session:
		var username = sessionVar._session.get("username")
	else:
		SceneTransition.change_scene("res://../menu/Login.tscn")
	pass # Replace with function body.
