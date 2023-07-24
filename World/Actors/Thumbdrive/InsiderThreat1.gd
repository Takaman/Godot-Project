extends Sprite2D


@onready var hud := $"/root/Office1/HUD"
@onready var interactable := $"/root/Office1/QuestionmarkFolder/InsiderThreat1"

func _ready():
	interactable.correct()
	interactable.visible = false
	pass
	
func interact() -> void:
	print("interaction started")
	hud.show_dialog(
		"insiderthreat1",
		{
			"$begin":
			Utils.dialog_part(
				"""
				[i]Sounds like they're having a conversation...[/i]
				
				[b]Patrick[/b]: Hey, have you heard about the new security measures they implemented?

				[b]Laticia[/b]: Yeah, I heard they're really stepping up their game. Why? Do you think it's going to be a problem?

				[b]Patrick[/b]: Well, let's just say I have a few concerns. I've been working here for a while, and I've noticed some vulnerabilities in our system.

				[b]Laticia[/b]: Really? That's surprising. I always thought our security was pretty solid.

				[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$continue][i]Continue listening.[/i][/url]?>[/right]
				"""
			),
		 	"$continue":
				Utils.dialog_part(
				"""
				[b]Patrick[/b]: It might appear that way, but there are some gaps that could be exploited if someone knew where to look.

				[b]Laticia[/b]: Hmm, interesting. Do you think we should report this to the higher-ups?
				
				[b]Patrick[/b]: I'm not sure yet. I mean, we could, but what if they don't take it seriously? It's a risky move.

				[b]Laticia[/b]: Yeah, I see your point. But keeping quiet about it also feels wrong. Maybe we should gather some evidence first and then decide what to do.

				[b]Patrick[/b]: That sounds like a plan. Let's be cautious about it though. We don't want to raise any suspicions.
				
				[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$right:correct][i]This sounds serious. I should report this.[/i][/url]?>[/right]
				
				[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$wrong1:wrong][i]I shouldn't make my own conclusions, let's leave them alone.[/i][/url]?>[/right]
				
				[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$wrong2:wrong][i]Maybe I should clarify their intentions.[/i][/url]?>[/right]
				"""
				),
			"$right":
				Utils.dialog_part(
				"""
				That's the right thing to do!
				
				If there's anything you find suspicious, reporting them to the relavant personnel is the safest choice.
				Let them take the appropriate measures.
				
				[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]Exit[/url]?>[/right]
				"""
				),
			"$wrong":
				Utils.dialog_part(
				"""
				Wrong choice.
				
				There are many factors that suggest that this is something to be reported.
				These two points shows that they have malicious intent.
				
				1. Patrick's hesitation about reporting his concerns.
				2. Mentioning gathering evidence discreetly.
				
				[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]Exit[/url]?>[/right]
				"""
				),
			"$wrong2":
				Utils.dialog_part(
				"""
				Almost correct.
				
				It is unadvisable to directly confront the individuals involved in the matter, as you might unnecessarily alert them that someone has noticed their plans. 
				
				You should have reported it to the relevant higher ups instead.
				
				[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]Exit[/url]?>[/right]
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
		if Score.get_result("insiderthreat1","policy") == 1:
			interactable.correct()
			interactable.visible  = true
		if Score.get_result("insiderthreat1","policy") == 2:
			interactable.visible  = true
			interactable.reset()
