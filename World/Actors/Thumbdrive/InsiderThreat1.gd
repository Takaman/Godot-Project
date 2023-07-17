extends Sprite2D


@onready var hud := $"/root/Office1/HUD"
@onready var interactable := $"/root/Office1/QuestionmarkFolder/InsiderThreat1"

func _ready():
	interactable.correct()
	pass
	
func interact() -> void:
	print("interaction started")
	hud.show_dialog(
		"insiderthreat1",
		{
			"$begin":
			Utils.dialog_part(
				"""
				[i]Sounds like they are having a conversation[/i]
				
				Patrick: Hey, have you heard about the new security measures they implemented?

				Laticia: Yeah, I heard they're really stepping up their game. Why? Do you think it's going to be a problem?

				Patrick: Well, let's just say I have a few concerns. I've been working here for a while, and I've noticed some vulnerabilities in our system.

				Laticia: Really? That's surprising. I always thought our security was pretty solid.

				[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$continue][i]Continue Listening.[/i][/url]?>[/right]
				"""
			),
		 	"$continue":
				Utils.dialog_part(
				"""
				Patrick: It might appear that way, but there are some gaps that could be exploited if someone knew where to look.

				Laticia: Hmm, interesting. Do you think we should report this to the higher-ups?
				
				Patrick: I'm not sure yet. I mean, we could, but what if they don't take it seriously? It's a risky move.

				Laticia: Yeah, I see your point. But keeping quiet about it also feels wrong. Maybe we should gather some evidence first and then decide what to do.

				Patrick: That sounds like a plan. Let's be cautious about it though. We don't want to raise any suspicions.
				
				[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$right:correct][i]I think this is something serious, I should report this.[/i][/url]?>[/right]
				[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$wrong1:wrong][i]I should't be coming in wrong conclusions, let's leave them alone.[/i][/url]?>[/right]
				[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$wrong2:wrong][i]Maybe I should clarify their intentions.[/i][/url]?>[/right]
				"""
				),
			"$right":
				Utils.dialog_part(
				"""
				That's the right thing to do!
				
				If there is anything you find suspicious, it is not wrong to report to the relavant personnel.
				Let them take the appropriate measures.
				
				[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]EXIT[/url]?>[/right]
				"""
				),
			"$wrong":
				Utils.dialog_part(
				"""
				Wrong choice.
				There are many factors that suggests that this is something to be reported.
				These 2 overall points shows that there are malicious intents.
				
				-Patrick's hesitation about reporting the concerns.
				-Mention to gather evidence discreetly
				

				[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]EXIT[/url]?>[/right]
				"""
				),
			"$wrong2":
				Utils.dialog_part(
				"""
				You are almost right, but not good enough.
				
				It is unadvisable to directly confront the individuals involved in the matter, as you might alert them unnecessarily. 
				
				You should have report it to the relevant higher ups instead.
				[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]EXIT[/url]?>[/right]
				"""
				),
		},
		"policy"
	)
	
func _on_area_2d_area_entered(area):
	print("interactable!")
	if area.is_in_group("Player"):
		interact()
		

func _physics_process(delta: float) -> void:
	if interactable!= null and interactable is Node:
		interactable.visible  = Score.get_has_correct("insiderthreat1","policy")
