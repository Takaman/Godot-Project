extends Sprite2D

@onready var hud := $"/root/house_internal_phishingemail/HUD"
@onready var marker := get_node("marker")

func _ready():
	marker.exclamation_mark()
	pass

func interact() -> void:
	if marker is Node:
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
				
				<?[url=$more][right]Can you tell me more about phishing?[/right][/url]?>
				<?[url=$end][right]I see, thanks for the warning.[/right][/url]?>
				"""
			),
			"$more":
				Utils.dialog_part(
				"""
				[b]Sam[/b]
				Sure. Someone pretends to be a person you trust to trick you into revealing information or downloading a virus.
				
				<?[url=$end][right]I see, thanks for the warning.[/right][/url]?>
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
				
				<?[url=$next][right]Is there a problem?[/right][/url]?>
				"""
			),
			"$next":
				Utils.dialog_part(
				"""
				[b]Sam[/b]
				Some of them seem kinda weird - someone might be trying to phish us!
				
				<?[url=$end][right]Alright, I'll help.[/right][/url]?>
				"""
				),
		},
		"training"
	)

func _on_area_2d_area_entered(area):
	print("interactable!")
	if area.is_in_group("Player"):
		interact()
