extends Sprite2D


@onready var hud := $"/root/FoodCourt/HUD"
@onready var interactable := $"/root/FoodCourt/QuestionmarkFolder/Interactabledustbin"

func _ready():
	interactable.correct()
	pass
	
func interact() -> void:
	print("interaction started")
	hud.show_dialog(
		"sensitiveinformation",
		{
			"$begin":
			Utils.dialog_part(
				"""
				There are sensitive client documents in the trash. Looks like someone accidentally threw them away. What is the best course of action?

				[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$change:correct]I'll destroy the documents using a secure shredder to prevent anyone from seeing any confidential client information.[/url]?>[/right]
				[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$nochange:wrong]I think I'll just leave it. It's unlikely that anyone would bother to look at the documents.[/url]?>[/right]
				[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$nochange1:wrong]I'll notify the employees in the vicinity about the presense of sensitive documents[/url]?>[/right]
				
				
				"""
			),
			"$change":
				Utils.dialog_part(
				"""
That's the right decision. By properly destroying the documents, we can safeguard sensitive data and maintain the trust of our clients.
[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]EXIT[/url]?>[/right]
				"""
				),
			"$nochange":
				Utils.dialog_part(
				"""
That's risky. While it may seem unlikely, leaving sensitive documents unattended can still pose a risk. 

It's crucial to handle such documents properly to prevent unauthorized access and protect client confidentiality.

It's important to prioritize data security and take appropriate measures to dispose of sensitive information.	
[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]EXIT[/url]?>[/right]
				"""
				),
			"$nochange1":
				Utils.dialog_part(
				"""
While it's important to raise awareness among employees, directly notifying them may increase the risk of unauthorized access. 

To ensure maximum security and protection of confidential client information, it's better to use a secure shredder for proper document disposal. Shredding the documents prevents unauthorized access and minimizes the chances of data breaches.
[right][img=12x12]res://World/HUD/Pointer.png[/img]<?[url=$end]EXIT[/url]?>[/right]
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
		interactable.visible  = Score.get_has_correct("sensitiveinformation","policy")
