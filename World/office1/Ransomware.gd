extends Sprite2D

@onready var hud := $"/root/Office1/HUD"
@onready var interactable := $"/root/Office1/QuestionmarkFolder/Ransomware"
@onready var state = 0
@onready var password : String = ""

func _ready():
	interactable.correct()
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
						I think im in trouble. Should I resolve this myself?

						[center][img=100x100]res://World/office1/images/Question/CryptoLocker.jpg[/img][/center]
						
						[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$right:correct]You should disconnect from the network now![/url]?>[/right]
						
						[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$wrong1:wrong]Well, maybe it's just a temporary glitch. Why don't you try running an antivirus scan and see if it resolves the issue?[/url]?>[/right]
						
						[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$wrong2:wrong]Have you tried to paying for it yet?[/url]?>[/right]
						
						"""
					),
					"$right":
						Utils.dialog_part(
							"""
							Rightfully so!
							Always report incidents to the IT department as it can help them to minimise the impact.
							We are not trained professionals to deal with it, always follow your componay's protocol.
							
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$last]Next[/url]?>[/right]
							"""
							
						),
					"$wrong1":
						Utils.dialog_part(
							"""
							Oh no.... 
							You tried to remeding it yourself despite not being a professional at it.
							You are not following proper procedures and might even worsen the situation.
							
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$last]Next[/url]?>[/right]
							"""
						),
					"$wrong2":
						Utils.dialog_part(
							"""
							STOP!
							Never deal with such situation by yourself!
							You might worsen the impact of this situation.
							
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$last]Exit[/url]?>[/right]
							"""
						),
					"$last":
						Utils.dialog_part(
							"""
							This particular attack occured in 2014 and ultilised trojan.
							If not quickly contained it can spread, causing immeasurable damage.
							
							[center]<#[url=https://en.wikipedia.org/wiki/CryptoLocker] Click here to learn more.[/url]#>[/center]
							
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]Exit[/url]?>[/right]
							"""
						)
			},
			"malware",
			)
			
func _on_area_2d_area_entered(area):
	print("interactable!")
	if area.is_in_group("Player"):
		interact()

func _physics_process(delta: float) -> void:
	if interactable!= null and interactable is Node:
		interactable.visible  = Score.get_has_correct("ransomware","malware")
	
