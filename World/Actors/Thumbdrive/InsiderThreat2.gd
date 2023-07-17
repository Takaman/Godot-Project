extends Sprite2D


@onready var hud := $"/root/Office1/HUD"
@onready var interactable := $"/root/Office1/QuestionmarkFolder/InsiderThreatHint"

func _ready():
	interactable.exclamation_mark()
	pass
	
func interact() -> void:
	print("interaction started")
	hud.show_dialog(
		"InsiderThreatHint",
		{
			"$begin":
			Utils.dialog_part(
				"""
				[i]Sounds like they are having a conversation[/i]
				
				Ryan: Have you ever thought about identifying insider threats?

				Emma: Yeah, it's something organizations should be aware of. Why do you bring it up?

				Ryan: I learned that changes in behavior or attitude, secretive behavior, and discontentment can be signs of an insider threat.

				Emma: Makes sense. What about unusual access patterns or excessive privileges?

				Ryan: Exactly. If someone suddenly gains access to sensitive information beyond their role, it could indicate an insider threat.

				Emma: And employees showing intense curiosity about confidential data?

				[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$continue][i]Continue Listening.[/i][/url]?>[/right]
				"""
			),
		 	"$continue":
				Utils.dialog_part(
				"""
				Ryan: Yes, employees excessively interested in sensitive information unrelated to their job should be monitored for potential insider threats.

				Emma: What about those facing financial troubles or personal problems?

				Ryan: Financial difficulties or personal crises can make employees vulnerable to insider threats. Supporting them and maintaining communication is important.

				Emma: So, behavioral changes, unusual access, excessive curiosity—these are the warning signs?

				Ryan: Yes, organizations should promote security awareness, provide training, and have monitoring systems in place to detect and prevent insider threats.
				
				[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end][i]Nothing wrong with their conversation.[/i][/url]?>[/right]

				"""
				),
		},
		"training"
	)
	
func _on_area_2d_area_entered(area):
	print("interactable!")
	if area.is_in_group("Player"):
		interact()
		
func _physics_process(delta: float) -> void:
	if interactable!= null and interactable is Node:
		interactable.visible  = !Score.get_has_correct("insiderthreat1","policy")

