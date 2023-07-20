extends CanvasLayer

# Assuming PanelHUD has similar structure as HUD
@onready var panel_big := $Control/DialogueBig
@onready var panel_big_label := $Control/DialogueBig/RichTextLabel
@onready var close_button := $Control/DialogueBig/CloseButton
@onready var leaderboard_table := $Control/DialogueBig/ScrollContainer/GridContainer


# Signals
signal panel_opened
signal panel_closed

var panel_content := {}
var panel_interaction := ""
var panel_phase := ""

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("PanelHUD_Group")
	close_button.connect("pressed",Callable(self,"_close_panel"))



func _input(event: InputEvent) -> void:
	if event.is_action("ui_cancel") and is_interacting():
		_close_panel()
		get_viewport().set_input_as_handled()

func _close_panel() -> void:
	panel_content = {}
	panel_big.hide()
	emit_signal("panel_closed")

func _next_panel_part(part: String) -> void:
	if part == "$end":
		_close_panel()
		return

	if not panel_content.has(part):
		push_error("Panel content does not have part '%s'" % part)
		_close_panel()
		return

	panel_big_label.text = panel_content[part]
	panel_big_label.visible_characters = panel_big_label.text.length()
	# Add more logic here as needed

func _on_rich_text_label_meta_clicked(meta):
	meta = str(meta)

	if not meta.begins_with("$"):
		OS.shell_open(meta)
		return

	var parts = meta.split(":")
	var interaction_result = Utils.at(parts, 1, "default")
	# _handle_interaction(Utils.at(parts, 1, "default"))
	_next_panel_part(parts[0])

func is_interacting() -> bool:
	return panel_big.visible

func show_panel(interaction: String, content: Dictionary, phase: String) -> void:
	if not content.has("$begin"):
		push_error("Need to start with $begin" % interaction)
		return
	panel_interaction = interaction
	panel_content = content
	panel_phase = phase
	_next_panel_part("$begin")
	panel_big.visible = true
	emit_signal("panel_opened")
	
func update_leaderboard(data):
	var my_font = preload("res://frames/Dialog/Font/NormalFont.ttf")
	# Clear the leaderboard
	for child in leaderboard_table.get_children():
		child.queue_free()

	# Add header
	var rank_header = Label.new()
	rank_header.text = "Rank"
	rank_header.add_theme_font_override("font", my_font)
	rank_header.add_theme_font_size_override("font_size",11)
	leaderboard_table.add_child(rank_header)
	
	var username_header = Label.new()
	username_header.text = "Username"
	username_header.add_theme_font_override("font",my_font)
	username_header.add_theme_font_size_override("font_size",11)
	leaderboard_table.add_child(username_header)

	var score_header = Label.new()
	score_header.text = "Score"
	score_header.add_theme_font_override("font",my_font)
	score_header.add_theme_font_size_override("font_size",11)
	leaderboard_table.add_child(score_header)

	# Add data
	var rank = 1
	for entry in data:
		var score = round(float(entry[2]) * 100.0) / 100.0 
	
		var rank_label = Label.new()
		rank_label.text = str(rank)
		rank_label.add_theme_font_size_override("font_size",11)
		leaderboard_table.add_child(rank_label)

		var username_label = Label.new()
		username_label.text = entry[1]
		username_label.add_theme_font_size_override("font_size",11)
		leaderboard_table.add_child(username_label)

		var score_label = Label.new()
		score_label.text = str(score)
		score_label.add_theme_font_size_override("font_size",11)
		leaderboard_table.add_child(score_label)

		rank += 1

