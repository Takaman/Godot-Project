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
				There is a QR code conveniently attached to do a survey to redeem a free drink!
				You are asked to download and install an APK to do the survey to redeem.
				
				[center][img=50x50]res://World/Actors/Poster/frame.png[/img][/center]
				
				<?[url=$no:correct]1) No, Stop the download and exit the site [/url]?>
				<?[url=$yes:wrong]2) Yes, Quickly install the app and accept the invitation. [/url]?>
				"""
			),
			"$yes":
			Utils.dialog_part(
				"""
				Installing..... You have just downloaded and installed a <!MALWARE!!>>
				
				Hackers are now leveraging on such tactics to takeover devices and potentially steal banking information
				Be very careful when you scan on QR codes. 
				
				To learn more, please click on the link
				
				[center]<#[url=https://www.straitstimes.com/tech/can-i-trust-this-qr-code-csa-police-issue-alert-on-qr-code-scams-and-how-to-avoid-being-tricked]Click here to learn more.[/url]#>[/center]
				
				<?[url=$end]EXIT[/url]?>
				"""
				
			),
			"$no":
			Utils.dialog_part(
				"""
				Exited the download... You have succesfully avoided installing a malicious APP!
				
								
				Hackers are now leveraging on such tactics to takeover devices and potentially steal banking information
				Be very careful when you scan on QR codes. 
				
				To learn more, please click on the link
				
				[center]<#[url=https://www.straitstimes.com/tech/can-i-trust-this-qr-code-csa-police-issue-alert-on-qr-code-scams-and-how-to-avoid-being-tricked]Click here to learn more.[/url]#>[/center]
				
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
