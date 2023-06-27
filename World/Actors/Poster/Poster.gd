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
					
					<?[url=$see]Really? Let me see too![/url]?>
					<?[url=$end]I see.[/url]?>
					"""
				),
				"$see":
				Utils.dialog_part(
					"""
					[center][b]Stand a chance to win a FREE drink![/b][/center]
					
					[center]Simply scan the QR code below and download our app to try.[/center]
					
					[center][img=50x50]res://World/Actors/Poster/frame.png[/img][/center]
					
					<?[url=$correct:correct]This looks a little strange...[/url]?>
					<?[url=$end:wrong]Wow, I can win a free drink? Let's give it a go.[/url]?>
					"""
				),
				"$correct":
				Utils.dialog_part(
					"""
					[b]Poster Guy[/b]
					What? You don't trust it? Suit yourself, but I'm gonna win a free drink!
					
					<?[url=$end]I don't think that scanning that QR code is a good idea...[/url]?>
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
					
					<?[url=$next]I guess you can't trust random QR codes.[/url]?>
					"""
				),
				"$next":
				Utils.dialog_part(
					"""
					[b]Poster Guy[/b]
					You're right... I should have followed what <#[url=https://www.straitstimes.com/tech/can-i-trust-this-qr-code-csa-police-issue-alert-on-qr-code-scams-and-how-to-avoid-being-tricked]this article[/url]#> says. Luckily I had an antivirus app running on my phone - who knows what could have happened if I didn't!
					
					<?[url=$end]Make sure to keep that article in mind in the future.[/url]?>
					"""
				)
			},
			"socialengineering"
		)
		state = 3
		if interactable is Node:
			interactable.remove_mark()
	elif state == 2:
		hud.show_dialog(
			"poster1",
			{
				"$begin":
				Utils.dialog_part(
					"""
					Your phone is unusable... the app you downloaded seems to have been some kind of ransomware.
					
					<?[url=$next]I made a mistake.[/url]?>
					"""
				),
				"$next":
				Utils.dialog_part(
					"""
					[b]Poster Guy[/b]
					What's going on? I can't use my phone anymore!
					
					<?[url=$next2]We got hit by a ransomware. We can only pay the ransom or reset our phones and delete our data...[/url]?>
					"""
				),
				"$next2":
				Utils.dialog_part(
					"""
					[b]Poster Guy[/b]
					We made a big mistake... thankfully, I backed up my data before this. We should have paid more attention to what <#[url=https://www.straitstimes.com/tech/can-i-trust-this-qr-code-csa-police-issue-alert-on-qr-code-scams-and-how-to-avoid-being-tricked]this article[/url]#> says.
					
					<?[url=$end]We should be more careful in the future.[/url]?>
					"""
				)
			},
			"socialengineering"
		)
		state = 4
		if interactable is Node:
			interactable.remove_mark()


func _on_area_2d_area_entered(area):
	print("interactable!")
	if area.is_in_group("Player"):
		interact()


func _on_hud_correct():
	state = 1
	if interactable is Node:
		interactable.in_progress()


func _on_hud_wrong():
	state = 2
	if interactable is Node:
		interactable.in_progress()
