extends Node


var _interactions := {
	"training": {},
	"testing": {}
}


func new_interaction(interaction: String, result: String, phase: String) -> void:
	_interactions[phase][interaction] = result


func get_interaction_result(interaction: String, phase: String) -> String:
	if _interactions.has(phase) and _interactions[phase].has(interaction):
		return _interactions[phase][interaction]
	else:
		return ""


func interactions(phase: String) -> Array:
	return _interactions[phase].keys() if _interactions.has(phase) else []


func get_testing_scores() -> Dictionary:
	var scores = {"correct": 0, "wrong": 0}
	
	for result in _interactions["testing"].values():
		if result in scores:
			scores[result] += 1
			
	return scores
