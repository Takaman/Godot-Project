extends Sprite2D


@onready var hud := $"/root/Office1/HUD"
@onready var interactable := $"/root/Office1/QuestionmarkFolder/Interactable4"

func interact() -> void:
	print("interaction started")
	hud.show_dialog(
		"vendingmachine1",
		{
			"$begin":
			Utils.dialog_part(
				"""
				There's a note accompanying the QR code attached to the vending machine that claims scanning it will grant you free food from the vending machine

				[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$change:wrong]I like free food. I am scanning the QR code. [/url]?>[/right]
				[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$nochange:correct]I rather not scan the QR code. I'd rather not take the risk. [/url]?>[/right]
				
				"""
			),
			"$change":
				Utils.dialog_part(
				"""
Scanning the QR code... Processing... Oh no! It seems the QR code you scanned is not authorized. You most likely visited a phishing website. It's crucial to be cautious when scanning unknown QR codes, as they can be used for malicious purposes. 

Always ensure the authenticity and legitimacy of QR codes before scanning them to protect your personal information and device.  
[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]EXIT[/url]?>[/right]
				"""
				),
			"$nochange":
				Utils.dialog_part(
				"""
Wise decision! It's important to prioritize your security and privacy. Scanning unknown QR codes can expose you to potential risks and threats. By avoiding scanning unverified QR codes, you're taking a proactive step to safeguard your personal information and device.				

[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]EXIT[/url]?>[/right]
				"""
				),
		},
		"socialengineering"
	)
	
func _on_area_2d_area_entered(area):
	print("interactable!")
	if area.is_in_group("Player"):
		interact()
		
func _physics_process(delta: float) -> void:
	interactable.visible  = !Score.has_interacted("vendingmachine1","socialengineering")
	
