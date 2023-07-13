extends Sprite2D

@onready var hud := $"/root/Office1/HUD"
@onready var interactable := $"/root/Office1/QuestionmarkFolder/Interactable6"

func _ready():
	interactable.correct()
	pass
	
func interact() -> void:
	print("interaction started")
	hud.show_dialog(
		"messyarea1",
		{
			"$begin":
			Utils.dialog_part(
				"""
				The table is <! really messy! !> There are food, drinks and documents all over the place!
				There are also some confidential finance documents on display. 
				
				What should you do?
				
				[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$leave:wrong]Leave it as it is, its the responsibility of the person who left it[/url]?>[/right]
				[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$report:correct]Keep the financial documents at a secure private location and report this incident to management. [/url]?>[/right]
				
				"""
			),
			"$leave":
				Utils.dialog_part(
				"""
				You decide to leave the desk as it is. However, a clean desk policy is crucial in preventing security breaches. 
				This policy ensures that all important documents and confidential letters are removed from a desk and locked away when not in use or when an employee leaves their workstation.
				Ignoring this can result in unauthorized access to the company’s information or client data
				
				
				To learn more about clean desk policy, visit this link.
				[center]<#[url=https://blog.usecure.io/what-is-a-clean-desk-policy-and-should-my-company-have-it]Click here to learn more. [/url]#>[/center]
				[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]EXIT[/url]?>[/right]
				"""
				),
			"$report":
				Utils.dialog_part(
				"""
				Good decision! You keep the financial documents at a secure private location and decide to report the incident to management. 
				This action aligns with the clean desk policy, which is one of the strategies to reduce the risk of security breaches. 
				It helps your company comply with industry standards of protecting important data and reduces the chance of unauthorized access to confidential information
				
				To learn more about clean desk policy, please visit this link.
				[center]<#[url=https://blog.usecure.io/what-is-a-clean-desk-policy-and-should-my-company-have-it]Click here to learn more. [/url]#>[/center]
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
		interactable.visible  = Score.get_has_correct("messyarea1","policy")
	
