extends Sprite2D


@onready var hud := $"/root/Office1/HUD"
@onready var interactable := $"/root/Office1/QuestionmarkFolder/Interactable2"
func interact() -> void:
	print("interaction started")
	hud.show_dialog(
		"laptop5",
		{
			"$begin":
			Utils.dialog_part(
				"""
				Important updates are pending. The newest Windows feature update is ready to install. Would you like to initiate the download now or choose a later time?
				
				[center][img=180x180]res://World/office1/images/Question/Windows11Update.jpg[/img][/center]
				[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$change:correct]Yes, I'll download it right away. [/url]?>[/right]
				[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$nochange:wrong]No,  I'm currently busy. I'll download it next time. [/url]?>[/right]
				
				"""
			),
			"$change":
				Utils.dialog_part(
				"""
				Correct. It is a good practice to download the latest window features update. This update enhances security measures, ensuring a safer system environment.
				[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]EXIT[/url]?>[/right]
				"""
				),
			"$nochange":
				Utils.dialog_part(
				"""
				That's not ideal. Without the latest Windows feature update, you become more vulnerable to data breaches, miss out on important bug fixes, new features, and risk encountering compatibility issues with software. It is strongly recommended to always keep your Windows up to date to ensure optimal security and functionality.
				[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]EXIT[/url]?>[/right]
				"""
				),
		},
		"policy"
	)
	
func _on_area_2d_area_entered(area):
	print("interactable!")
	if area.is_in_group("Player"):
		interact()

func _physics_process(delta: float) -> void:
	if interactable!= null and interactable is Node:
		interactable.visible  = !Score.get_has_correct("laptop5","policy")
