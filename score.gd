extends Node

const TOTAL_SCORE = 200
const FIRST_ATTEMPT_POINTS = 10 #Points for the first attempt

#_interactions Dictionary storing all interactions by their categories
#E.g socialengineering: {laptop1:wrong, laptop2:correct} etc 
var _interactions := {
	"training": {},
	"socialengineering": {},
	"policy": {},
	"malware": {},
	"testing": {}
}

#_has_interacted dictionary stores whether user has interacted with the category+key
#E.g socialengineering: {"laptop1:true, laptop2:false}
var _has_interacted := {}

func new_interaction(interaction: String, result: String, phase: String) -> void:
	print("Updating score: interaction =", interaction, "result =", result, "phase =", phase)
	if not _interactions.has(phase) or typeof(_interactions[phase]) != TYPE_DICTIONARY:
		_interactions[phase] = {}
		
	# Don't overwrite non-default results
	#if result != "default" or not _interactions[phase].has(interaction):  
	#	_interactions[phase][interaction] = result
	
	if not _interactions[phase].has(interaction):  
		_interactions[phase][interaction] = {
		"attempt": 0,  # Initial attempt
		"result": result,  # Result of the attempt
		"points": 0, 
		"has_correct": result == "correct"  # Checkj whether player has get correct before
		}
	var previous = _interactions[phase][interaction]
	# Only count attempts and assign points when result is "correct" or "wrong" (This means its a question)
	if result == "correct" or result == "wrong":
		var new_attempt = previous["attempt"] + 1
		# Keep dividing by 2. --> 10 points, 5, 2.5, etc etc
		# Checks if it gets correct before, if yes, assign 0 points for this attempt
		var new_points = (FIRST_ATTEMPT_POINTS / new_attempt) if result == "correct" and not previous["has_correct"] else 0
		_interactions[phase][interaction] = {
		"attempt": new_attempt,  # New attempt count
		"result": result,  # New result
		"points": previous["points"] + new_points,  # Update points with new points for this attempt
		"has_correct": previous["has_correct"] or result == "correct"  # Update whether the player has gotten this interaction correct before
		}
		
	#Initialize the phase in _has_interacted 
	if not _has_interacted.has(phase) or typeof(_has_interacted[phase]) != TYPE_DICTIONARY:
		_has_interacted[phase] = {}
		
	# If this interaction hasn't been started yet, mark it as started
	if not _has_interacted[phase].has(interaction):
		_has_interacted[phase][interaction] = false
		
		
		
	print("Current scores: ", _interactions)

func get_interaction_result(interaction: String, phase: String) -> String:
	if _interactions.has(phase) and _interactions[phase].has(interaction):
		return _interactions[phase][interaction]
	else:
		return ""


func interactions(phase: String) -> Array:
	return _interactions[phase].keys() if _interactions.has(phase) else []

func mark_as_completed(interaction: String, phase: String) -> void:
	# Mark this interaction as completed
	_has_interacted[phase][interaction] = true


func has_interacted(interaction: String, phase: String) -> bool:
	if _has_interacted.has(phase) and _has_interacted[phase].has(interaction):
		return _has_interacted[phase][interaction]
	else:
		return false
	
func get_training_scores(type) -> Dictionary:
	var scores = {"correct": 0, "wrong": 0}
	
	for interaction_result in _interactions[type].values():
		var result = interaction_result["result"]
		if result in scores:
			scores[result] += 1
			
	return scores

func get_testing_scores() -> Dictionary:
	var scores = {"correct": 0, "wrong": 0}
	
	for result in _interactions["testing"].values():
		if result in scores:
			scores[result] += 1
			
	return scores

func get_total_points() -> float:
	var total_points = 0.0
	for phase in _interactions:
		for interaction in _interactions[phase]:
			total_points += _interactions[phase][interaction]["points"]
	return total_points
