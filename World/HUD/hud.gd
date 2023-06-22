extends CanvasLayer


@onready var dialogue_big := $Control/DialogueBig
@onready var dialogue_big_label := $Control/DialogueBig/RichTextLabel
@onready var dialogue_big_timer := $Control/DialogueBig/Timer
@onready var dialogue_small := $Control/DialogueSmall
@onready var dialogue_small_label := $Control/DialogueSmall/RichTextLabel
@onready var dialogue_small_timer := $Control/DialogueSmall/Timer

@onready var sound_default := $sounddefault
@onready var sound_correct := $soundcorrect
@onready var sound_wrong := $soundwrong

const BOTTOM_PANEL_INSIDE_Y := 230
const BOTTOM_PANEL_OUTSIDE_Y := 500
const BOTTOM_PANEL_SLIDE_DURATION := 0.5

signal dialogue_closed
var dialogue_content := {}
var is_dialoguesmall_visible := false

# Called when the node enters the scene tree for the first time.
func _ready():
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
		"wrong":
			sound_wrong.play()
		_:
			sound_default.play()

func _close_panel() -> void:
	dialogue_content = {}
	dialogue_big.hide()
	print("emit signals")
	emit_signal("dialogue_closed")

func _next_panel_part(part: String) -> void:
	if part == "$end":
		_close_panel()
		return

	if not dialogue_content.has(part):
		push_error("Panel content does not have part '%s'" % part)
		_close_panel()
		return

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
	_handle_interaction(Utils.at(parts, 1, "default"))
	_next_panel_part(parts[0])

func _on_timer_timeout():
	if dialogue_big_label.visible_characters == dialogue_big_label.text.length():
		dialogue_big_timer.stop()
	else:
		dialogue_big_label.visible_characters += 1



func is_interacting() -> bool:
	return dialogue_big.visible


func show_dialog(interaction: String, content: Dictionary, phase: String) -> void:
	if not content.has("$begin"):
		push_error("Panel content for %s must have a beginning" % interaction)
		return

	Score.new_interaction(interaction, "", phase)
	dialogue_content = content
	_next_panel_part("$begin")
	dialogue_big.show()
