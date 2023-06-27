extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func Back_on_button_pressed():
	SceneTransition.change_scene("res://menu/menu.tscn")

func Fullscreen_on_check_box_toggled(button_pressed):
	if button_pressed:
		DisplayServer.window_set_mode(3) # Set fullscreen
	else:
		DisplayServer.window_set_mode(0) # Set default mode


func borderless_on_check_box_2_toggled(button_pressed):
	if button_pressed:
		DisplayServer.window_set_mode(2) # 
	else:
		DisplayServer.window_set_mode(0) # Set default mode	 


func master_on_h_slider_value_changed(value):
	volume(0,value)
	
func volume(bus_index, value):
	if value == 0:
		AudioServer.set_bus_volume_db(bus_index, -80)
	else:
		var LinearVolume = value/70.0
		var dbVolume = LinearVolume * 80 - 80
		AudioServer.set_bus_volume_db(bus_index, dbVolume)

func mute_on_check_box_toggled(button_pressed):
	if button_pressed:
		AudioServer.set_bus_volume_db(0, -80)
	else:
		AudioServer.set_bus_volume_db(0, 0)


	
		

		
