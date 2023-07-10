extends CharacterBody2D

@onready var hud := $"/root/FoodCourt/HUD"


var last_scores := {"socialengineering": {"correct": -1, "wrong": -1}, "policy": {"correct": -1, "wrong": -1}}

func interact() -> void:
	
	var socialengineering_scores = Score.get_training_scores("socialengineering")
	print(socialengineering_scores)
	
	var socialengineering_completed = socialengineering_scores["correct"] + socialengineering_scores["wrong"]
	var socialengineering_correct = socialengineering_scores["correct"]
	
	
	var policy_scores = Score.get_training_scores("policy")
	var policy_completed = policy_scores["correct"] + policy_scores["wrong"]
	var policy_correct = policy_scores["correct"]
	var total_points = Score.get_total_points()
	var dialogue := ""
	
	dialogue = (
		"""
		To be put into a leaderboard.
		Here are your topic completion rates! 
		In the "Social Engineering' category, you have completed <!%s!>/10 questions  and got <!%s!> correct!
		In the 'Policy' category, you have completed <!%s!>/10 questions and got <!%s!> correct!
		
		Your current total score is <!%s!>.
		
		Keep up the good work! There is more to learn!
		<?[url=$end]Exit[/url]?>
		"""
		% [
			socialengineering_completed,
			socialengineering_correct,
			policy_completed,
			policy_correct,
			total_points
		]
		
	)
	
	hud.show_dialog(
		"TopicCheck",
		{
			"$begin": Utils.dialog_part(dialogue),
		},
		"")
		
