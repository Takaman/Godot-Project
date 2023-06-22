extends Sprite2D



@onready var hud := $"/root/Office1/HUD"
func interact() -> void:
	print("interaction started")
	hud.show_dialog(
		"laptop5",
		{
			"$begin":
			Utils.dialog_part(
				"""
				It seems you have a weak password. It is crucial to have a strong and secure password to protect your accounts. 
				Would you like assistance in creating a stronger password?
				
				<?[url=$change:correct]1) Yes, please help me create a stronger password. [/url]?>
				<?[url=$nochange:wrong]2) No thanks, I think my password is fine. [/url]?>
				
				"""
			),
			"$change":
				Utils.dialog_part(
				"""
				Good choice!!! Let's work on creating a robust password that combines a mix of uppercase and lowercase letters, numbers, and special characters. 
				This will significantly enhance the security of your accounts.
				<?[url=$end]EXIT[/url]?>
				"""
				),
			"$nochange":
				Utils.dialog_part(
				"""
				Bad idea!!! It's important to understand that a weak password can make your accounts vulnerable to unauthorized access. I strongly advise reconsidering and updating your password to ensure the highest level of security for your accounts.
				<?[url=$end]EXIT[/url]?>
				"""
				),
		},
		"training"
	)
	
func _on_area_2d_area_entered(area):
	print("interactable!")
	if area.is_in_group("Player"):
		interact()
