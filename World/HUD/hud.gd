extends CanvasLayer


@onready var dialogue_big := $Control/DialogueBig
@onready var dialogue_big_label := $Control/DialogueBig/RichTextLabel
@onready var dialogue_big_timer := $Control/DialogueBig/Timer
@onready var dialogue_small := $Control/DialogueSmall
@onready var dialogue_small_label := $Control/DialogueSmall/RichTextLabel
@onready var dialogue_small_timer := $Control/DialogueSmall/Timer

@onready var player_input := $Control/PlayerInput

@onready var sound_default := $sounddefault
@onready var sound_correct := $soundcorrect
@onready var sound_wrong := $soundwrong

const BOTTOM_PANEL_INSIDE_Y := 230
const BOTTOM_PANEL_OUTSIDE_Y := 500
const BOTTOM_PANEL_SLIDE_DURATION := 0.5

signal dialogue_opened
signal dialogue_closed
signal input_opened
signal input_closed
signal input_submitted
signal correct
signal wrong
signal partsignaller
var dialogue_content := {}
var dialogue_interaction := ""
var dialogue_phase := ""
var is_dialoguesmall_visible := false
var player_input_text : String = ""
var part_name : String = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("HUD_Group")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event: InputEvent) -> void:
	if event.is_action("ui_cancel") and is_interacting():
		_close_panel()
		get_viewport().set_input_as_handled()


func _handle_interaction(sound: String = "") -> void:
	match sound:
		"correct":
			sound_correct.play()
			emit_signal("correct")
		"wrong":
			sound_wrong.play()
			emit_signal("wrong")
		_:
			sound_default.play()

func _close_panel() -> void:
	dialogue_content = {}
	part_name = ""
	dialogue_big.hide()
	print("emit signals")
	dialogue_big.visible = false
	emit_signal("dialogue_closed")

func _next_panel_part(part: String) -> void:
	if part == "$end":
		part_name = ""
		_close_panel()
		return

	if not dialogue_content.has(part):
		push_error("Panel content does not have part '%s'" % part)
		_close_panel()
		return
	
	part_name = part
	print(part_name)
	emit_signal("partsignaller")
	dialogue_big_label.text = dialogue_content[part]
	dialogue_big_label.visible_characters = 0
	dialogue_big_timer.start()

func _slide_panel_out() -> void:
	for i in range(100):
		call_deferred("_move_panel", Vector2(0, i * 5))

func _on_rich_text_label_meta_clicked(meta):
	meta = str(meta)
	
	if not meta.begins_with("$"):
		OS.shell_open(meta)
		return
		
	var parts = meta.split(":")
	var interaction_result = Utils.at(parts, 1, "default")
	_handle_interaction(Utils.at(parts, 1, "default"))
	_next_panel_part(parts[0])
	
	#Updating the results of the interaction
	Score.new_interaction(dialogue_interaction, interaction_result, dialogue_phase)
	
	#Marking interaction as completed
	Score.mark_as_completed(dialogue_interaction, dialogue_phase)
	

func _on_timer_timeout():
	if dialogue_big_label.visible_characters == dialogue_big_label.text.length():
		dialogue_big_timer.stop()
	else:
		dialogue_big_label.visible_characters += 1



func is_interacting() -> bool:
	return dialogue_big.visible


func show_dialog(interaction: String, content: Dictionary, phase: String) -> void:
	if not content.has("$begin"):
		push_error("Need to start with $begin" % interaction)
		return
	
	Score.new_interaction(interaction, "", phase)
	dialogue_interaction = interaction
	dialogue_content = content
	dialogue_phase = phase
	_next_panel_part("$begin")
	dialogue_big.visible = true
	dialogue_big.show()
	emit_signal("dialogue_opened")

func show_player_input() -> void:
	print("showing input box")
	emit_signal("input_opened")
	player_input.visible = true
	player_input.show()

func close_player_input() -> void:
	player_input.clear()
	player_input_text = ""
	player_input.hide()
	print("emit signals")
	player_input.visible = false

func _on_player_input_text_submitted(new_text):
	player_input_text = new_text
	emit_signal("input_submitted")
	emit_signal("input_closed")
