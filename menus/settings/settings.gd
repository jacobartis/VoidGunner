extends CanvasLayer

var awaiting_key



func is_unique(event):
	return get_tree().get_nodes_in_group("input").filter(
		func (mapper):
			return mapper.get_key().is_match(event)
	).is_empty()

func _on_input_awaiting_input():
	awaiting_key = true
	$AwaitingInput.show()

func _on_input_recived_input():
	awaiting_key = false
	$AwaitingInput.hide()

func duplicate_popup():
	$Duplicate.popup_centered()

func _on_close_controls_pressed():
	$Controls.hide()

func _on_open_controls_pressed():
	$Controls.show()

func _on_music_slider_value_changed(value):
	GameManager.music_volume = value

func _on_sound_slider_value_changed(value):
	GameManager.sound_volume = value

func _on_close_pressed():
	get_tree().paused = false
	hide()

func open():
	%MenuButton.visible = GameManager.player_stats!=null
	show()
	get_tree().paused = true


func _on_quit_pressed():
	get_tree().quit()

func _on_menu_pressed():
	GameManager.reset()
	get_tree().change_scene_to_file("res://menus/main_menu/main_menu.tscn")
	_on_close_pressed()
