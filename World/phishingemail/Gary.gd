extends Sprite2D

@onready var hud := $"/root/house_internal_phishingemail/HUD"
@onready var marker := get_node("marker")
@onready var state = -1

func _on_hud_partsignaller():
	pass # Replace with function body.

func _physics_process(delta: float) -> void:
	if Score.get_result("realemail3","socialengineering") != 0:
		if marker != null and marker is Node:
				marker.visible = false
	if Score.get_result("realemail3","socialengineering") == 1:
		state == 1
	elif Score.get_result("realemail3","socialengineering") == 2:
		state == 5

func interact() -> void:
	print("interaction started")
	if state == -1 or state == 0:
		state = 0
		hud.show_dialog(
			"realemail3",
			{
				"$begin":
					Utils.dialog_part(
						"""
						[b]Gary[/b]
						
						Hello. Help me decide if this email is legitimate.
						
						[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$garynext]Sure, I can take a look.[/url]?>[/right]
						[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]Not right now.[/url]?>[/right]
						"""
					),
				"$garynext":
					Utils.dialog_part(
						"""
						Microsoft Account Team <account-security-noreply@accountprotection.microsoft.com>
						
						Subject: Added Microsoft Account Security Information
						
						Microsoft Account
						
						[b]Unusual Login Activity[/b]
						
						Some anomalies have been detected with recent logins to the Microsoft account ga********@gmail.com:
						
						[b]Login Details[/b]
						Country/ Region: Malaysia
						IP Address: 210.186.100.100
						Date: 2023/06/29 12:33 (GMT)
						Platform: IOS
						Browser: -
						
						Please go to the recent activity page and let us see if this is you. If not, we'll help you secure your account. If yes, we will trust similar activities in the future.
						
						[url=https://account.microsoft.com/activity]View recent activity[/url]
						
						To opt out or make changes where you receive security notifications, [url=https://account.live.com/SecurityNotifications/Update]click here[/url] .
						
						Thanks!
						Microsoft Account Team
						
						[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$garyclick:correct]You should probably check your recent activity.[/url]?>[/right]
						[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$garynoclick]I think you should check with Microsoft.[/url]?>[/right]
						[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]Give me some time to think about it.[/url]?>[/right]
						"""
					),
				"$garyclick":
					Utils.dialog_part(
						"""
						[b]Gary[/b]
						
						I should. I hope my account didn't get compromised.
						
						[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]Go for it.[/url]?>[/right]
						"""
					),
				"$garynoclick":
					Utils.dialog_part(
						"""
						[b]Gary[/b]
						
						That's a good idea. Come talk to me again in a bit.
						
						[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]Ok.[/url]?>[/right]
						"""
					),
			},
			"socialengineering"
		)

