extends HBoxContainer

func setup(name, email, company, score, completion) -> void:
	$NameLbl.text = name
	$EmailLbl.text = email
	$CompanyLbl.text = company
	$ScoreLbl.text = score
	$CompletionLbl.text = completion
