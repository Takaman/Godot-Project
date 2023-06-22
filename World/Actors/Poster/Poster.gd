extends CharacterBody2D

@onready var hud := $"/root/Base_Map/HUD"

signal dialogue_closed

func interact() -> void:
	print("interaction started")
	hud.show_dialog(
		"poster1",
		{
			"$begin":
			Utils.dialog_part(
				"""
				There is a QR code convenient attached to accept the invitation. 
				You are asked to download and install an APK to redeem.
				
				[center][img=50x50]res://World/Actors/Poster/frame.png[/img][/center]
				
				<?[url=$no:correct]1) No, Stop the download. [/url]?>
				<?[url=$yes:wrong]2) Yes, Quickly install the app and accept the invitation. [/url]?>
				"""
			),
			"$yes":
			Utils.dialog_part(
				"""
				Installing..... You have just downloaded <!scam website!!>>
				
				<?[url=$end]CONTINUE[/url]?>
				"""
				
			),
			"$no":
			Utils.dialog_part(
				"""
				You are correct. Dont believe QR codes!
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


func _on_area_2d_area_exited(area):
	pass # Replace with function body.
