extends Sprite2D


@onready var hud := $"/root/Office1/HUD"
@onready var interactable := $"/root/Office1/QuestionmarkFolder/Interactable5"

func _ready():
	#interactable.reset()
	interactable.correct()
	interactable.visible  = false
	pass
	
func interact() -> void:
	print("interaction started")
	hud.show_dialog(
		"thumbdrive1",
		{
			"$begin":
			Utils.dialog_part(
				"""
				You found a thumbdrive.
				
				[center][img=50x50]res://World/Actors/Thumbdrive/thumdrive.jpg[/img][/center]
				
				[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$ignore:wrong]I'll ignore it and leave it where it is.[/url]?>[/right]
				[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$insert:wrong]I'll insert it into my computer and check who the owner is.[/url]?>[/right]
				[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$pass:correct]I'll pass the thumbdrive to the IT team.[/url]?>[/right]
				"""
			),
			"$ignore":
				Utils.dialog_part(
				"""
				I shoudn't just leave equipment lying around...
				
				[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]Exit[/url]?>[/right]
				"""
				),
			"$insert":
				Utils.dialog_part(
				"""
				Inserting thumbdrive........ <! Your Computer has been compromised! !>
				
				USB drives can carry malware, which can infect your computer when plugged in.
				
				Always make sure you know where a thumbdrive comes from before using it.
				
				This attack is known as a "USB drop attack". 
				
				Visit this link to learn more.
				[center]<#[url=https://www.redteamsecure.com/blog/usb-drop-attacks-the-danger-of-lost-and-found-thumb-drives]Click here to learn more. [/url]#>[/center]
				
				[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]Exit[/url]?>[/right]
				"""
				),
			"$pass":
				Utils.dialog_part(
				"""
				Excellent choice!
				
				Remember, USB drives can carry malware. 
				
				Always make sure you know where a thumbdrive comes from before using it. If in doubt, consult your IT team.
				
				Visit this link to learn more.
				[center]<#[url=https://www.redteamsecure.com/blog/usb-drop-attacks-the-danger-of-lost-and-found-thumb-drives]Click here to learn more. [/url]#>[/center]
				
				[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]Exit[/url]?>[/right]
				"""
				),
		},
		"socialengineering"
	)
	
func _on_area_2d_area_entered(area):
	print("interactable!")
	if area.is_in_group("Player"):
		interact()
		

func _physics_process(delta: float) -> void:
	if interactable!= null and interactable is Node:
		if Score.get_result("thumbdrive1","socialengineering") == 1:
			interactable.correct()
			interactable.visible  = true
		if Score.get_result("thumbdrive1","socialengineering") == 2:
			interactable.visible  = true
			interactable.reset()
