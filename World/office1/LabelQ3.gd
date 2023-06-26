extends Label


func _input(event: InputEvent):
	if event is InputEventKey and not event.is_pressed():
		var typed_event = event as InputEventKey
		var key_text = PackedByteArray([typed_event.unicode]).get_string_from_utf8()
		print(key_text)
		if key_text == "BackSpace":
			var new_text = $Label.text
			new_text.erase($Label.text.length()-1,1)
			$Label.text = new_text
		elif key_text == "Space":
			$Label.text += " "
		elif key_text == "Enter":
			$Label.text += "\n"
		else:
			$Label.text += key_text

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
