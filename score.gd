extends Node

@onready var sessionVar = get_node("/root/SeshVar")
const api_svr = "http://165.22.246.221:5000"

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
	
	
	print("Updating score: interaction =", interaction, " result =", result, " phase =", phase)
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
		#Uncomment if you handling server side
		#send_interactions_to_server(_interactions)
		#send_has_interacted_to_server(_has_interacted)
		
		

		
	#Initialize the phase in _has_interacted 
	if not _has_interacted.has(phase) or typeof(_has_interacted[phase]) != TYPE_DICTIONARY:
		_has_interacted[phase] = {}
		
	# If this interaction hasn't been started yet, mark it as started
	if not _has_interacted[phase].has(interaction):
		_has_interacted[phase][interaction] = false
		
		
		
	print("Current scores: ", _interactions)
	print("Has interacted: ", _has_interacted)

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

#Check the result of interaction
func get_result(interaction: String, phase: String) -> int:
	if _interactions[phase].has(interaction) and _interactions[phase][interaction]["result"] == "correct":
		#returns 1 if interaction is correct
		return 1
	elif _interactions[phase].has(interaction) and _interactions[phase][interaction]["result"] == "wrong":
		#returns 2 if interaction is wrong
		return 2
	else:
		#returns 0 if interaction is not completed
		return 0

#Check if player has reached the correct label for interaction
func get_has_correct(interaction: String, phase: String) -> bool:
	if _interactions[phase].has(interaction) and _interactions[phase][interaction]["has_correct"] == true:
		return true
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


func send_has_interacted_to_server(pastinteractions: Dictionary):
	print("SENDING INTERACTIONS")
	var username = sessionVar._session.get("username")
	var url = api_svr + "/update_Interactions"
	var headers = ["Content-Type: application/json", "Authorization: Bearer " + sessionVar._session.get("token")]
	
	var pastinteractionsJSON = JSON.stringify(pastinteractions)
	var data_to_send = {"email":username, "has_interacted": pastinteractionsJSON}
	var jsonPayload = JSON.stringify(data_to_send)
	var http_request = HTTPRequest.new() 
	self.add_child(http_request)
	http_request.connect("request_completed", Callable(self, "_on_request_completed2"))
	http_request.request(url,headers,HTTPClient.METHOD_POST, jsonPayload)

#To be completed 
func send_interactions_to_server(breakdown: Dictionary):

	var username = sessionVar._session.get("username")

	var url = api_svr + "/update_Score"
	var headers = ["Content-Type: application/json", "Authorization: Bearer " + sessionVar._session.get("token")]
	
	var policy_scores = Score.get_training_scores("policy")
	var socialeng_scores = Score.get_training_scores("socialengineering")
	var malware_scores = Score.get_training_scores("malware")
	
	var socialengineering_completed = socialeng_scores["correct"] + socialeng_scores["wrong"]
	var socialengineering_correct = socialeng_scores["correct"]
	
	var policy_completed = policy_scores["correct"] + policy_scores["wrong"]
	var policy_correct = policy_scores["correct"]
	
	var malware_completed = malware_scores["correct"] + malware_scores["wrong"]
	var malware_correct = malware_scores["correct"]
	
	var comp_rate = (policy_completed + socialengineering_completed + malware_completed)/ 14 * 100
	
	print("COMPLETION RATE:"+str(comp_rate))
	print(comp_rate)
	var breakdownJSON = JSON.stringify(breakdown)	
	var data_to_send = {"email":username, "score":get_total_points(), "comp_rate": comp_rate, "se_correct": socialengineering_correct,"se_completed":socialengineering_completed, "policy_correct":policy_correct,"policy_completed":policy_completed,"malware_correct":malware_correct,"malware_completed":malware_completed,"breakdown":breakdownJSON  }
	var jsonPayload = JSON.stringify(data_to_send)
	print("DATA TO SEND:")
	print(data_to_send)
	print("data_to_send")
	var http_request = HTTPRequest.new() 
	self.add_child(http_request)
	http_request.connect("request_completed", Callable(self, "_on_request_completed"))
	http_request.request(url,headers,HTTPClient.METHOD_POST, jsonPayload)

func _on_request_completed(result, response_code, headers, body):
	if response_code == 200:
		print("Data sent successfully")
	else:
		print("An error occurred when trying to send data to server: ", response_code)

func _on_request_completed2(result, response_code, headers, body):
	if response_code == 200:
		print("Data sent successfully")
	else:
		print("An error occurred when trying to send data to server: ", response_code)

func set_Interactions_from_DB(interactionDB : Dictionary):
	_interactions = interactionDB

func set_has_interacted_from_DB(hasinteractedDB: Dictionary):
	_has_interacted = hasinteractedDB

