extends Node


var _session: NakamaSession
var company = "s"
var scheme = "s"
var nakama_port =0
var server_key = "s"
var api_svr = "s"
var host = "s"
	

# Called when the node enters the scene tree for the first time.
func _ready():
	print("Reading config...")
	var config = ConfigFile.new()
	var config_path = "res://confignew.cfg" 
	# Load the config file
	if config.load(config_path) == OK:
		# Read the values
		scheme = config.get_value("url", "scheme")
		nakama_port = config.get_value("url", "nakama_port")
		server_key = config.get_value("url", "server_key")
		api_svr = config.get_value("url", "api_svr")
		host = config.get_value("url","host")
		print("Retrieved from config:")
	
	else:
		print("Failed to load config file: ", config_path)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
