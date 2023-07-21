extends Sprite2D

@onready var hud := $"/root/house_internal_phishingemail/HUD"
@onready var marker := get_node("marker")
@onready var state = -1
@onready var itguy := $"/root/house_internal_phishingemail/ITGuy"
@onready var itguyinprogress : bool = false

signal IT_Guy_Danny
signal danny_done

func _on_hud_partsignaller():
	if hud.part_name == "$dannynoclick":
		if state == 0:
			state = 1
		if marker != null and marker is Node:
			marker.correct()
	elif hud.part_name == "$dannyclick":
		if state == 0:
			state = 2
		if marker != null and marker is Node:
			marker.in_progress()
	elif hud.part_name == "$dannywrongdone":
		if marker != null and marker is Node:
			marker.wrong()
		state = 5
		emit_signal("danny_done")

func _physics_process(delta: float) -> void:
	if Score.get_result("phishingemail3","socialengineering") == 1:
		state = 1
		if marker != null and marker is Node:
			marker.correct()
	elif Score.get_result("phishingemail3","socialengineering") == 2:
		state = 5
		if marker != null and marker is Node:
			marker.wrong()
				
	#Disables interaction while another question is in progress
	if itguy.get_itguy_state() == "base" or itguy.get_itguy_state() == "danny" or itguy.get_itguy_state() == "danny2":
		itguyinprogress = false
		if marker != null and marker is Node:
			marker.toggle_visibility(true)
	else:
		itguyinprogress = true
		if marker != null and marker is Node:
			marker.toggle_visibility(false)

func _on_it_guy_danny_next():
	state = 4

func interact() -> void:
	print("interaction started")
	if itguyinprogress == true:
		hud.show_dialog(
			"phishingemail3",
			{
				"$begin":
					Utils.dialog_part(
						"""
						[b]Danny[/b]
						
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
							
							As part of our ongoing commitment to providing and maintaining the highest level of security for our customers, we have begun to roll out a new security update for all business banking users, and your business is one of the first to be selected to receive this update!
							
							Due to the recent increase in unauthorised access attempts and scams, we require all customers to first verify their identities before we can carry out the security update.
							
							Note that failure to complete this may result in suspension of your business banking account.
							
							Please refer to the following steps to carry out your identity verification and security update.
							
							[ol]
							Click on the following link to access our business banking portal: bit.ly/dbs-bank-login
							Enter your business banking account credentials to login.
							Once successfully logged in, you will be prompted to confirm your company's UEN and registered signatories for this account.
							Lastly, you will be redirected to a page that will take you through the security update process.
							[/ol]
							
							If you encounter any technical difficulties or require assistance at any point during this process, please do not hesitate to reply to this email.
							
							Please note that this security update is time-sensitive, and your prompt response is required to mitigate any potential security risks.
							
							Thank you for banking with us.
							
							Yours faithfully,
							DBS Bank Ltd
							
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$dannyclick]Isn't this quite important for our company? You should follow what the email says.[/url]?>[/right]
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$dannynoclick:correct]I think you should check with the bank.[/url]?>[/right]
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]Give me some time to think about it.[/url]?>[/right]
							"""
						),
					"$dannyclick":
						Utils.dialog_part(
							"""
							[b]Danny[/b]
							
							Right... I'll get into trouble if the company's bank account gets locked out.
							
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]Go for it.[/url]?>[/right]
							"""
						),
					"$dannynoclick":
						Utils.dialog_part(
							"""
							[b]Danny[/b]
							
							Really? Then I'll reply to the email to check. Come talk to me again once I get another response.
							
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]Ok.[/url]?>[/right]
							"""
						)
				},
				"socialengineering"
			)
		elif state == 1:
			hud.show_dialog(
				"phishingemail3",
				{
					"$begin":
						Utils.dialog_part(
							"""
							[b]Danny[/b]
							
							I never got any reply from the email, so I called the bank and they said that this was probably a phishing email. Good thing I checked, and thanks for your help.
							
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]Happy to help.[/url]?>[/right]
							"""
						),
				},
				"socialengineering"
			)
		elif state == 2:
			hud.show_dialog(
				"phishingemail3",
				{
					"$begin":
						Utils.dialog_part(
							"""
							[b]Danny[/b]
							
							Account number, username, password... there. Hm? Why isn't anything happening when I click on login? Strange...
							
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$dannynext]Is there anything else weird about the website?[/url]?>[/right]
							"""
						),
					"$dannynext":
						Utils.dialog_part(
							"""
							[b]Danny[/b]
							
							Weird? Let me take a closer look. Oh, the URL is different...
							
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$dannynext2]That might have been a phishing link...[/url]?>[/right]
							"""
						),
					"$dannynext2":
						Utils.dialog_part(
							"""
							[b]Danny[/b]
							
							This is a problem. Our company's finances are in danger... What do you think I should do?
							
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$dannynext3]I think you should check with the IT department.[/url]?>[/right]
							"""
						),
					"$dannynext3":
						Utils.dialog_part(
							"""
							[b]Danny[/b]
							
							Ok, could you help me with that? Tell them I got a fake email from our bank and gave them our bank account credentials.
							
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]Ok.[/url]?>[/right]
							"""
						)
				},
				"socialengineering"
			)
			state = 3
			emit_signal("IT_Guy_Danny")
		elif state == 3:
			hud.show_dialog(
				"phishingemail3",
				{
					"$begin":
						Utils.dialog_part(
							"""
							[b]Danny[/b]
							
							Ok, could you help me ask the IT staff what to do? Tell them I got a fake email from our bank and gave them our bank account credentials.
							
							Here's the email if you need to refer to it.
							
							ibanking.alert <ibankingalert@dbs.com>
							
							Subject: [Urgent] Action Required: Security Update for your Business Banking Account
							
							Dear Sir / Madam,
							
							As part of our ongoing commitment to providing and maintaining the highest level of security for our customers, we have begun to roll out a new security update for all business banking users, and your business is one of the first to be selected to receive this update!
							
							Due to the recent increase in unauthorised access attempts and scams, we require all customers to first verify their identities before we can carry out the security update.
							
							Note that failure to complete this may result in suspension of your business banking account.
							
							Please refer to the following steps to carry out your identity verification and security update.
							
							[ol]
							Click on the following link to access our business banking portal: bit.ly/dbs-bank-login
							Enter your business banking account credentials to login.
							Once successfully logged in, you will be prompted to confirm your company's UEN and registered signatories for this account.
							Lastly, you will be redirected to a page that will take you through the security update process.
							[/ol]
							
							If you encounter any technical difficulties or require assistance at any point during this process, please do not hesitate to reply to this email.
							
							Please note that this security update is time-sensitive, and your prompt response is required to mitigate any potential security risks.
							
							Thank you for banking with us.
							
							Yours faithfully,
							DBS Bank Ltd
							
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]Ok.[/url]?>[/right]
							"""
						),
				},
				"socialengineering"
			)
		elif state == 4:
			hud.show_dialog(
				"phishingemail3",
				{
					"$begin":
						Utils.dialog_part(
							"""
							[b]Danny[/b]
							
							What am I supposed to do first?
							
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$back1]Make a police report.[/url]?>[/right]
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$back1]Run an antivirus scan.[/url]?>[/right]
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$back2]Send the email to your colleagues.[/url]?>[/right]
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$back1]Monitor the account for any strange activity.[/url]?>[/right]
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$back1]Report to the bank.[/url]?>[/right]
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$next]Change the password for the account.[/url]?>[/right]
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$back2]Delete the account.[/url]?>[/right]
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$back1]Enable two-factor authentication.[/url]?>[/right]
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]Let me try to remember.[/url]?>[/right]
							"""
						),
					"$back1":
						Utils.dialog_part(
							"""
							[b]Danny[/b]
							
							Is that really the correct step?
							
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$begin]Let me try to remember.[/url]?>[/right]
							"""
						),
					"$back2":
						Utils.dialog_part(
							"""
							[b]Danny[/b]
							
							I don't think thats a good idea.
							
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$begin]Let me try to remember.[/url]?>[/right]
							"""
						),
					"$next":
						Utils.dialog_part(
							"""
							[b]Danny[/b]
							
							And then?
							
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$back1]Make a police report.[/url]?>[/right]
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$back1]Run an antivirus scan.[/url]?>[/right]
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$back2]Send the email to your colleagues.[/url]?>[/right]
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$back1]Monitor the account for any strange activity.[/url]?>[/right]
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$next2]Report to the bank.[/url]?>[/right]
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$back2]Delete the account.[/url]?>[/right]
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$back1]Enable two-factor authentication.[/url]?>[/right]
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]Let me try to remember.[/url]?>[/right]
							"""
						),
					"$next2":
						Utils.dialog_part(
							"""
							[b]Danny[/b]
							
							What next?
							
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$back1]Make a police report.[/url]?>[/right]
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$back1]Run an antivirus scan.[/url]?>[/right]
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$back2]Send the email to your colleagues.[/url]?>[/right]
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$back1]Monitor the account for any strange activity.[/url]?>[/right]
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$back2]Delete the account.[/url]?>[/right]
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$next3]Enable two-factor authentication.[/url]?>[/right]
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]Let me try to remember.[/url]?>[/right]
							"""
						),
					"$next3":
						Utils.dialog_part(
							"""
							[b]Danny[/b]
							
							What next?
							
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$back1]Make a police report.[/url]?>[/right]
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$back1]Run an antivirus scan.[/url]?>[/right]
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$back2]Send the email to your colleagues.[/url]?>[/right]
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$next4]Monitor the account for any strange activity.[/url]?>[/right]
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$back2]Delete the account.[/url]?>[/right]
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]Let me try to remember.[/url]?>[/right]
							"""
						),
					"$next4":
						Utils.dialog_part(
							"""
							[b]Danny[/b]
							
							What next?
							
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$dannywrongdone]Make a police report.[/url]?>[/right]
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$back1]Run an antivirus scan.[/url]?>[/right]
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$back2]Send the email to your colleagues.[/url]?>[/right]
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$back2]Delete the account.[/url]?>[/right]
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]Let me try to remember.[/url]?>[/right]
							"""
						),
					"$dannywrongdone":
						Utils.dialog_part(
							"""
							[b]Danny[/b]
							
							Thanks for your help. In the future, those [b]posters at the back[/b] could help me decide...
							
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end:wrong]Posters? I should check them out.[/url]?>[/right]
							"""
						),
				},
				"socialengineering"
			)
		elif state == 5:
			hud.show_dialog(
				"phishingemail3",
				{
					"$begin":
						Utils.dialog_part(
							"""
							[b]Danny[/b]
							
							Thanks for your help. We can learn more by looking at those posters at the back.
							
							[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]Happy to help.[/url]?>[/right]
							"""
						)
				},
				"socialengineering"
			)
