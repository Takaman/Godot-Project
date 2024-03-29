extends Node


func try_call(object: Object, method_name: String, args: Array = []):
	if object.has_method(method_name):
		return object.callv(method_name, args)


func choose_randomly(array: Array):
	if array.is_empty():
		return null

	return array[randi() % len(array)]


func at(array: Array, index: int, default = null):
	if len(array) > index:
		return array[index]
	else:
		return default


func dialog_part(text: String) -> String:
	
	#Bolding 
	text = text.replace("<b>", "[b]")
	text = text.replace("</b>", "[/b]")
	
	#Red colour
	text = text.replace("<!", "[color=#d00]")
	text = text.replace("!>", "[/color]")
	
	#Blue colour 
	text = text.replace("<?", "[color=#194afc]")
	text = text.replace("?>", "[/color]")
	
	#Orange Colour
	text = text.replace("<#", "[color=#e48400]")
	text = text.replace("#>", "[/color]")
	
	#Green colour and wave effect
	text = text.replace("<~", "[color=#2e8b57][wave]")
	text = text.replace("~>", "[/wave][/color]")

	text = text.dedent()
	text = text.strip_edges()
	
	return text
