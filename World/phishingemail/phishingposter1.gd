extends CharacterBody2D

@onready var hud := $"/root/house_internal_phishingemail/HUD"

func interact() -> void:
	print("interaction started")
	hud.show_dialog(
		"phishingposter1",
		{
			"$begin":
			Utils.dialog_part(
				"""
				[center]
				[b]Phishing Information![/b]
				[b]Links[/b]
				
				Links are <!DANGEROUS!>!
				Watch out for shortened links like bit.ly or tinyurl.
				Make sure the URL of the website is CORRECT before typing anything.
				
				[/center]
				[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]Leave.[/url]?>[/right]
				"""
			),
		},
		"training"
	)
