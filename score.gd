extends Node

const TOTAL_SCORE = 20

var _interactions := {
	"training": {},
	"socialengineering": {},
	"policy": {},
	"malware": {},
	"testing": {}
}

var _has_interacted := {}

func new_interaction(interaction: String, result: String, phase: String) -> void:
	print("Updating score: interaction =", interaction, "result =", result, "phase =", phase)
	if not _interactions.has(phase) or typeof(_interactions[phase]) != TYPE_DICTIONARY:
		_interactions[phase] = {}
		
	# Don't overwrite non-default results
	if result != "default" or not _interactions[phase].has(interaction):  
		_interactions[phase][interaction] = result
		
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
	
	for result in _interactions[type].values():
		if result in scores:
			scores[result] += 1
			
	return scores

func get_testing_scores() -> Dictionary:
	var scores = {"correct": 0, "wrong": 0}
	
	for result in _interactions["testing"].values():
		if result in scores:
			scores[result] += 1
			
	return scores
