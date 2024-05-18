extends Button

func _on_pressed():
	$RichTextLabel2.show()
	await get_tree().create_timer(2).timeout
	$RichTextLabel2.hide()
