extends Sprite2D


@onready var hud := $"/root/FoodCourt/HUD"
@onready var interactable := $"/root/FoodCourt/QuestionmarkFolder/Interactable-sensitiveinformation(advanced)"
func interact() -> void:
	print("interaction started")
	hud.show_dialog(
		"sensitiveinformationadvanced",
		{
			"$begin":
			Utils.dialog_part(
				"""
				[b]Mary[/b]
				How can you proactively identify and detect any potential mishandling or unauthorized disposal of sensitive client documents?
				<?[url=$change:correct]1) I will assign dedicated staff to perform routine checks of trash bins and recycling areas for any discarded sensitive documents [/url]?>
				
				<?[url=$nochange:wrong]2) I will implement a document tracking system to monitor the movement and disposal of sensitive client documents. [/url]?>
				
				<?[url=$nochange1:wrong]3) I will conduct surprise audits to ensure employees are following proper document disposal practices [/url]?>
				
				"""
			),
			"$change":
				Utils.dialog_part(
				"""
That's the right decision. These regular checks ensure that any discarded sensitive documents are promptly identified and properly handled to prevent unauthorized access or data breaches.
<?[url=$end]EXIT[/url]?>
				"""
				),
			"$nochange":
				Utils.dialog_part(
				"""
That's incorrect. While implementing a document tracking system can be beneficial for monitoring the movement and disposal of sensitive client documents, it may not be as effective in proactively identifying and detecting potential mishandling or unauthorized disposal.
<?[url=$end]EXIT[/url]?>
				"""
				),
			"$nochange1":
				Utils.dialog_part(
				"""
That's incorrect. Conducting surprise audits can be helpful in ensuring employees are following proper document disposal practices. However, it may not be as proactive in identifying potential mishandling or unauthorized disposal.
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
		interactable.visible  = !Score.get_has_correct("sensitiveinformationadvanced","policy")
