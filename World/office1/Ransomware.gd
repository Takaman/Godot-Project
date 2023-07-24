extends Sprite2D

@onready var hud := $"/root/Office1/HUD"
@onready var interactable := $"/root/Office1/QuestionmarkFolder/Ransomware"
@onready var state = 0
@onready var password : String = ""

func _ready():
	interactable.correct()
	interactable.visible = false
	pass

func interact() -> void:
	print("interaction started")
	if state == 0:
		hud.show_dialog(
			"ransomware",
			{
				"$begin":
					Utils.dialog_part(
						"""
						[b]Betty[/b]
						
						I think I'm in trouble. Should I try to resolve this myself?
						
						[center][img=100x100]res://World/office1/images/Question/CryptoLocker.jpg[/img][/center]
						
						[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$right:correct]You should seek help from the IT department![/url]?>[/right]
						
						[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$wrong1:wrong]Maybe it's just a temporary glitch. Let's just ignore it.[/url]?>[/right]
						
						[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$wrong2:wrong]Have you tried paying the ransom?[/url]?>[/right]
						
						"""
					),
					"$right":
						Utils.dialog_part(
							"""
							Rightfully so!
							
							Always report incidents to the IT department as it can help them minimise the impact.
							Most of us aren't trained to solve these problems, so remember to always follow your company's protocol.
							
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]Exit[/url]?>[/right]
							"""
							
						),
					"$wrong1":
						Utils.dialog_part(
							"""
							Oh no...
							
							Attempting to resolve problems without the proper knowledge or tools can lead to further damage or unsuccessful recovery attempts.
							
							You should instead have disconnected from the network and contacted a cybersecurity professional.
							
							[center]<#[url=https://en.wikipedia.org/wiki/CryptoLocker] Click here to learn more.[/url]#>[/center]
							
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]Exit[/url]?>[/right]
							"""
						),
					"$wrong2":
						Utils.dialog_part(
							"""
							STOP!
							
							Never deal with such a situation by yourself, or you might worsen its impact.
							
							You should instead have disconnected from the network and contacted a cybersecurity professional.
							
							[center]<#[url=https://en.wikipedia.org/wiki/CryptoLocker] Click here to learn more.[/url]#>[/center]
							
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]Exit[/url]?>[/right]
							"""
						),
			},
			"malware",
			)
			
func _on_area_2d_area_entered(area):
	print("interactable!")
	if area.is_in_group("Player"):
		interact()

func _physics_process(delta: float) -> void:
	if interactable!= null and interactable is Node:
		if Score.get_result("ransomware","malware") == 1:
			interactable.correct()
			interactable.visible  = true
		if Score.get_result("ransomware","malware") == 2:
			interactable.visible  = true
			interactable.reset()
	
