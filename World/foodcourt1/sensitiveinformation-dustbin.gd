extends Sprite2D


@onready var hud := $"/root/FoodCourt/HUD"
@onready var interactable := $"/root/FoodCourt/QuestionmarkFolder/Interactabledustbin"
func interact() -> void:
	print("interaction started")
	hud.show_dialog(
		"sensitiveinformation",
		{
			"$begin":
			Utils.dialog_part(
				"""
				There are sensitive client documents in the trash. Looks like someone accidentally threw them away.

				<?[url=$change:correct]1)  I'll destroy the documents using a secure shredder to prevent anyone from seeing any confidential client information. [/url]?>
				<?[url=$nochange:wrong]2)  I think I'll just leave it. It's unlikely that anyone would bother to look at the documents. [/url]?>
				
				"""
			),
			"$change":
				Utils.dialog_part(
				"""
That's the right decision. By properly destroying the documents, we can safeguard sensitive data and maintain the trust of our clients.
<?[url=$end]EXIT[/url]?>
				"""
				),
			"$nochange":
				Utils.dialog_part(
				"""
That's risky. While it may seem unlikely, leaving sensitive documents unattended can still pose a risk. 

It's crucial to handle such documents properly to prevent unauthorized access and protect client confidentiality.

It's important to prioritize data security and take appropriate measures to dispose of sensitive information.	
<?[url=$end]EXIT[/url]?>
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
		interactable.visible  = !Score.get_has_correct("sensitiveinformation","policy")
