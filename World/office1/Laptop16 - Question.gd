extends Sprite2D

@onready var hud := $"/root/Office1/HUD"
@onready var interactable := $"/root/Office1/QuestionmarkFolder/Interactable7"
@onready var state = 0
@onready var password : String = ""

func _ready():
	interactable.correct()
	interactable.visible = false
	pass

func interact() -> void:
	print("interaction started")
	if state == 0:
		hud.show_dialog(
			"laptop16",
			{
				"$begin":
					Utils.dialog_part(
						"""
						[b]Emily[/b]
						
						I've lately been getting these annoying random popups on my windows. What is wrong?
						
						[center][img=100x100]res://World/office1/images/Question/adware.png[/img][/center]
						
						[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$help:correct]Did you install anything lately? Such as browser extensions etc[/url]?>[/right]
						
						[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$nohelp:wrong]Ignore it and it will go away after some time.[/url]?>[/right]
						"""
					),
					"$help":
						Utils.dialog_part(
							"""
							[b]Emily[/b]
							
							Yes! I've installed this third party toolbar and its really useful for my to translate my items!
							
							
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$help2]It might be a common malware called "Adware". Uninstall the toolbar immediately.[/url]?>[/right]
							"""
							
						),
					"$nohelp":
						Utils.dialog_part(
							"""
							[b]Emily[/b]
							
							Okay, then can I request a new computer from the IT department? This PC must be spoiled!
							
							
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]Perhaps I should rethink on how to solve the issue for her.[/url]?>[/right]
							"""
						),
					"$help2":
						Utils.dialog_part(
							"""
							[b]Emily[/b]
							
							Wow, that seemed to work! The ads are no longer randomly appearing on my screen! Thanks alot for your help
							
							
							[center]That's right, be careful when installing third party tools.[/center]
							
							[center]<#[url=https://www.kaspersky.com/resource-center/threats/adware] Click here to learn more.[/url]#>[/center]
							
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]Exit[/url]?>[/right]
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
	if interactable!= null and interactable is Node:
		if Score.get_result("laptop16","malware") == 1:
			interactable.correct()
			interactable.visible  = true
		if Score.get_result("laptop16","malware") == 2:
			interactable.visible  = true
			interactable.reset()
	
