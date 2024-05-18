extends Control

func update_stats(stats:PlayerStats):
	clear()
	var weap_item = stats.weapon
	var texture = TextureRect.new()
	texture.stretch_mode = TextureRect.STRETCH_KEEP_CENTERED
	texture.set_texture(weap_item.item_texture)
	$VBoxContainer.add_child(texture)
	var weapon = weap_item.weapon_scene.instantiate()
	for stat in weapon.get_printable_stats():
		var label = Label.new()
		label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		label.set_text(stat)
		label.label_settings = preload("res://menus/player_invent/header_label.tres")
		$VBoxContainer.add_child(label)

func clear():
	for child in $VBoxContainer.get_children():
		child.queue_free()
