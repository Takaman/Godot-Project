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
				
				[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$address]What's the email domain this company uses?[/url]?>[/right]
				[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end:correct]I see, thanks for the warning.[/url]?>[/right]
				"""
				),
			"$address":
				Utils.dialog_part(
				"""
				[b]Sam[/b]
				
				Our company's email domain is @itpgrp11.com. 
				
				[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end:correct]I see, thanks for the info.[/url]?>[/right]
				"""
			)
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
				
				Welcome to the finance department! We'd like your help to look through some emails we've been receiving.
				
				[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$next]Is there a problem?[/url]?>[/right]
				"""
			),
			"$next":
				Utils.dialog_part(
				"""
				[b]Sam[/b]
				
				We've been receiving a lot of strange emails lately. I have a feeling a number of them are phishing emails.
				
				[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]Alright, I'll help.[/url]?>[/right]
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
