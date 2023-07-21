extends TileMap

@onready var hud := $HUD

# Called when the node enters the scene tree for the first time.
func _ready():
	hud._close_panel()
	hud.close_player_input()
	
	if SeshVar._session:
		var username = SeshVar._session.get("username")
	else:
		SceneTransition.change_scene("res://../menu/Login.tscn")
