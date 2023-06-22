extends Sprite2D

@onready var hud := $"/root/house_internal_phishingemail/HUD"

func interact() -> void:
	get_node("marker").queue_free()
	print("interaction started")
	hud.show_dialog(
		"Sam",
		{
			"$begin":
			Utils.dialog_part(
				"""
				Sam: Theres been a lot of phishing attacks nowadays, we all need to stay vigilant.
				
				<?[url=$more]Can you tell me more about phishing? [/url]?>
				<?[url=$end]I see, thanks for the warning. [/url]?>
				"""
			),
			"$more":
				Utils.dialog_part(
				"""
				Sam: Sure. Someone pretends to be a person you trust to trick you into revealing information or downloading a virus.
				
				<?[url=$end]I see, thanks for the warning.[/url]?>
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
				Sam: Hey, we'd like your help to look through some emails we've been receiving.
				
				<?[url=$next]Is there a problem?[/url]?>
				"""
			),
			"$next":
				Utils.dialog_part(
				"""
				Sam: Some of them seem kinda weird - someone might be trying to phish us!
				
				<?[url=$end]Alright, I'll help.[/url]?>
				"""
				),
		},
		"training"
	)

func _on_area_2d_area_entered(area):
	print("interactable!")
	if area.is_in_group("Player"):
		interact()
