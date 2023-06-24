extends Sprite2D


@onready var hud := $"/root/house_internal2/HUD"

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
				
				<?[url=$leave:wrong]1) Leave it as it is, its the responsibility of the person who left it[/url]?>
				<?[url=$report:correct]2) Keep the financial documents at a secure private location and report this incident to management. [/url]?>
				
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
				<?[url=$end]EXIT[/url]?>
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
