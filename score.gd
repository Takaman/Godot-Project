extends Node

const TOTAL_SCORE = 20

var _interactions := {
	"training": {},
	"socialengineering": {},
	"policy": {},
	"malware": {},
	"testing": {}
}


func new_interaction(interaction: String, result: String, phase: String) -> void:
	print("Updating score: interaction =", interaction, "result =", result, "phase =", phase)
	if not _interactions.has(phase) or typeof(_interactions[phase]) != TYPE_DICTIONARY:
		_interactions[phase] = {}
		
	# Don't overwrite non-default results
	if result != "default" or not _interactions[phase].has(interaction):  
		_interactions[phase][interaction] = result
	print("Current scores: ", _interactions)

func get_interaction_result(interaction: String, phase: String) -> String:
	if _interactions.has(phase) and _interactions[phase].has(interaction):
		return _interactions[phase][interaction]
	else:
		return ""


func interactions(phase: String) -> Array:
	return _interactions[phase].keys() if _interactions.has(phase) else []
	


	
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
