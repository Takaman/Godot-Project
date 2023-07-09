extends Sprite2D

@onready var hud := $"/root/house_internal_phishingemail/HUD"
@onready var marker := get_node("marker")

func _ready():
	marker.exclamation_mark()
	pass

func interact() -> void:
	if marker != null and marker is Node:
		marker.remove_mark()
	print("interaction started")
	hud.show_dialog(
		"Sam",
		{
			"$begin":
			Utils.dialog_part(
				"""
				[b]Sam[/b]
				Theres been a lot of phishing attacks nowadays, we all need to stay vigilant.
				
				[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$more]Can you tell me more about phishing?[/url]?>[/right]
				"""
			),
			"$more":
				Utils.dialog_part(
				"""
				[b]Sam[/b]
				Sure. Someone pretends to be a person you trust to trick you into revealing information or downloading a virus.
				
				[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end:correct]I see, thanks for the warning.[/url]?>[/right]
				"""
				),
		},
		"training"
	)

func interact_ontouch() -> void:
	print("ontouch started")
	hud.show_dialog(
		"Sam",
		{
			"$begin":
			Utils.dialog_part(
				"""
				[b]Sam[/b]
				Hey, we'd like your help to look through some emails we've been receiving.
				
				[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$next][right]Is there a problem?[/url]?>[/right]
				"""
			),
			"$next":
				Utils.dialog_part(
				"""
				[b]Sam[/b]
				Some of them seem kinda weird - someone might be trying to phish us!
				
				[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end][right]Alright, I'll help.[/url]?>[/right]
				"""
				),
		},
		"training"
	)

func _on_area_2d_area_entered(area):
	print("interactable!")
	if area.is_in_group("Player"):
		interact()

func _physics_process(delta: float) -> void:
	if Score.get_has_correct("Sam","training") == true:
		if marker != null and marker is Node:
				marker.visible = false
