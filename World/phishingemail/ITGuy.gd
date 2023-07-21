extends Sprite2D

@onready var hud := $"/root/house_internal_phishingemail/HUD"
@onready var marker := get_node("marker")
@onready var state : String = "base"

signal john_next
signal caren_next
signal danny_next
signal elen_next

func _on_hud_partsignaller():
	if hud.part_name == "$itjohnnext3":
		state = "john2"
		emit_signal("john_next")
	if hud.part_name == "$itcarennext3":
		print(state)
		state = "caren2"
		emit_signal("caren_next")
	if hud.part_name == "$itdannynext3":
		state = "danny2"
		emit_signal("danny_next")
	if hud.part_name == "$itelennext3":
		state = "elen2"
		emit_signal("elen_next")

func _ready():
	if marker != null and marker is Node:
		marker.toggle_visibility(false)
	pass

func _physics_process(delta: float) -> void:
	if state == "base":
		if marker != null and marker is Node:
			marker.toggle_visibility(false)

func get_itguy_state() -> String:
	return state

func _on_john_it_guy():
	state = "john"
	if marker != null and marker is Node:
		marker.toggle_visibility(true)
		marker.in_progress()

func _on_john_phishing_email_john_done():
	state = "base"
	if marker != null and marker is Node:
		marker.toggle_visibility(false)

func _on_caren_phishing_email_it_guy_caren():
	print(state)
	state = "caren"
	if marker != null and marker is Node:
		marker.toggle_visibility(true)
		marker.in_progress()

func _on_caren_phishing_email_caren_done():
	state = "base"
	if marker != null and marker is Node:
		marker.toggle_visibility(false)

func _on_danny_phishing_email_it_guy_danny():
	state = "danny"
	if marker != null and marker is Node:
		marker.toggle_visibility(true)
		marker.in_progress()

func _on_danny_phishing_email_danny_done():
	state = "base"
	if marker != null and marker is Node:
		marker.toggle_visibility(false)

func _on_elen_real_email_it_guy_elen():
	state = "elen"
	if marker != null and marker is Node:
		marker.toggle_visibility(true)
		marker.in_progress()

func _on_elen_real_email_elen_done():
	state = "base"
	if marker != null and marker is Node:
		marker.toggle_visibility(false)

func interact() -> void:
	print("interaction started")
	if state == "base":
		hud.show_dialog(
			"IT Guy",
			{
				"$begin":
					Utils.dialog_part(
						"""
						[b]IT Guy[/b]
						
						Hi, I'm the IT guy.
						
						[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]I see.[/url]?>[/right]
						"""
					)
			},
			"training"
		)
	elif state == "john":
		hud.show_dialog(
			"IT Guy",
			{
				"$begin":
					Utils.dialog_part(
						"""
						[b]IT Guy[/b]
						
						Hi, I'm the IT guy.
						
						[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$next]Hey, John fell for a phishing email. What should we do?[/url]?>[/right]
						[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]I see.[/url]?>[/right]
						"""
					),
				"$next":
					Utils.dialog_part(
						"""
						[b]IT Guy[/b]
						
						What!? That's bad news... do you remember what the context of the email was?
						
						[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$back1]An email from someone impersonating Twitter.[/url]?>[/right]
						[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$itjohnnext2]An email from someone impersonating the IT department.[/url]?>[/right]
						[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$back1]An email from someone impersonating the bank.[/url]?>[/right]
						[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$back1]An email from someone impersonating Microsoft.[/url]?>[/right]
						"""
					),
				"$back1":
					Utils.dialog_part(
						"""
						[b]IT Guy[/b]
						
						Hmm... Are you sure about that?
						
						[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$next]Let me try to remember.[/url]?>[/right]
						"""
					),
				"$itjohnnext2":
					Utils.dialog_part(
						"""
						[b]IT Guy[/b]
						
						Impersonating us? That's worrying. What information did John type into the fake website?
						
						[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$back2]Bank account details.[/url]?>[/right]
						[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$back2]Personal email credentials.[/url]?>[/right]
						[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$itjohnnext3]Corporate email credentials.[/url]?>[/right]
						[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$back2]Twitter account.[/url]?>[/right]
						[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$back2]Microsoft account.[/url]?>[/right]
						"""
					),
				"$back2":
					Utils.dialog_part(
						"""
						[b]IT Guy[/b]
						
						Hmm... Are you sure about that?
						
						[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$itjohnnext2]Let me try to remember.[/url]?>[/right]
						"""
					),
				"$itjohnnext3":
					Utils.dialog_part(
						"""
						[b]IT Guy[/b]
						
						Since you realised so quickly, there shouldn't be much damage done, so just tell John to do this:
						
						[ol]
						Change the password for his account.
						Enable two-factor authentication.
						Run an antivirus scan.
						Monitor his account for any strange activity.
						[/ol]
						
						[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]Alright.[/url]?>[/right]
						"""
					),
			},
			"training"
		)
	elif state == "john2":
		hud.show_dialog(
			"IT Guy",
			{
				"$begin":
					Utils.dialog_part(
						"""
						[b]IT Guy[/b]
						
						Tell John to follow these steps.
						
						[ol]
						Change the password for his account.
						Enable two-factor authentication.
						Run an antivirus scan.
						Monitor his account for any strange activity.
						[/ol]
						
						[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]Alright.[/url]?>[/right]
						"""
					),
			},
			"training"
		)
	elif state == "caren":
		hud.show_dialog(
			"IT Guy",
			{
				"$begin":
					Utils.dialog_part(
						"""
						[b]IT Guy[/b]
						
						Hi, I'm the IT guy.
						
						[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$next]Hey, Caren fell for a phishing email. What should we do?[/url]?>[/right]
						[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]I see.[/url]?>[/right]
						"""
					),
				"$next":
					Utils.dialog_part(
						"""
						[b]IT Guy[/b]
						
						What!? That's bad news... do you remember what the context of the email was?
						
						[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$back1]An email from someone impersonating Twitter.[/url]?>[/right]
						[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$itcarennext2]An email from someone impersonating the IT department.[/url]?>[/right]
						[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$back1]An email from someone impersonating the bank.[/url]?>[/right]
						[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$back1]An email from someone impersonating Microsoft.[/url]?>[/right]
						"""
					),
				"$back1":
					Utils.dialog_part(
						"""
						[b]IT Guy[/b]
						
						Hmm... Are you sure about that?
						
						[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$next]Let me try to remember.[/url]?>[/right]
						"""
					),
				"$itcarennext2":
					Utils.dialog_part(
						"""
						[b]IT Guy[/b]
						
						Impersonating us? That's worrying. What information did Caren type into the fake website?
						
						[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$back2]Bank account details.[/url]?>[/right]
						[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$back2]Personal email credentials.[/url]?>[/right]
						[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$itcarennext3]Corporate email credentials.[/url]?>[/right]
						[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$back2]Twitter account.[/url]?>[/right]
						[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$back2]Microsoft account.[/url]?>[/right]
						"""
					),
				"$back2":
					Utils.dialog_part(
						"""
						[b]IT Guy[/b]
						
						Hmm... Are you sure about that?
						
						[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$itcarennext2]Let me try to remember.[/url]?>[/right]
						"""
					),
				"$itcarennext3":
					Utils.dialog_part(
						"""
						[b]IT Guy[/b]
						
						Since you realised so quickly, there shouldn't be much damage done, so just tell Caren to do this:
						
						[ol]
						Change the password for her account.
						Enable two-factor authentication.
						Run an antivirus scan.
						Monitor her account for any strange activity.
						[/ol]
						
						[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]Alright.[/url]?>[/right]
						"""
					),
			},
			"training"
		)
	elif state == "caren2":
		hud.show_dialog(
			"IT Guy",
			{
				"$begin":
					Utils.dialog_part(
						"""
						[b]IT Guy[/b]
						
						Tell Caren to follow these steps.
						
						[ol]
						Change the password for her account.
						Enable two-factor authentication.
						Run an antivirus scan.
						Monitor her account for any strange activity.
						[/ol]
						
						[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]Alright.[/url]?>[/right]
						"""
					),
			},
			"training"
		)
	elif state == "danny":
		hud.show_dialog(
			"IT Guy",
			{
				"$begin":
					Utils.dialog_part(
						"""
						[b]IT Guy[/b]
						
						Hi, I'm the IT guy.
						
						[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$next]Hey, Danny fell for a phishing email. What should we do?[/url]?>[/right]
						[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]I see.[/url]?>[/right]
						"""
					),
				"$next":
					Utils.dialog_part(
						"""
						[b]IT Guy[/b]
						
						What!? That's bad news... do you remember what the context of the email was?
						
						[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$back1]An email from someone impersonating Twitter.[/url]?>[/right]
						[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$back1]An email from someone impersonating the IT department.[/url]?>[/right]
						[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$itdannynext2]An email from someone impersonating the bank.[/url]?>[/right]
						[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$back1]An email from someone impersonating Microsoft.[/url]?>[/right]
						"""
					),
				"$back1":
					Utils.dialog_part(
						"""
						[b]IT Guy[/b]
						
						Hmm... Are you sure about that?
						
						[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$next]Let me try to remember.[/url]?>[/right]
						"""
					),
				"$itdannynext2":
					Utils.dialog_part(
						"""
						[b]IT Guy[/b]
						
						Impersonating the bank? What information did John type into the fake website?
						
						[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$back2]Personal bank account credentials.[/url]?>[/right]
						[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$itdannynext3]Company bank account credentials.[/url]?>[/right]
						[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$back2]Corporate email credentials.[/url]?>[/right]
						[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$back2]Twitter account.[/url]?>[/right]
						[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$back2]Microsoft account.[/url]?>[/right]
						"""
					),
				"$back2":
					Utils.dialog_part(
						"""
						[b]IT Guy[/b]
						
						Hmm... Are you sure about that?
						
						[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$itdannynext2]Let me try to remember.[/url]?>[/right]
						"""
					),
				"$itdannynext3":
					Utils.dialog_part(
						"""
						[b]IT Guy[/b]
						
						Since this incident involves a third party, we have to contact the relevant parties involved. Tell Danny to do this:
						
						[ol]
						Change the password for the account.
						Notify the bank.
						Enable two-factor authentication.
						Monitor the account for any strange activity.
						Make a police report.
						[/ol]
						
						[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]Alright.[/url]?>[/right]
						"""
					),
			},
			"training"
		)
	elif state == "danny2":
		hud.show_dialog(
			"IT Guy",
			{
				"$begin":
					Utils.dialog_part(
						"""
						[b]IT Guy[/b]
						
						Tell Danny to follow these steps.
						
						[ol]
						Change the password for the account.
						Notify the bank.
						Enable two-factor authentication.
						Monitor the account for any strange activity.
						Make a police report.
						[/ol]
						
						[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]Alright.[/url]?>[/right]
						"""
					),
			},
			"training"
		)
	elif state == "elen":
		hud.show_dialog(
			"IT Guy",
			{
				"$begin":
					Utils.dialog_part(
						"""
						[b]IT Guy[/b]
						
						Hi, I'm the IT guy.
						
						[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$next]Hey, I think Elen might have received a phishing email.[/url]?>[/right]
						[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]I see.[/url]?>[/right]
						"""
					),
				"$next":
					Utils.dialog_part(
						"""
						[b]IT Guy[/b]
						
						Really? What was the context of the email?
						
						[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$back1]An email from Twitter.[/url]?>[/right]
						[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$itelennext2]An email from the IT department.[/url]?>[/right]
						[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$back1]An email from the bank.[/url]?>[/right]
						[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$back1]An email from Microsoft.[/url]?>[/right]
						"""
					),
				"$back1":
					Utils.dialog_part(
						"""
						[b]IT Guy[/b]
						
						Hmm... Are you sure about that?
						
						[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$next]Let me try to remember.[/url]?>[/right]
						"""
					),
				"$itelennext2":
					Utils.dialog_part(
						"""
						[b]IT Guy[/b]
						
						An email from us? Let me check... Yea, we did send an email asking her to change her email password.
						
						[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$itelennext3]Oh...[/url]?>[/right]
						"""
					),
				"$itelennext3":
					Utils.dialog_part(
						"""
						[b]IT Guy[/b]
						
						It's good that you asked when you were unsure, but please try to look more closely in the future. You can try looking at the [b]posters at the back of the office[/b] to learn more.
						
						[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]Sorry for disturbing you.[/url]?>[/right]
						"""
					),
			},
			"training"
		)
	elif state == "elen2":
		hud.show_dialog(
			"IT Guy",
			{
				"$begin":
					Utils.dialog_part(
						"""
						[b]IT Guy[/b]
						
						It's good that you asked when you were unsure, but please try to look more closely in the future. You can try looking at the [b]posters at the back of the office[/b] to learn more.
						
						[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]Sorry for disturbing you.[/url]?>[/right]
						"""
					),
			},
			"training"
		)



