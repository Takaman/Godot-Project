extends Sprite2D


@onready var hud := $"/root/Office1/HUD"
@onready var interactable := $"/root/Office1/QuestionmarkFolder/Interactable2"

func _ready():
	interactable.correct()
	interactable.visible = false
	pass

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
				
				[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$change:correct]Choose a suitable time to initiate the download [/url]?>[/right]
				
				[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$nochange:wrong]Ignore the update and choose a later time indefinitely. [/url]?>[/right]
				
				[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$nochange:correct]Initiate the download immediately. [/url]?>[/right]
				
				
				"""
			),
			"$change":
				Utils.dialog_part(
				"""
				Correct.
				
				It is a good practice to download the latest window features update.
				
				If you are currently working on something important or time-sensitive, 
				it might be better to choose a later time for the update, rather than distrupting your workflow.
				
				
				[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]EXIT[/url]?>[/right]
				"""
				),
			"$nochange":
				Utils.dialog_part(
				"""
				That's not ideal.
				
				Without the latest features/patches, you become more vulnerable to security breaches through your device.
				
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
		if Score.get_result("laptop5","policy") == 1:
			interactable.correct()
			interactable.visible  = true
		if Score.get_result("laptop5","policy") == 2:
			interactable.visible  = true
			interactable.reset()
