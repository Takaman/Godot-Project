extends CharacterBody2D

@onready var hud := $"/root/Base_Map/HUD"


var last_scores := {"socialengineering": {"correct": -1, "wrong": -1}, "policy": {"correct": -1, "wrong": -1}}

func interact() -> void:
	
	var socialengineering_scores = Score.get_training_scores("socialengineering")
	print(socialengineering_scores)
	
	var socialengineering_completed = socialengineering_scores["correct"] + socialengineering_scores["wrong"]
	var socialengineering_correct = socialengineering_scores["correct"]
	
	var policy_scores = Score.get_training_scores("policy")
	var policy_completed = policy_scores["correct"] + policy_scores["wrong"]
	var policy_correct = policy_scores["correct"]
	
	var malware_scores = Score.get_training_scores("malware")
	var malware_completed = malware_scores["correct"] + malware_scores["wrong"]
	var malware_correct = malware_scores["correct"]
	
	var total_points = Score.get_total_points()
	var dialogue := ""
	
	dialogue = (
		"""
[table=4]
		[cell][center][u]Social Engineering[/u][/center][/cell]
		[cell][center][u]Policy[/u][/center][/cell]
		[cell][center][u]Malware[/u][/center][/cell]
		[cell][/cell]
		
		[cell][center]<!%s!>/7[/center][/cell]
		[cell][center]<!%s!>/7[/center][/cell]
		[cell][center]<!%s!>/1[/center][/cell]
		[cell][u]Completed[/u][/cell]
		
		[cell][center]<!%s!>[/center][/cell]
		[cell][center]<!%s!>[/center][/cell]
		[cell][center]<!%s!>[/center][/cell]
		[cell][u]Correct[/u][/cell]
		[/table]
		
		Total score: <!%s!>
		Keep up the good work! There is more to learn!
		[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]Exit[/url]?>[/right]
		"""
		% [
			socialengineering_completed,
			policy_completed,
			malware_completed,
			socialengineering_correct,
			policy_correct,
			malware_correct,
			total_points
		]
		
	)
	
	hud.show_dialog(
		"TopicCheck",
		{
			"$begin": Utils.dialog_part(dialogue),
		},
		"")
		
