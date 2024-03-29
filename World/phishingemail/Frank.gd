extends Sprite2D

@onready var hud := $"/root/house_internal_phishingemail/HUD"
@onready var marker := get_node("marker")
@onready var state = -1
@onready var itguy := $"/root/house_internal_phishingemail/ITGuy"
@onready var itguyinprogress : bool = false

func _on_hud_partsignaller():
	if hud.part_name == "$franknoclick":
		if state == 0:
			state = 2
		if marker != null and marker is Node:
			marker.in_progress()
	elif hud.part_name == "$frankclick":
		if state == 0:
			state = 1
		if marker != null and marker is Node:
			marker.correct()
	elif hud.part_name == "$frankwrongdone":
		if marker != null and marker is Node:
			marker.wrong()
		state = 3

func _physics_process(delta: float) -> void:
	if Score.get_result("realemail2","socialengineering") == 1:
		state = 1
		if marker != null and marker is Node:
			marker.correct()
	elif Score.get_result("realemail2","socialengineering") == 2:
		state = 3
		if marker != null and marker is Node:
			marker.wrong()
			
	#Disables interaction while another question is in progress
	if itguy.get_itguy_state() == "base" or itguy.get_itguy_state() == "frank" or itguy.get_itguy_state() == "frank2":
		itguyinprogress = false
		if marker != null and marker is Node:
			marker.toggle_visibility(true)
	else:
		itguyinprogress = true
		if marker != null and marker is Node:
			marker.toggle_visibility(false)
			
func interact() -> void:
	print("interaction started")
	if itguyinprogress == true:
		hud.show_dialog(
			"realemail1",
			{
				"$begin":
					Utils.dialog_part(
						"""
						[b]Frank[/b]
						
						Are you helping someone right now? You should hurry up before something happens.
						
						[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]Ok.[/url]?>[/right]
						"""
					)
			},
			"socialengineering"
		)
	else:
		if state == -1 or state == 0:
			state = 0
			hud.show_dialog(
				"realemail2",
				{
					"$begin":
						Utils.dialog_part(
							"""
							[b]Frank[/b]
							
							Morning. What do you think of this email?
							
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$franknext]Sure, I can take a look.[/url]?>[/right]
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]Not right now.[/url]?>[/right]
							"""
						),
					"$franknext":
						Utils.dialog_part(
							"""
							ibanking.alert <ibanking.alert@dbs.com>
							
							Subject: Action Required: Security Update for your Business Banking Account
							
							Dear Sir / Madam,
							
							As part of our ongoing commitment to providing and maintaining the highest level of security for our customers, we have begun to roll out a new security update for all business banking users.
							
							Due to the recent increase in unauthorised access attempts and scams, we require all customers to first verify their identities before we can carry out the security update.
							
							Please refer to the following steps to carry out your identity verification and security update.
							
							[ol]
							Click on the following link to access our business banking portal: https://internet-banking.dbs.com.sg/IB/Welcome
							Enter your business banking account credentials to login.
							Once successfully logged in, you will be prompted to confirm your company's UEN and registered signatories for this account.
							Lastly, you will be redirected to a page that will take you through the security update process.
							[/ol]
							
							Please carry this update out soon, so as to better secure your account.
							
							This is an auto-generated message. Please do not reply to this email.
							For enquiries, visit our DBS Help & Support Page or chat with us on DBS Digibot on our official DBS website.
							
							Thank you for banking with us.
							
							Yours faithfully,
							DBS Bank Ltd
							
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$frankclick:correct]Isn't this quite important for our company? You should follow what the email says.[/url]?>[/right]
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$franknoclick]I think you should check with the bank.[/url]?>[/right]
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]Give me some time to think about it.[/url]?>[/right]
							"""
						),
					"$frankclick":
						Utils.dialog_part(
							"""
							[b]Frank[/b]
							
							Definitely. The finance department would have a lot of trouble if anything happened to our bank account.
							
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]Go for it.[/url]?>[/right]
							"""
						),
					"$franknoclick":
						Utils.dialog_part(
							"""
							[b]Frank[/b]
							
							I hope I don't waste anyone at the bank's time. Come talk to me again in a bit.
							
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]Ok.[/url]?>[/right]
							"""
						),
				},
				"socialengineering"
			)
		elif state == 1:
			hud.show_dialog(
				"realemail2",
				{
					"$begin":
						Utils.dialog_part(
							"""
							[b]Frank[/b]
							
							Well, there were no problems with the process. Thanks for the help.
							
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]Welcome.[/url]?>[/right]
							"""
						),
				},
				"socialengineering"
			)
		elif state == 2:
			hud.show_dialog(
				"realemail2",
				{
					"$begin":
						Utils.dialog_part(
							"""
							[b]Frank[/b]
							
							I had to wait an hour before someone from the bank was available to talk, and they said this email is genuine. Better safe than sorry, but that was a huge waste of time.
							
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$frankwrongdone]Oh...[/url]?>[/right]
							"""
						),
					"$frankwrongdone":
						Utils.dialog_part(
							"""
							[b]Frank[/b]
							
							Maybe you should look at those [b]posters at the back[/b] to familiarize yourself a bit.
							
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end:wrong]I'll do so.[/url]?>[/right]
							"""
						),
				},
				"socialengineering"
			)
		elif state == 3:
			hud.show_dialog(
				"realemail2",
				{
					"$begin":
						Utils.dialog_part(
							"""
							[b]Frank[/b]
							
							Have you looked at the [b]posters at the back[/b] to familiarize yourself?
							
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]I'll do so.[/url]?>[/right]
							"""
						),
				},
				"socialengineering"
			)
