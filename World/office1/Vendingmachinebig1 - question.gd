extends Sprite2D


@onready var hud := $"/root/FoodCourt/HUD"
@onready var interactable := $"/root/FoodCourt/QuestionmarkFolder/Interactable4"


func _ready():
	interactable.correct()
	interactable.visible = false
	pass

func interact() -> void:
	print("interaction started")
	hud.show_dialog(
		"vendingmachine1",
		{
			"$begin":
			Utils.dialog_part(
				"""
				There's a note accompanying the QR code attached to the vending machine that claims scanning it will give you free food from the vending machine.
				
				[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$change:wrong]I like free food! I'll scan the QR code. [/url]?>[/right]
				[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$nochange:correct]I'd rather not scan the QR code.[/url]?>[/right]
				"""
			),
			"$change":
				Utils.dialog_part(
				"""
				Scanning the QR code... Processing... 
				
				Oh no! It seems the link was blocked by the company network. You most likely visited a phishing website. 
				
				It's crucial to be cautious when scanning unknown QR codes, as they can be used for malicious purposes. 
				
				Always ensure the authenticity and legitimacy of QR codes before scanning them to protect your personal information and device.  
				
				[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]Exit[/url]?>[/right]
				"""
				),
			"$nochange":
				Utils.dialog_part(
				"""
				Wise decision!
				
				It's important to prioritize your security and privacy. Scanning unknown QR codes can expose you to potential risks and threats.
				
				By avoiding scanning unverified QR codes, you're taking a proactive step to safeguard your personal information and device.
				
				[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]Exit[/url]?>[/right]
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
	if interactable!= null and interactable is Node:
		if Score.get_result("vendingmachine1","socialengineering") == 1:
			interactable.correct()
			interactable.visible  = true
		if Score.get_result("vendingmachine1","socialengineering") == 2:
			interactable.visible  = true
			interactable.reset()
