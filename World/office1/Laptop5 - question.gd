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
				\
				[center][img=180x180]res://World/office1/images/Question/Windows11Update.jpg[/img][/center]
				<?[url=$change:correct]1) Yes, I'll download it right away. [/url]?>
				<?[url=$nochange:wrong]2) No,  I'm currently busy. I'll download it next time. [/url]?>
				
				"""
			),
			"$change":
				Utils.dialog_part(
				"""				
				Correct. It is a good practice to download the latest window features update. This update enhances security measures, ensuring a safer system environment.
				<?[url=$end]EXIT[/url]?>
				"""
				),
			"$nochange":
				Utils.dialog_part(
				"""
				That's not ideal. Without the latest Windows feature update, you become more vulnerable to data breaches, miss out on important bug fixes, new features, and risk encountering compatibility issues with software. It is strongly recommended to always keep your Windows up to date to ensure optimal security and functionality.
				<?[url=$end]EXIT[/url]?>
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
	interactable.visible  = !Score.has_interacted("laptop5","policy")
	
