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
		
	var dialogue := ""
	
	dialogue = (
		"""
		<~Hello, Mr name here! :-)~>
		
		Here are your topic completion rates! 
		In the "Social Engineering' category, you have completed <!%s!>/10 questions  and got <!%s!> correct!
		In the 'Policy' category, you have completed <!%s!>/10 questions and got <!%s!> correct!
		
		Keep up the good work! There is more to learn!
		<?[url=$end]Exit[/url]?>
		"""
		% [
			socialengineering_completed,
			socialengineering_correct,
			policy_completed,
			policy_correct
		]
		
	)
	
	hud.show_dialog(
		"TopicCheck",
		{
			"$begin": Utils.dialog_part(dialogue),
		},
		"")
		
