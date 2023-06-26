extends Sprite2D


@onready var hud := $"/root/Office1/HUD"
@onready var interactable := $"/root/Office1/QuestionmarkFolder/Interactable5"

func interact() -> void:
	print("interaction started")
	hud.show_dialog(
		"thumbdrive1",
		{
			"$begin":
			Utils.dialog_part(
				"""
				You have found a thumbdrive lying around! What should you do next?
				
				[center][img=50x50]res://World/Actors/Thumbdrive/thumdrive.jpg[/img][/center]
				
				<?[url=$insert:wrong]1) Insert into your computer and check whose the owner[/url]?>
				<?[url=$pass:correct]2) Pass the thumbdrive to the IT security team[/url]?>
				
				"""
			),
			"$insert":
				Utils.dialog_part(
				"""
				Inserting thumbdrive........ <! Your Computer has been compromised! !>
				
				USB drives can carry malware, which can infect your computer when plugged in. Always make sure you know where a thumbdrive comes from before using it
				
				This attack is known as "USB drop attacks". 
				
				To learn more visit this link.
				[center]<#[url=https://www.redteamsecure.com/blog/usb-drop-attacks-the-danger-of-lost-and-found-thumb-drives]Click here to learn more. [/url]#>[/center]
				
				<?[url=$end]EXIT[/url]?>
				"""
				),
			"$pass":
				Utils.dialog_part(
				"""
				Excellent choice! You have avoided potential malware infection by not plugging an unknown thumbdrive into your computer. 
				
				Remember, USB drives can carry malware. Always make sure you know where a thumbdrive comes from before using it. When in doubt, consult with your IT security team
				
				To learn more visit this link.
				[center]<#[url=https://www.redteamsecure.com/blog/usb-drop-attacks-the-danger-of-lost-and-found-thumb-drives]Click here to learn more. [/url]#>[/center]
				
				<?[url=$end]EXIT[/url]?>
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
	interactable.visible  = !Score.has_interacted("thumbdrive1","socialengineering")
