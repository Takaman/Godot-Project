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
						
						Lately, I've been getting these annoying random popups on my computer. Do you know what's wrong?
						
						[center][img=100x100]res://World/office1/images/Question/adware.png[/img][/center]
						
						[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$help]Did you install anything lately?[/url]?>[/right]
						
						[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$nohelp:wrong]Ignore it and it might go away after some time.[/url]?>[/right]
						"""
					),
					"$help":
						Utils.dialog_part(
							"""
							[b]Emily[/b]
							
							Yes! I installed this third party toolbar and it's really useful for translation!
							
							
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$nohelp2:wrong]Looks like you installed some kind of Adware. Uninstalling the toolbar might solve the issue.[/url]?>[/right]
							
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$help2:correct]Looks like you installed some kind of Adware. Let's immediately report this matter.[/url]?>[/right]
							"""
							
						),
					"$nohelp":
						Utils.dialog_part(
							"""
							[b]Emily[/b]
							
							Okay, then can I request a new computer from the IT department? This computer must be broken!
							
							
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]Perhaps I should reconsider the issue...[/url]?>[/right]
							"""
						),
					"$nohelp2":
						Utils.dialog_part(
							"""
							That is wrong
							
							Avoid solving the matter on your own as it might lead to unintended consequences!
							
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]Perhaps I should reconsider the issue...[/url]?>[/right]
							"""
						),
					"$help2":
						Utils.dialog_part(
							"""
							[b]Emily[/b]
							
							I think that is the right procedure to do so! Thanks a lot for your help!
							
							[center]Be careful when installing third party tools.[/center]
							
							[center]<#[url=https://www.kaspersky.com/resource-center/threats/adware] Click here to learn more.[/url]#>[/center]
							
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]EXIT[/url]?>[/right]
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
	
