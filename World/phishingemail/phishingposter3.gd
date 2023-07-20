extends CharacterBody2D

@onready var hud := $"/root/house_internal_phishingemail/HUD"

func interact() -> void:
	print("interaction started")
	hud.show_dialog(
		"phishingposter3",
		{
			"$begin":
			Utils.dialog_part(
				"""
				[center]
				[b]Phishing Information![/b]
				[b]Urgency[/b]
				
				Phishing emails make you feel like they're <!URGENT!>!
				Watch out for threats to suspend accounts or block you from services.
				They prey on your <!FEAR!>!
				
				[/center]
				[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]Leave.[/url]?>[/right]
				"""
			),
		},
		"training"
	)
