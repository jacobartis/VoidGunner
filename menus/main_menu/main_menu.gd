extends Control



func _on_play_button_pressed():
	GameManager.to_level()

func _on_tutorial_button_pressed():
	$Tutorial.show()

func _on_quit_button_pressed():
	get_tree().quit()


func _on_close_tutorial_button_pressed():
	$Tutorial.hide()


func _on_credits_pressed():
	$Credits.show()
