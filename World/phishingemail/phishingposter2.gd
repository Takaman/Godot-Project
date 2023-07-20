extends CharacterBody2D

@onready var hud := $"/root/house_internal_phishingemail/HUD"

func interact() -> void:
	print("interaction started")
	hud.show_dialog(
		"phishingposter2",
		{
			"$begin":
			Utils.dialog_part(
				"""
				[center]
				[b]Phishing Information![/b]
				[b]Sender[/b]
				
				Sender emails are <!IMPORTANT!>!
				Watch out for differently spelt addresses.
				Companies DO NOT use public email domains*.
				
				*[i]@gmail.com, @yahoo.com etc.[/i]
				
				[/center]
				[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]Leave.[/url]?>[/right]
				"""
			),
		},
		"training"
	)
