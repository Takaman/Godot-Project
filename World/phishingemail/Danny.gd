extends Sprite2D

@onready var hud := $"/root/house_internal_phishingemail/HUD"
@onready var marker := get_node("marker")
@onready var state = -1

func _on_hud_partsignaller():
	pass # Replace with function body.

func _physics_process(delta: float) -> void:
	if Score.get_result("phishingemail3","socialengineering") != 0:
		if marker != null and marker is Node:
				marker.visible = false
	if Score.get_result("phishingemail3","socialengineering") == 1:
		state == 1
	elif Score.get_result("phishingemail3","socialengineering") == 2:
		state == 5

func interact() -> void:
	print("interaction started")
	if state == -1:
		state = 0
		hud.show_dialog(
			"phishingemail3",
			{
				"$begin":
					Utils.dialog_part(
						"""
						[b]Danny[/b]
						
						Oh, hi there. Since you're here, could you help me take a look at this email I received?
						
						[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$dannynext]Sure, I can take a look.[/url]?>[/right]
						[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]Not right now.[/url]?>[/right]
						"""
					),
				"$dannynext":
				Utils.dialog_part(
						"""
						ibanking.alert <ibankingalert@dbs.com>
						
						Subject: [Urgent] Action Required: Security Update for your Business Banking Account
						
						Dear Sir / Madam,
						
						As part of our ongoing commitment to providing and maintaining the highest level of security for our customers, we have begun to roll out a new security update for all business banking users, and your business has now been selected to receive this update.
						
						Due to the recent increase in unauthorised access attempts and scams, we require all customers to first verify their identities before we can carry out the security update.
						
						Note that failure to complete this may result in suspension of your business banking account.
						
						Please refer to the following steps to carry out your identity verification and security update.
						
						[ol]
						[li]Click on the following link to access our business banking portal: [url]placeholder link[/url][/li]
						[li]Enter your business banking account credentials to login.[/li]
						[li]Once successfully logged in, you will be prompted to confirm your company's UEN and registered signatories for this account.[/li]
						[li]Lastly, you will be redirected to a page that will take you through the security update process.[/li]
						[/ol]
						
						If you encounter any technical difficulties or require assistance at any point during this process, please do not hesitate to reply to this email.
						
						Please note that this security update is time-sensitive, and your prompt response is required to mitigate any potential security risks.
						
						Thank you for banking with us.
						
						Yours faithfully,
						DBS Bank Ltd
						
						[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$dannyclick]There's not much time left! You'd better change your password now.[/url]?>[/right]
						[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$dannynoclick:correct]Have you checked with the IT department?[/url]?>[/right]
						[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]Give me some time to think about it.[/url]?>[/right]
						"""
					),
				"$dannyclick":
					Utils.dialog_part(
						"""
						[b]Danny[/b]
						
						[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]Give me some time to think about it.[/url]?>[/right]
						"""
					),
				"$dannynoclick":
					Utils.dialog_part(
						"""
						[b]Danny[/b]
						
						[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]Give me some time to think about it.[/url]?>[/right]
						"""
					)
			},
			"socialengineering"
		)

