extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if DisplayServer.window_get_mode() == 3:
		$VBoxContainer2/FullScreen.button_pressed = true
	if DisplayServer.window_get_mode() == 0:
		$VBoxContainer2/FullScreen.button_pressed = false
	if DisplayServer.window_get_mode() == 2:
		$VBoxContainer2/CheckBox2.button_pressed = true
	if DisplayServer.window_get_mode() == 0:
		$VBoxContainer2/CheckBox2.button_pressed = false

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

func _on_volume_slider_value_changed(value):
	AudioServer.set_bus_volume_db(0, linear_to_db(value))
