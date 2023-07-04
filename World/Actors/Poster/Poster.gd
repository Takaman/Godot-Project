extends CharacterBody2D

@onready var hud := $"/root/Base_Map/HUD"
@onready var interactable := $/root/Base_Map/Interactable
@onready var state = 0
signal dialogue_closed

func interact() -> void:
	print("interaction started")
	if state == 0:
		hud.show_dialog(
			"poster1",
			{
				"$begin":
				Utils.dialog_part(
					"""
					[b]Poster Guy[/b]
					Hey, look at this poster! It says we can win a free drink!
					
					<?[url=$see][right]Really? Let me see too![/right][/url]?>
					<?[url=$end][right]I see.[/right][/url]?>
					"""
				),
				"$see":
				Utils.dialog_part(
					"""
					[center][b]Stand a chance to win a FREE drink![/b][/center]
					
					[center]Simply scan the QR code below and download our app to try.[/center]
					
					[center][img=50x50]res://World/Actors/Poster/frame.png[/img][/center]
					
					<?[url=$noscan][right]This looks a little strange...[/right][/url]?>
					<?[url=$scan][right]Wow, I can win a free drink? Let's give it a go.[/right][/url]?>
					"""
				),
				"$noscan":
				Utils.dialog_part(
					"""
					[b]Poster Guy[/b]
					What? You don't trust it? Suit yourself, but I'm gonna win a free drink!
					
					<?[url=$end][right]I don't think that scanning that QR code is a good idea...[/right][/url]?>
					"""
				),
				"$scan":
					Utils.dialog_part(
					"""
					[b]Poster Guy[/b]
					Let's scan it together!
					
					<?[url=$end][right]Scan QR code[/right][/url]?>
					"""
				)
			},
			"socialengineering"
			
		)
	elif state == 1:
		hud.show_dialog(
			"poster1",
			{
				"$begin":
				Utils.dialog_part(
					"""
					[b]Poster Guy[/b]
					What's going on? My phone keeps saying that the app I downloaded is a virus! Did the poster trick me?
					
					<?[url=$next:correct][right]I guess you can't trust random QR codes.[/right][/url]?>
					"""
				),
				"$next":
				Utils.dialog_part(
					"""
					[b]Poster Guy[/b]
					You're right... I should have followed what <#[url=https://www.straitstimes.com/tech/can-i-trust-this-qr-code-csa-police-issue-alert-on-qr-code-scams-and-how-to-avoid-being-tricked]this article[/url]#> says. Luckily I had an antivirus app running on my phone - who knows what could have happened if I didn't!
					
					<?[url=$end][right]Make sure to keep that article in mind in the future.[/right][/url]?>
					"""
				)
			},
			"socialengineering"
		)
		state = 3
		if interactable!= null and interactable is Node:
			interactable.remove_mark()
	elif state == 2:
		hud.show_dialog(
			"poster1",
			{
				"$begin":
				Utils.dialog_part(
					"""
					Your phone is unusable... the app you downloaded seems to have been some kind of ransomware.
					
					<?[url=$next][right]I think I made a mistake.[/right][/url]?>
					"""
				),
				"$next":
				Utils.dialog_part(
					"""
					[b]Poster Guy[/b]
					What's going on? I can't use my phone anymore!
					
					<?[url=$next2:wrong][right]We downloaded a ransomware. We can only pay the ransom or reset our phones and delete our data...[/right][/url]?>
					"""
				),
				"$next2":
				Utils.dialog_part(
					"""
					[b]Poster Guy[/b]
					We made a big mistake... thankfully, my data was backed up. We should have paid more attention to what <#[url=https://www.straitstimes.com/tech/can-i-trust-this-qr-code-csa-police-issue-alert-on-qr-code-scams-and-how-to-avoid-being-tricked]this article[/url]#> says.
					
					<?[url=$end][right]We should be more careful in the future.[/right][/url]?>
					"""
				)
			},
			"socialengineering"
		)
		state = 4
		if interactable!= null and interactable is Node:
			interactable.remove_mark()
	elif state == 3:
		hud.show_dialog(
			"poster1",
			{
				"$begin":
				Utils.dialog_part(
					"""
					[b]Poster Guy[/b]
					I should have followed what <#[url=https://www.straitstimes.com/tech/can-i-trust-this-qr-code-csa-police-issue-alert-on-qr-code-scams-and-how-to-avoid-being-tricked]this article[/url]#> says. Luckily I had an antivirus app running on my phone - who knows what could have happened if I didn't!
					
					<?[url=$end][right]You should be more careful in the future.[/right][/url]?>
					"""
				)
			},
			"socialengineering"
		)
	elif state == 4:
		hud.show_dialog(
			"poster1",
			{
				"$begin":
				Utils.dialog_part(
					"""
					[b]Poster Guy[/b]
					We should have followed what <#[url=https://www.straitstimes.com/tech/can-i-trust-this-qr-code-csa-police-issue-alert-on-qr-code-scams-and-how-to-avoid-being-tricked]this article[/url]#> says. Luckily I had an antivirus app running on my phone - who knows what could have happened if I didn't!
					
					<?[url=$end][right]We should be more careful in the future.[/right][/url]?>
					"""
				)
			},
			"socialengineering"
		)

func _on_area_2d_area_entered(area):
	print("interactable!")
	if area.is_in_group("Player"):
		interact()

func _on_hud_partsignaller():
	if hud.part_name == "$scan":
		state = 2
		if interactable!= null and interactable is Node:
			interactable.in_progress()
	elif hud.part_name == "$noscan":
		state = 1
		if interactable!= null and interactable is Node:
			interactable.in_progress()

func _physics_process(delta: float) -> void:
	if Score.get_result("poster1", "socialengineering") != 0:
		if interactable!= null and interactable is Node:
			interactable.visible = false
	if Score.get_result("poster1", "socialengineering") == 1:
		state = 3
	elif Score.get_result("poster1", "socialengineering") == 2:
		state = 4
