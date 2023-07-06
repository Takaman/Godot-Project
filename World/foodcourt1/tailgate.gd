extends Sprite2D


@onready var hud := $"/root/FoodCourt/HUD"
@onready var interactable := $"/root/FoodCourt/QuestionmarkFolder/Interactabletailgateperson"
func interact() -> void:
	print("interaction started")
	hud.show_dialog(
		"tailgate",
		{
			"$begin":
			Utils.dialog_part(
				"""
				Excuse me, I'm having trouble accessing this area. Could you please let me in? I forgot my access card.

				<?[url=$change:correct]1) I'm sorry, but I cannot help you out. [/url]?>
				<?[url=$nochange:wrong]2) Oh, no worries. I can help you out. I'll swipe my card, and you can follow me. [/url]?>
				
				"""
			),
			"$change":
				Utils.dialog_part(
				"""
That's the right decision. Let's prevent tailgating and maintain security by following access protocols and not allowing unauthorized entry.
<?[url=$end]EXIT[/url]?>
				"""
				),
			"$nochange":
				Utils.dialog_part(
				"""
That's risky. Allowing someone to tailgate can have severe consequences, such as data breaches, financial loss, and property damage. To prevent tailgating, always be aware of anyone following you through a door and ensure that only authorized individuals gain access.	
<?[url=$end]EXIT[/url]?>
				"""
				),
		},
		"socialengineering"
	)
	
func _on_area_2d_area_entered(area):
	print("interactable!")
	if area.is_in_group("Player"):
		interact()
		
func _physics_process(delta: float) -> void:
	if interactable!= null and interactable is Node:
		interactable.visible  = !Score.get_has_correct("tailgate","socialengineering")

