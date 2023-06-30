extends Sprite2D

@onready var hud := $"/root/Office1/HUD"
@onready var interactable := $"/root/Office1/QuestionmarkFolder/Interactable7"
@onready var state = 0
@onready var password : String = ""

func interact() -> void:
	print("interaction started")
	if state == 0:
		hud.show_dialog(
			"laptop16",
			{
				"$begin":
					Utils.dialog_part(
						"""
						[b]Alice[/b]
						I've lately been getting these annoying random popups on my windows. What is wrong?
						
						[center][img=100x100]res://World/office1/images/Question/adware.png[/img][/center]
						
						<?[url=$help:correct][right]1) Did you install anything lately? Such as browser extensions etc[/right][/url]?>
						
						<?[url=$nohelp:wrong][right]2) Ignore it and it will go away after some time.[/right][/url]?>
						"""
					),
					"$help":
						Utils.dialog_part(
							"""
							[b]Alice[/b]
							Yes! I've installed this third party toolbar and its really useful for my to translate my items!
							
							
							<?[url=$help2][right] It might be a common malware called "Adware" Uninstall the toolbar immediately and run a virus scan on your computer[/right][/url]?>
							"""
							
						),
					"$nohelp":
						Utils.dialog_part(
							"""
							[b]Alice[/b]
							Okay, then can I request a new computer from the IT department? This PC must be spoiled!
							
							
							<?[url=$end][right]Perhaps I should rethink on how to solve the issue for her.[/right][/url]?>
							"""
						),
					"$help2":
						Utils.dialog_part(
							"""
							[b]Alice[/b]
							Wow, that seemed to work! The ads are no longer randomly appearing on my screen! Thanks alot for your help
							
							
							[right]That's right, be careful when installing third party tools. Click on the link to find out more![/right]
							
							[center]<#[url=https://www.kaspersky.com/resource-center/threats/adware] Click here to learn more.[/url]#>[/center]
							
							<?[url=$end][right]Exit[/right][/url]?>
							"""
						)
				
			},
			"malware",
			)
			
func _on_area_2d_area_entered(area):
	print("interactable!")
	if area.is_in_group("Player"):
		interact()

func _physics_process(delta: float) -> void:
	interactable.visible  = !Score.has_interacted("laptop16","malware")
	
