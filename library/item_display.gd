extends PanelContainer


func update_stats(item):
	if !item:return
	for child in get_children():
		child.queue_free()
	var container = VBoxContainer.new()
	add_child(container)
	var img = TextureRect.new()
	img.stretch_mode = TextureRect.STRETCH_KEEP_CENTERED
	img.texture = item.item_data.item_texture
	container.add_child(img)
	for stat in item.item_data.get_printable_stats():
		var label = Label.new()
		label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		label.set_text(stat)
		label.label_settings = preload("res://menus/player_invent/header_label.tres")
		container.add_child(label)
