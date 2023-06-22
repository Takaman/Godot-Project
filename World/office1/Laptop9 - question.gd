extends Sprite2D


@onready var hud := $"/root/Office1/HUD"
func interact() -> void:
	print("interaction started")
	hud.show_dialog(
		"laptop9",
		{
			"$begin":
			Utils.dialog_part(
				"""
				It appears that you have left your laptop unlocked and unattended.
				
				[center][img=180x120]res://World/office1/images/Question/Unattended.jpg[/img][/center]
				<?[url=$change:correct]1) Oops, I forgot. Next time, I will definitely make sure to lock my laptop and keep an eye on it. [/url]?>
				<?[url=$nochange:wrong]2) I don't really care. I just leave it unattended and unlocked whenever I want. [/url]?>
				
				"""
			),
			"$change":
				Utils.dialog_part(
				"""
				Great, you have learnt a valuable lesson. It's important to prioritize the security of your personal information.
				<?[url=$end]EXIT[/url]?>
				"""
				),
			"$nochange":
				Utils.dialog_part(
				"""
				Bad choice. It's essential to understand that leaving your laptop unattended without supervision significantly increases the risk of unauthorized access and potential data breaches.
				<?[url=$end]EXIT[/url]?>
				"""
				),
		},
		"training"
	)
	
func _on_area_2d_area_entered(area):
	print("interactable!")
	if area.is_in_group("Player"):
		interact()
